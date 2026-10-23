**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - GTOJCV Equivalence Tests                      *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// Prototypes for Original (FLGHT400) and Modernized programs
dcl-pr gtojcv_orig extpgm('FLGHT400/GTOJCV');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  g$jd packed(5:0);
end-pr;

dcl-pr gtojcv_mod extpgm('GTOJCV');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  g$jd packed(5:0);
end-pr;

// ILE extproc prototype — return value form (no out-parameter)
dcl-pr gregorianToJulian packed(5:0) extproc('gregorianToJulian');
  inMonth  packed(2:0) const;
  inDay    packed(2:0) const;
  inYear   packed(4:0) const;
end-pr;

// Helper procedure to assert equivalence for a given date
dcl-proc assertGtojcvEquiv;
  dcl-pi *n;
    mm packed(2:0) const;
    dd packed(2:0) const;
    yyyy packed(4:0) const;
    testDesc varchar(50) const;
  end-pi;

  dcl-s in_mm_orig packed(2:0);
  dcl-s in_dd_orig packed(2:0);
  dcl-s in_yy_orig packed(4:0);
  dcl-s out_jd_orig packed(5:0);

  dcl-s in_mm_mod packed(2:0);
  dcl-s in_dd_mod packed(2:0);
  dcl-s in_yy_mod packed(4:0);
  dcl-s out_jd_mod packed(5:0);

  in_mm_orig = mm;
  in_dd_orig = dd;
  in_yy_orig = yyyy;
  out_jd_orig = 0;

  in_mm_mod = mm;
  in_dd_mod = dd;
  in_yy_mod = yyyy;
  out_jd_mod = 0;

  gtojcv_orig(in_mm_orig : in_dd_orig : in_yy_orig : out_jd_orig);
  gtojcv_mod(in_mm_mod : in_dd_mod : in_yy_mod : out_jd_mod);

  assertEqual(out_jd_orig : out_jd_mod :
    testDesc + ' - MM=' + %char(mm) + ' DD=' + %char(dd) + ' YYYY=' + %char(yyyy));
end-proc;

//----------------------------------------------------------------------
// Test 1: Standard dates across multiple months and years
//----------------------------------------------------------------------
dcl-proc test_standard_dates_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  assertGtojcvEquiv(1 : 15 : 2024 : 'Jan mid-month');
  assertGtojcvEquiv(4 : 10 : 2024 : 'Apr mid-month');
  assertGtojcvEquiv(7 : 4 : 2024 : 'Jul Independence Day');
  assertGtojcvEquiv(10 : 31 : 2024 : 'Oct Halloween');
  assertGtojcvEquiv(12 : 25 : 2024 : 'Dec Christmas');
  assertGtojcvEquiv(6 : 15 : 2023 : 'Jun mid-month 2023');
  assertGtojcvEquiv(8 : 20 : 2022 : 'Aug mid-month 2022');
  assertGtojcvEquiv(9 : 9 : 2021 : 'Sep mid-month 2021');
end-proc;

//----------------------------------------------------------------------
// Test 2: Month transition boundary dates (first and last day)
//----------------------------------------------------------------------
dcl-proc test_month_boundaries_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  // First day of each month
  assertGtojcvEquiv(1 : 1 : 2024 : 'Jan 1');
  assertGtojcvEquiv(2 : 1 : 2024 : 'Feb 1');
  assertGtojcvEquiv(3 : 1 : 2024 : 'Mar 1');
  assertGtojcvEquiv(4 : 1 : 2024 : 'Apr 1');
  assertGtojcvEquiv(5 : 1 : 2024 : 'May 1');
  assertGtojcvEquiv(6 : 1 : 2024 : 'Jun 1');
  assertGtojcvEquiv(7 : 1 : 2024 : 'Jul 1');
  assertGtojcvEquiv(8 : 1 : 2024 : 'Aug 1');
  assertGtojcvEquiv(9 : 1 : 2024 : 'Sep 1');
  assertGtojcvEquiv(10 : 1 : 2024 : 'Oct 1');
  assertGtojcvEquiv(11 : 1 : 2024 : 'Nov 1');
  assertGtojcvEquiv(12 : 1 : 2024 : 'Dec 1');

  // Last day of each month
  assertGtojcvEquiv(1 : 31 : 2024 : 'Jan 31');
  assertGtojcvEquiv(2 : 29 : 2024 : 'Feb 29 Leap');
  assertGtojcvEquiv(2 : 28 : 2023 : 'Feb 28 Non-leap');
  assertGtojcvEquiv(3 : 31 : 2024 : 'Mar 31');
  assertGtojcvEquiv(4 : 30 : 2024 : 'Apr 30');
  assertGtojcvEquiv(5 : 31 : 2024 : 'May 31');
  assertGtojcvEquiv(6 : 30 : 2024 : 'Jun 30');
  assertGtojcvEquiv(7 : 31 : 2024 : 'Jul 31');
  assertGtojcvEquiv(8 : 31 : 2024 : 'Aug 31');
  assertGtojcvEquiv(9 : 30 : 2024 : 'Sep 30');
  assertGtojcvEquiv(10 : 31 : 2024 : 'Oct 31');
  assertGtojcvEquiv(11 : 30 : 2024 : 'Nov 30');
  assertGtojcvEquiv(12 : 31 : 2024 : 'Dec 31');
end-proc;

//----------------------------------------------------------------------
// Test 3: Leap year dates across multiple leap years
//----------------------------------------------------------------------
dcl-proc test_leap_years_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  assertGtojcvEquiv(2 : 29 : 2000 : 'Year 2000 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2004 : 'Year 2004 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2008 : 'Year 2008 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2012 : 'Year 2012 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2016 : 'Year 2016 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2020 : 'Year 2020 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2024 : 'Year 2024 Leap Day');
  assertGtojcvEquiv(2 : 29 : 2028 : 'Year 2028 Leap Day');
end-proc;

//----------------------------------------------------------------------
// Test 4: Historical and Future milestone years
//----------------------------------------------------------------------
dcl-proc test_historical_and_future_years export;
  dcl-pi *n extproc(*dclcase) end-pi;

  assertGtojcvEquiv(1 : 1 : 1901 : 'Year 1901 Start');
  assertGtojcvEquiv(7 : 20 : 1969 : 'Moon Landing 1969');
  assertGtojcvEquiv(1 : 1 : 1970 : 'Unix Epoch 1970');
  assertGtojcvEquiv(12 : 31 : 1999 : 'Y2K Eve 1999');
  assertGtojcvEquiv(1 : 1 : 2000 : 'Y2K Day 2000');
  assertGtojcvEquiv(10 : 9 : 2026 : 'Current Epoch 2026');
  assertGtojcvEquiv(12 : 31 : 2050 : 'Mid-century 2050');
  assertGtojcvEquiv(12 : 31 : 2099 : 'End of Century 2099');
end-proc;

//----------------------------------------------------------------------
// Test 5: Full 365-day sequential scan equivalence for year 2024
//----------------------------------------------------------------------
dcl-proc test_full_year_sequential_scan export;
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
      assertGtojcvEquiv(m : d : 2024 : 'Year 2024 scan');
    endfor;
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 6: Return-value form — 3-param extproc call (no out-parameter)
//
// gregorianToJulian also returns the Julian day as a function value.
// All existing tests call it via extpgm wrappers that always pass the
// 4th *nopass out-parameter.  This test exercises the ILE extproc path
// where only 3 parameters are passed and the result is captured purely
// from the return value, verifying %parms-guarded out-parameter write
// is skipped without altering the returned day number.
//----------------------------------------------------------------------
dcl-proc test_return_value_form export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s jdRet  packed(5:0);
  dcl-s jdOut  packed(5:0);
  dcl-s mm     packed(2:0);
  dcl-s dd     packed(2:0);
  dcl-s yyyy   packed(4:0);

  // For each date, confirm the return value equals the out-parameter value
  // produced by the same call with 4 params (via existing extpgm wrapper).
  // A mismatch would mean the %parms branch corrupts the return path.

  // 2024-07-04 (Thursday)
  mm = 7; dd = 4; yyyy = 2024;
  jdOut = 0;
  gtojcv_mod(mm : dd : yyyy : jdOut);
  jdRet = gregorianToJulian(mm : dd : yyyy);
  assertEqual(jdOut : jdRet : 'Return value 2024-07-04');

  // 2024-01-01 (Jan — monthSaved < 0 branch)
  mm = 1; dd = 1; yyyy = 2024;
  jdOut = 0;
  gtojcv_mod(mm : dd : yyyy : jdOut);
  jdRet = gregorianToJulian(mm : dd : yyyy);
  assertEqual(jdOut : jdRet : 'Return value 2024-01-01');

  // 2024-02-29 (Feb — monthSaved < 0 branch, leap day)
  mm = 2; dd = 29; yyyy = 2024;
  jdOut = 0;
  gtojcv_mod(mm : dd : yyyy : jdOut);
  jdRet = gregorianToJulian(mm : dd : yyyy);
  assertEqual(jdOut : jdRet : 'Return value 2024-02-29 leap');

  // 2024-03-01 (Mar — monthSaved = 0 branch)
  mm = 3; dd = 1; yyyy = 2024;
  jdOut = 0;
  gtojcv_mod(mm : dd : yyyy : jdOut);
  jdRet = gregorianToJulian(mm : dd : yyyy);
  assertEqual(jdOut : jdRet : 'Return value 2024-03-01');

  // 2000-01-01 (Y2K)
  mm = 1; dd = 1; yyyy = 2000;
  jdOut = 0;
  gtojcv_mod(mm : dd : yyyy : jdOut);
  jdRet = gregorianToJulian(mm : dd : yyyy);
  assertEqual(jdOut : jdRet : 'Return value 2000-01-01');

  // 1969-07-20 (Moon Landing)
  mm = 7; dd = 20; yyyy = 1969;
  jdOut = 0;
  gtojcv_mod(mm : dd : yyyy : jdOut);
  jdRet = gregorianToJulian(mm : dd : yyyy);
  assertEqual(jdOut : jdRet : 'Return value 1969-07-20');

end-proc;
