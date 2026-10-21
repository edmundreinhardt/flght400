**FREE
ctl-opt nomain;

//======================================================================
// JTOGCV - Julian Day Count to Gregorian (Month, Day, Year)
// Procedure: julianToGregorian
//======================================================================

dcl-proc julianToGregorian export;
  dcl-pi *n extproc(*dclcase);
    inJulianDay packed(5:0) const;
    outMonth packed(2:0);
    outDay packed(2:0);
    outYear packed(4:0);
  end-pi;

  dcl-s yearWork packed(3:0);
  dcl-s testFraction packed(12:9);
  dcl-s yearDays packed(7:0);
  dcl-s monthIndex packed(2:0);
  dcl-s monthDays packed(3:0);

  yearWork = inJulianDay / 365.25;
  testFraction = inJulianDay / 365.25;

  if testFraction = %int(testFraction);
    yearWork -= 1;
  endif;

  yearDays = yearWork * 365.25;
  yearDays = inJulianDay - yearDays;

  if yearDays > 306;
    yearWork += 1;
  endif;

  monthIndex = 0;
  dou yearDays <= monthDays;
    monthIndex += 1;
    eval(h) monthDays = monthIndex * 30.6;
  enddo;

  monthIndex -= 1;
  eval(h) monthDays = monthIndex * 30.6;

  outDay = yearDays - monthDays;
  outMonth = monthIndex + 3;

  if outMonth > 12;
    outMonth -= 12;
  endif;

  outYear = yearWork + 1900;
  return;
end-proc;
