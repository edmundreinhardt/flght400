**free
      //%METADATA                                                      *
      // %TEXT RPGUnit - initializeRandomSeed Tests                    *
      //%EMETADATA                                                     *
ctl-opt nomain ccsidcvt(*excp) ccsid(*char : *jobrun);

/include RPGUNIT/QINCLUDE,TESTCASE

// initializeRandomSeed is internal to FUTIL (not exported), so this
// suite binds the RTSEED module directly (see testing.json in this dir)
dcl-pr initializeRandomSeed extproc('initializeRandomSeed');
  seed packed(9:9);
end-pr;

// Busy-wait on the system clock; avoids DLYJOB and its job overhead
dcl-proc waitMilliseconds;
  dcl-pi *n;
    inMilliseconds int(10) const;
  end-pi;

  dcl-s startTime timestamp;

  startTime = %timestamp();
  dow %diff(%timestamp() : startTime : *mseconds) < inMilliseconds * 1000;
  enddo;
end-proc;

//----------------------------------------------------------------------
// Test 1: Seed is within [0, 1) after the call
//----------------------------------------------------------------------
dcl-proc test_seed_in_range export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s seed packed(9:9);
  dcl-s i int(10);

  for i = 1 to 20;
    seed = 0;
    initializeRandomSeed(seed);
    assert(seed >= 0 and seed < 1 :
      'Seed out of range [0,1): ' + %char(seed));
  endfor;
end-proc;

//----------------------------------------------------------------------
// Test 2: A previous seed value is overwritten
//----------------------------------------------------------------------
dcl-proc test_seed_overwritten export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s seed packed(9:9);

  seed = 0.999999999;
  initializeRandomSeed(seed);
  assert(seed <> 0.999999999 : 'Seed was not overwritten');
end-proc;

//----------------------------------------------------------------------
// Test 3: Seeds taken at different times are not all identical
//----------------------------------------------------------------------
dcl-proc test_seed_varies_over_time export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s firstSeed packed(9:9);
  dcl-s seed packed(9:9);
  dcl-s differs ind inz(*off);
  dcl-s i int(10);

  initializeRandomSeed(firstSeed);
  for i = 1 to 5;
    waitMilliseconds(7);
    initializeRandomSeed(seed);
    if seed <> firstSeed;
      differs = *on;
    endif;
  endfor;
  assert(differs : 'Seed never changed across 5 calls over time');
end-proc;

//----------------------------------------------------------------------
// Test 4: Only the seed parameter is written, adjacent storage is not
//----------------------------------------------------------------------
dcl-proc test_adjacent_storage_untouched export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-ds guard qualified;
    before char(9) inz('XXXXXXXXX');
    seed packed(9:9) inz(*zero);
    after char(9) inz('YYYYYYYYY');
  end-ds;

  initializeRandomSeed(guard.seed);
  assertEqual('XXXXXXXXX' : guard.before : 'Storage before seed changed');
  assertEqual('YYYYYYYYY' : guard.after : 'Storage after seed changed');
  assert(guard.seed >= 0 and guard.seed < 1 : 'Seed out of range');
end-proc;
