**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - Master Equivalence Test Suite                 *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// =====================================================================
// Prototypes for Original Programs (FLGHT400)
// =====================================================================
dcl-pr gtojcv_orig extpgm('FLGHT400/GTOJCV');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  g$jd packed(5:0);
end-pr;

dcl-pr jtogcv_orig extpgm('FLGHT400/JTOGCV');
  j$jd packed(5:0);
  j$mm packed(2:0);
  j$dd packed(2:0);
  j$yyyy packed(4:0);
end-pr;

dcl-pr rtdofw_orig extpgm('FLGHT400/RTDOFW');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  dayowk char(16);
end-pr;

// =====================================================================
// Prototypes for Modernized Programs
// =====================================================================
dcl-pr gtojcv_mod extpgm('GTOJCV');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  g$jd packed(5:0);
end-pr;

dcl-pr jtogcv_mod extpgm('JTOGCV');
  j$jd packed(5:0);
  j$mm packed(2:0);
  j$dd packed(2:0);
  j$yyyy packed(4:0);
end-pr;

dcl-pr rtdofw_mod extpgm('RTDOFW');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  dayowk char(16);
end-pr;

dcl-pr rtrand_mod packed(6:0) extproc('getRandomNumber');
  bgnnbr packed(6:0) const options(*nopass);
  endnbr packed(6:0) const options(*nopass);
  rndnbr packed(6:0) options(*nopass);
end-pr;

// =====================================================================
// Test 1: GTOJCV Equivalence - Gregorian to Julian for all 12 Months
// =====================================================================
dcl-proc test_gtojcv_all_months_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s m packed(2:0);
  dcl-s d packed(2:0);
  dcl-s y packed(4:0);
  dcl-s jd_orig packed(5:0);
  dcl-s jd_mod packed(5:0);

  y = 2024;
  for m = 1 to 12;
    d = 15; // Mid month
    jd_orig = 0;
    jd_mod = 0;
    gtojcv_orig(m : d : y : jd_orig);
    gtojcv_mod(m : d : y : jd_mod);
    assertEqual(jd_orig : jd_mod : 'GTOJCV Month ' + %char(m));
  endfor;
end-proc;

// =====================================================================
// Test 2: GTOJCV Equivalence - Leap Years & Century Transitions
// =====================================================================
dcl-proc test_gtojcv_leap_years_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s m packed(2:0);
  dcl-s d packed(2:0);
  dcl-s y packed(4:0);
  dcl-s jd_orig packed(5:0);
  dcl-s jd_mod packed(5:0);

  // Leap days
  m = 2;
  d = 29;

  y = 2000;
  gtojcv_orig(m : d : y : jd_orig);
  gtojcv_mod(m : d : y : jd_mod);
  assertEqual(jd_orig : jd_mod : 'Leap day 2000');

  y = 2004;
  gtojcv_orig(m : d : y : jd_orig);
  gtojcv_mod(m : d : y : jd_mod);
  assertEqual(jd_orig : jd_mod : 'Leap day 2004');

  y = 2020;
  gtojcv_orig(m : d : y : jd_orig);
  gtojcv_mod(m : d : y : jd_mod);
  assertEqual(jd_orig : jd_mod : 'Leap day 2020');

  y = 2024;
  gtojcv_orig(m : d : y : jd_orig);
  gtojcv_mod(m : d : y : jd_mod);
  assertEqual(jd_orig : jd_mod : 'Leap day 2024');

  y = 2028;
  gtojcv_orig(m : d : y : jd_orig);
  gtojcv_mod(m : d : y : jd_mod);
  assertEqual(jd_orig : jd_mod : 'Leap day 2028');
end-proc;

// =====================================================================
// Test 3: JTOGCV Equivalence - Julian to Gregorian Date Conversion
// =====================================================================
dcl-proc test_jtogcv_julian_days_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s jd packed(5:0);
  dcl-s mm_orig packed(2:0);
  dcl-s dd_orig packed(2:0);
  dcl-s yy_orig packed(4:0);
  dcl-s mm_mod packed(2:0);
  dcl-s dd_mod packed(2:0);
  dcl-s yy_mod packed(4:0);

  dcl-s testDays packed(5:0) dim(8);
  dcl-s i int(10);

  testDays(1) = 1;
  testDays(2) = 365;
  testDays(3) = 1461;
  testDays(4) = 10000;
  testDays(5) = 25000;
  testDays(6) = 36525;
  testDays(7) = 45000;
  testDays(8) = 50000;

  for i = 1 to 8;
    jd = testDays(i);
    jtogcv_orig(jd : mm_orig : dd_orig : yy_orig);
    jtogcv_mod(jd : mm_mod : dd_mod : yy_mod);
    assertEqual(mm_orig : mm_mod : 'JTOGCV Month for JD=' + %char(jd));
    assertEqual(dd_orig : dd_mod : 'JTOGCV Day for JD=' + %char(jd));
    assertEqual(yy_orig : yy_mod : 'JTOGCV Year for JD=' + %char(jd));
  endfor;
end-proc;

// =====================================================================
// Test 4: Full Round-Trip Equivalence: GTOJCV -> JTOGCV
// =====================================================================
dcl-proc test_date_roundtrip_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s in_m packed(2:0);
  dcl-s in_d packed(2:0);
  dcl-s in_y packed(4:0);
  dcl-s jd packed(5:0);
  dcl-s out_m packed(2:0);
  dcl-s out_d packed(2:0);
  dcl-s out_y packed(4:0);

  // 2024-02-29
  in_m = 2;
  in_d = 29;
  in_y = 2024;
  gtojcv_mod(in_m : in_d : in_y : jd);
  jtogcv_mod(jd : out_m : out_d : out_y);
  assertEqual(in_m : out_m : 'Roundtrip Month 2024-02-29');
  assertEqual(in_d : out_d : 'Roundtrip Day 2024-02-29');
  assertEqual(in_y : out_y : 'Roundtrip Year 2024-02-29');

  // 2026-10-09
  in_m = 10;
  in_d = 9;
  in_y = 2026;
  gtojcv_mod(in_m : in_d : in_y : jd);
  jtogcv_mod(jd : out_m : out_d : out_y);
  assertEqual(in_m : out_m : 'Roundtrip Month 2026-10-09');
  assertEqual(in_d : out_d : 'Roundtrip Day 2026-10-09');
  assertEqual(in_y : out_y : 'Roundtrip Year 2026-10-09');
end-proc;

// =====================================================================
// Test 5: RTDOFW Equivalence - Day of Week for all 7 Days
// =====================================================================
dcl-proc test_rtdofw_all_weekdays_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s m packed(2:0);
  dcl-s d packed(2:0);
  dcl-s y packed(4:0);
  dcl-s day_orig char(16);
  dcl-s day_mod char(16);

  y = 2024;
  m = 10;

  for d = 6 to 12;
    rtdofw_orig(m : d : y : day_orig);
    rtdofw_mod(m : d : y : day_mod);
    assertEqual(day_orig : day_mod : 'RTDOFW Weekday for Oct ' + %char(d));
  endfor;
end-proc;

// =====================================================================
// Test 6: RTDOFW Equivalence - Leap Days
// =====================================================================
dcl-proc test_rtdofw_leap_days_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s m packed(2:0);
  dcl-s d packed(2:0);
  dcl-s y packed(4:0);
  dcl-s day_orig char(16);
  dcl-s day_mod char(16);

  m = 2;
  d = 29;

  y = 2000;
  rtdofw_orig(m : d : y : day_orig);
  rtdofw_mod(m : d : y : day_mod);
  assertEqual(day_orig : day_mod : 'RTDOFW Leap 2000');

  y = 2024;
  rtdofw_orig(m : d : y : day_orig);
  rtdofw_mod(m : d : y : day_mod);
  assertEqual(day_orig : day_mod : 'RTDOFW Leap 2024');
end-proc;

// =====================================================================
// Test 7: RTRAND - Random Number Range Boundary Verification
// =====================================================================
dcl-proc test_rtrand_bounded_ranges_equivalence export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s bgn packed(6:0);
  dcl-s end packed(6:0);
  dcl-s rnd packed(6:0);
  dcl-s i int(10);

  bgn = 1;
  end = 100;
  for i = 1 to 20;
    rnd = 0;
    rtrand_mod(bgn : end : rnd);
    assert(rnd >= 1 and rnd <= 100 : 'RTRAND [1..100]: ' + %char(rnd));
  endfor;

  bgn = 0;
  end = 0;
  for i = 1 to 10;
    rnd = 0;
    rtrand_mod(bgn : end : rnd);
    assert(rnd >= 1 and rnd <= 999999 : 'RTRAND Default: ' + %char(rnd));
  endfor;
end-proc;
