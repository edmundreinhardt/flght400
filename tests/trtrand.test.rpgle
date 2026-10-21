**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - RTRAND Equivalence Tests                      *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// Prototypes for Original (FLGHT400) and Modernized programs
dcl-pr rtrand_orig extpgm('FLGHT400/RTRAND');
  bgnnbr packed(6:0);
  endnbr packed(6:0);
  rndnbr packed(6:0);
end-pr;

// getRandomNumber is exported by the RTRAND module bound into FUTIL
dcl-pr rtrand_mod packed(6:0) extproc('getRandomNumber');
  bgnnbr packed(6:0) const options(*nopass);
  endnbr packed(6:0) const options(*nopass);
  rndnbr packed(6:0) options(*nopass);
end-pr;

//----------------------------------------------------------------------
// Test 1: Small standard range [1, 100]
//----------------------------------------------------------------------
dcl-proc test_small_range export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s bgn packed(6:0);
  dcl-s end packed(6:0);
  dcl-s rnd packed(6:0);
  dcl-s i int(10);

  bgn = 1;
  end = 100;

  for i = 1 to 50;
    rnd = 0;
    rtrand_mod(bgn : end : rnd);
    assert(rnd >= 1 and rnd <= 100 :
      'Modernized RTRAND result out of bounds [1,100]: ' + %char(rnd));
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 2: Large range [5000, 25000]
//----------------------------------------------------------------------
dcl-proc test_large_range export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s bgn packed(6:0);
  dcl-s end packed(6:0);
  dcl-s rnd packed(6:0);
  dcl-s i int(10);

  bgn = 5000;
  end = 25000;

  for i = 1 to 50;
    rnd = 0;
    rtrand_mod(bgn : end : rnd);
    assert(rnd >= 5000 and rnd <= 25000 :
      'Modernized RTRAND result out of bounds [5000,25000]: ' + %char(rnd));
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 3: Default zero range (0, 0) defaults to [1, 999999]
//----------------------------------------------------------------------
dcl-proc test_default_zero_range export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s bgn packed(6:0);
  dcl-s end packed(6:0);
  dcl-s rnd packed(6:0);
  dcl-s i int(10);

  for i = 1 to 20;
    bgn = 0;
    end = 0;
    rnd = 0;
    rtrand_mod(bgn : end : rnd);
    assert(rnd >= 1 and rnd <= 999999 :
      'Default zero range result out of bounds [1,999999]: ' + %char(rnd));
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 4: Inverted range (end < bgn) defaults to [1, 999999]
//----------------------------------------------------------------------
dcl-proc test_inverted_range export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s bgn packed(6:0);
  dcl-s end packed(6:0);
  dcl-s rnd packed(6:0);
  dcl-s i int(10);

  for i = 1 to 20;
    bgn = 8000;
    end = 200;
    rnd = 0;
    rtrand_mod(bgn : end : rnd);
    assert(rnd >= 1 and rnd <= 999999 :
      'Inverted range result out of bounds [1,999999]: ' + %char(rnd));
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 5: Single value range [77, 77]
//----------------------------------------------------------------------
dcl-proc test_single_value_range export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s bgn packed(6:0);
  dcl-s end packed(6:0);
  dcl-s rnd packed(6:0);

  bgn = 77;
  end = 77;
  rnd = 0;
  rtrand_mod(bgn : end : rnd);
  assertEqual(77 : rnd : 'Single value range [77,77] should return 77');
end-proc;
