**FREE
ctl-opt nomain;

//======================================================================
// RTSEED - Retrieve Seed for Random Number Generator
// Procedure: initializeRandomSeed
// Builds a seed in the range [0,1) from three successive readings of
// the milliseconds portion of the system time.
//======================================================================

/copy 'protypes.rpgleinc'

dcl-proc initializeRandomSeed export;
  dcl-pi *n;
    seed packed(9:9);
  end-pi;

  dcl-s ms1 packed(3:0);
  dcl-s ms2 packed(3:0);
  dcl-s ms3 packed(3:0);

  ms1 = %int(%subdt(%timestamp() : *mseconds) / 1000);
  ms2 = %int(%subdt(%timestamp() : *mseconds) / 1000);
  ms3 = %int(%subdt(%timestamp() : *mseconds) / 1000);

  seed = (ms3 / 1000000000) + (ms2 / 1000000) + (ms1 / 1000);
end-proc;
