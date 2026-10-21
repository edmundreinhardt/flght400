**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - JTOGCV Equivalence Tests                      *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// Prototypes for Original (FLGHT400) and Modernized (FLGHT400F) programs
dcl-pr jtogcv_orig extpgm('FLGHT400/JTOGCV');
  j$jd packed(5:0);
  j$mm packed(2:0);
  j$dd packed(2:0);
  j$yyyy packed(4:0);
end-pr;

dcl-pr jtogcv_mod extpgm('FLGHT400F/JTOGCV');
  j$jd packed(5:0);
  j$mm packed(2:0);
  j$dd packed(2:0);
  j$yyyy packed(4:0);
end-pr;

dcl-pr gtojcv_mod extpgm('FLGHT400F/GTOJCV');
  g$mm packed(2:0);
  g$dd packed(2:0);
  g$yyyy packed(4:0);
  g$jd packed(5:0);
end-pr;

// Helper procedure to assert equivalence for a given Julian day number
dcl-proc assertJtogcvEquiv;
  dcl-pi *n;
    jd packed(5:0) const;
    testDesc varchar(50) const;
  end-pi;

  dcl-s in_jd_orig packed(5:0);
  dcl-s out_mm_orig packed(2:0);
  dcl-s out_dd_orig packed(2:0);
  dcl-s out_yy_orig packed(4:0);

  dcl-s in_jd_mod packed(5:0);
  dcl-s out_mm_mod packed(2:0);
  dcl-s out_dd_mod packed(2:0);
  dcl-s out_yy_mod packed(4:0);

  in_jd_orig = jd;
  out_mm_orig = 0;
  out_dd_orig = 0;
  out_yy_orig = 0;

  in_jd_mod = jd;
  out_mm_mod = 0;
  out_dd_mod = 0;
  out_yy_mod = 0;

  jtogcv_orig(in_jd_orig : out_mm_orig : out_dd_orig : out_yy_orig);
  jtogcv_mod(in_jd_mod : out_mm_mod : out_dd_mod : out_yy_mod);

  assertEqual(out_mm_orig : out_mm_mod :
    testDesc + ' - Month mismatch for JD=' + %char(jd));
  assertEqual(out_dd_orig : out_dd_mod :
    testDesc + ' - Day mismatch for JD=' + %char(jd));
  assertEqual(out_yy_orig : out_yy_mod :
    testDesc + ' - Year mismatch for JD=' + %char(jd));
end-proc;

//----------------------------------------------------------------------
// Test 1: Sample Julian day counts across milestones
//----------------------------------------------------------------------
dcl-proc test_milestone_julian_days export;
  dcl-pi *n extproc(*dclcase) end-pi;

  assertJtogcvEquiv(1 : 'Day 1');
  assertJtogcvEquiv(100 : 'Day 100');
  assertJtogcvEquiv(365 : 'Day 365');
  assertJtogcvEquiv(730 : 'Day 730');
  assertJtogcvEquiv(1461 : 'Day 1461 (4 years)');
  assertJtogcvEquiv(10000 : 'Day 10000');
  assertJtogcvEquiv(25000 : 'Day 25000');
  assertJtogcvEquiv(36525 : 'Day 36525 (Century)');
  assertJtogcvEquiv(40000 : 'Day 40000');
  assertJtogcvEquiv(45000 : 'Day 45000');
  assertJtogcvEquiv(50000 : 'Day 50000');
end-proc;

//----------------------------------------------------------------------
// Test 2: Sequential block of 100 Julian days
//----------------------------------------------------------------------
dcl-proc test_sequential_julian_days export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s jd packed(5:0);

  for jd = 45000 to 45100;
    assertJtogcvEquiv(jd : 'Sequential test');
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 3: Round-trip conversion: Gregorian -> Julian -> Gregorian
//----------------------------------------------------------------------
dcl-proc test_round_trip_conversion export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s in_mm packed(2:0);
  dcl-s in_dd packed(2:0);
  dcl-s in_yy packed(4:0);
  dcl-s conv_jd packed(5:0);
  dcl-s back_mm packed(2:0);
  dcl-s back_dd packed(2:0);
  dcl-s back_yy packed(4:0);

  // Test Case A: 2024-02-29 (Leap day)
  in_mm = 2;
  in_dd = 29;
  in_yy = 2024;
  gtojcv_mod(in_mm : in_dd : in_yy : conv_jd);
  jtogcv_mod(conv_jd : back_mm : back_dd : back_yy);
  assertEqual(in_mm : back_mm : 'Roundtrip Month 2024-02-29');
  assertEqual(in_dd : back_dd : 'Roundtrip Day 2024-02-29');
  assertEqual(in_yy : back_yy : 'Roundtrip Year 2024-02-29');

  // Test Case B: 2024-07-04
  in_mm = 7;
  in_dd = 4;
  in_yy = 2024;
  gtojcv_mod(in_mm : in_dd : in_yy : conv_jd);
  jtogcv_mod(conv_jd : back_mm : back_dd : back_yy);
  assertEqual(in_mm : back_mm : 'Roundtrip Month 2024-07-04');
  assertEqual(in_dd : back_dd : 'Roundtrip Day 2024-07-04');
  assertEqual(in_yy : back_yy : 'Roundtrip Year 2024-07-04');

  // Test Case C: 2026-10-09
  in_mm = 10;
  in_dd = 9;
  in_yy = 2026;
  gtojcv_mod(in_mm : in_dd : in_yy : conv_jd);
  jtogcv_mod(conv_jd : back_mm : back_dd : back_yy);
  assertEqual(in_mm : back_mm : 'Roundtrip Month 2026-10-09');
  assertEqual(in_dd : back_dd : 'Roundtrip Day 2026-10-09');
  assertEqual(in_yy : back_yy : 'Roundtrip Year 2026-10-09');

  // Test Case D: 2000-01-01
  in_mm = 1;
  in_dd = 1;
  in_yy = 2000;
  gtojcv_mod(in_mm : in_dd : in_yy : conv_jd);
  jtogcv_mod(conv_jd : back_mm : back_dd : back_yy);
  assertEqual(in_mm : back_mm : 'Roundtrip Month 2000-01-01');
  assertEqual(in_dd : back_dd : 'Roundtrip Day 2000-01-01');
  assertEqual(in_yy : back_yy : 'Roundtrip Year 2000-01-01');
end-proc;
