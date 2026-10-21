**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - RTDOFW Equivalence Tests                      *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// Prototypes for Original (FLGHT400) and Modernized programs
dcl-pr rtdofw_orig extpgm('FLGHT400/RTDOFW');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  dayowk char(16);
end-pr;

dcl-pr rtdofw_mod extpgm('RTDOFW');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  dayowk char(16);
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
