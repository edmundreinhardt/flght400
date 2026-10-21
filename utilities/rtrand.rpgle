**FREE
ctl-opt nomain;

//======================================================================
// RTRAND - Random Number Generator Between Minimum and Maximum Bounds
// Procedure: getRandomNumber
//======================================================================

/copy 'protypes.rpgleinc'

dcl-proc getRandomNumber export;
  dcl-pi *n packed(6:0);
    inBeginNumber packed(6:0) const options(*nopass);
    inEndNumber packed(6:0) const options(*nopass);
    outRandomNumber packed(6:0) options(*nopass);
  end-pi;

  // Static seed variable to persist across procedure invocations
  dcl-s seed packed(9:9) static inz(*zero);
  dcl-s tempProduct packed(15:9);
  dcl-s rangeSpan packed(6:0);
  dcl-s minBound packed(6:0);
  dcl-s maxBound packed(6:0);
  dcl-s calculatedRandom packed(6:0);

  // Initialize seed on first call (RTSEED module bound into FUTIL)
  if seed = *zero;
    seed = 0;
    initializeRandomSeed(seed);
  endif;

  // Default parameters if not passed
  if %parms >= 1;
    minBound = inBeginNumber;
  else;
    minBound = 0;
  endif;

  if %parms >= 2;
    maxBound = inEndNumber;
  else;
    maxBound = 0;
  endif;

  if (minBound = 0 and maxBound = 0) or maxBound < minBound;
    minBound = 1;
    maxBound = 999999;
  endif;

  rangeSpan = maxBound - minBound;
  rangeSpan += 1;

  tempProduct = seed * 9821 + .211327;
  seed = tempProduct - %int(tempProduct);
  calculatedRandom = seed * rangeSpan;
  calculatedRandom += minBound;

  if %parms >= 3;
    outRandomNumber = calculatedRandom;
  endif;

  return calculatedRandom;
end-proc;
