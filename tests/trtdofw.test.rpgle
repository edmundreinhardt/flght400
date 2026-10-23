**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - RTDOFW Equivalence Tests                      *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// Prototypes for Original (FLGHT400_O) and Modernized (FLGHT400) programs
dcl-pr rtdofw_orig extpgm('RTDOFW');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  dayowk char(16);
end-pr;

dcl-pr rtdofw_mod extpgm('FLGHT400_O/RTDOFW');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  dayowk char(16);
end-pr;

// ILE extproc prototype — return value form (no out-parameter)
dcl-pr getDayOfWeek char(16) extproc('getDayOfWeek');
  inMonth  packed(2:0) const;
  inDay    packed(2:0) const;
  inYear   packed(4:0) const;
end-pr;

// Helper procedure to assert equivalence for a given date
dcl-proc assertRtdofwEquiv;
  dcl-pi *n;
    mm packed(2:0) const;
    dd packed(2:0) const;
    yyyy packed(4:0) const;
    expectedDay varchar(16) const options(*nopass);
  end-pi;

  dcl-s in_mm_orig packed(2:0);
  dcl-s in_dd_orig packed(2:0);
  dcl-s in_yy_orig packed(4:0);
  dcl-s out_day_orig char(16);

  dcl-s in_mm_mod packed(2:0);
  dcl-s in_dd_mod packed(2:0);
  dcl-s in_yy_mod packed(4:0);
  dcl-s out_day_mod char(16);

  in_mm_orig = mm;
  in_dd_orig = dd;
  in_yy_orig = yyyy;
  out_day_orig = *blanks;

  in_mm_mod = mm;
  in_dd_mod = dd;
  in_yy_mod = yyyy;
  out_day_mod = *blanks;

  rtdofw_orig(in_mm_orig : in_dd_orig : in_yy_orig : out_day_orig);
  rtdofw_mod(in_mm_mod : in_dd_mod : in_yy_mod : out_day_mod);

  // Assert modernized output exactly matches original output
  assertEqual(out_day_orig : out_day_mod :
    'Mismatch between original and modernized for ' +
    %char(mm) + '/' + %char(dd) + '/' + %char(yyyy));

  // If expected day name is passed, also verify ground truth
  if %parms >= 4 and expectedDay <> '';
    assertEqual(expectedDay : %trim(out_day_mod) :
      'Ground truth mismatch for ' + %char(mm) + '/' + %char(dd) + '/' + %char(yyyy));
  endif;
end-proc;

//----------------------------------------------------------------------
// Test 1: All 7 days of the week verified for equivalence and accuracy
//----------------------------------------------------------------------
dcl-proc test_seven_days_of_week export;
  dcl-pi *n extproc(*dclcase) end-pi;

  // 2024 October 6 to 12 covers Sun to Sat
  assertRtdofwEquiv(10 : 6  : 2024 : 'Sunday');
  assertRtdofwEquiv(10 : 7  : 2024 : 'Monday');
  assertRtdofwEquiv(10 : 8  : 2024 : 'Tuesday');
  assertRtdofwEquiv(10 : 9  : 2024 : 'Wednesday');
  assertRtdofwEquiv(10 : 10 : 2024 : 'Thursday');
  assertRtdofwEquiv(10 : 11 : 2024 : 'Friday');
  assertRtdofwEquiv(10 : 12 : 2024 : 'Saturday');
end-proc;

//----------------------------------------------------------------------
// Test 2: Leap years and leap day calculations
//----------------------------------------------------------------------
dcl-proc test_leap_day_calculations export;
  dcl-pi *n extproc(*dclcase) end-pi;

  assertRtdofwEquiv(2 : 29 : 2000 : 'Tuesday');
  assertRtdofwEquiv(2 : 29 : 2004 : 'Sunday');
  assertRtdofwEquiv(2 : 29 : 2020 : 'Saturday');
  assertRtdofwEquiv(2 : 29 : 2024 : 'Thursday');
  assertRtdofwEquiv(2 : 29 : 2028 : 'Tuesday');
end-proc;

//----------------------------------------------------------------------
// Test 3: Century and historical milestone dates
//----------------------------------------------------------------------
dcl-proc test_historical_milestone_dates export;
  dcl-pi *n extproc(*dclcase) end-pi;

  assertRtdofwEquiv(1  : 1  : 1901 : 'Tuesday');
  assertRtdofwEquiv(7  : 20 : 1969 : 'Sunday');
  assertRtdofwEquiv(1  : 1  : 1970 : 'Thursday');
  assertRtdofwEquiv(12 : 31 : 1999 : 'Friday');
  assertRtdofwEquiv(1  : 1  : 2000 : 'Saturday');
  assertRtdofwEquiv(10 : 9  : 2026 : 'Friday');
  assertRtdofwEquiv(12 : 31 : 2050 : 'Saturday');
end-proc;

//----------------------------------------------------------------------
// Test 4: Full 366-day sequential scan for year 2024
//----------------------------------------------------------------------
dcl-proc test_full_year_sequential_days export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s m packed(2:0);
  dcl-s d packed(2:0);
  dcl-s maxDays packed(2:0);

  for m = 1 to 12;
    select;
      when m = 2;
        maxDays = 29;
      when m = 4 or m = 6 or m = 9 or m = 11;
        maxDays = 30;
      other;
        maxDays = 31;
    endsl;

    for d = 1 to maxDays;
      assertRtdofwEquiv(m : d : 2024);
    endfor;
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 5: Return-value form — 3-param extproc call (no out-parameter)
//
// getDayOfWeek also returns the day name as a function value.
// All existing tests call it via extpgm wrappers that always pass the
// 4th *nopass out-parameter.  This test exercises the ILE extproc path
// where only 3 parameters are passed and the result is captured purely
// from the return value, verifying %parms-guarded out-parameter write
// is skipped without altering the returned day name.
//----------------------------------------------------------------------
dcl-proc test_return_value_form export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s dayRet  char(16);
  dcl-s dayOut  char(16);
  dcl-s mm      packed(2:0);
  dcl-s dd      packed(2:0);
  dcl-s yyyy    packed(4:0);

  // For each date, confirm the return value equals the out-parameter value
  // produced by the same call with 4 params (via existing extpgm wrapper).
  // A mismatch would mean the %parms branch corrupts the return path.

  // 2024-10-09 — Wednesday (ground truth verified in test_seven_days_of_week)
  mm = 10; dd = 9; yyyy = 2024;
  dayOut = *blanks;
  rtdofw_orig(mm : dd : yyyy : dayOut);
  dayRet = getDayOfWeek(mm : dd : yyyy);
  assertEqual(dayOut : dayRet : 'Return value 2024-10-09 Wednesday');

  // 2024-10-06 — Sunday
  mm = 10; dd = 6; yyyy = 2024;
  dayOut = *blanks;
  rtdofw_orig(mm : dd : yyyy : dayOut);
  dayRet = getDayOfWeek(mm : dd : yyyy);
  assertEqual(dayOut : dayRet : 'Return value 2024-10-06 Sunday');

  // 2024-02-29 — Thursday (leap day)
  mm = 2; dd = 29; yyyy = 2024;
  dayOut = *blanks;
  rtdofw_orig(mm : dd : yyyy : dayOut);
  dayRet = getDayOfWeek(mm : dd : yyyy);
  assertEqual(dayOut : dayRet : 'Return value 2024-02-29 leap Thursday');

  // 2000-01-01 — Saturday (Y2K)
  mm = 1; dd = 1; yyyy = 2000;
  dayOut = *blanks;
  rtdofw_orig(mm : dd : yyyy : dayOut);
  dayRet = getDayOfWeek(mm : dd : yyyy);
  assertEqual(dayOut : dayRet : 'Return value 2000-01-01 Saturday');

  // 1969-07-20 — Sunday (Moon Landing)
  mm = 7; dd = 20; yyyy = 1969;
  dayOut = *blanks;
  rtdofw_orig(mm : dd : yyyy : dayOut);
  dayRet = getDayOfWeek(mm : dd : yyyy);
  assertEqual(dayOut : dayRet : 'Return value 1969-07-20 Sunday');

  // 2026-10-09 — Friday
  mm = 10; dd = 9; yyyy = 2026;
  dayOut = *blanks;
  rtdofw_orig(mm : dd : yyyy : dayOut);
  dayRet = getDayOfWeek(mm : dd : yyyy);
  assertEqual(dayOut : dayRet : 'Return value 2026-10-09 Friday');

end-proc;
