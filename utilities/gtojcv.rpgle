**FREE
ctl-opt nomain;

//======================================================================
// GTOJCV - Gregorian (Month, Day, Year) to Julian Day Count
// Procedure: gregorianToJulian
//======================================================================

dcl-proc gregorianToJulian export;
  dcl-pi *n packed(5:0) extproc(*dclcase);
    inMonth packed(2:0) const;
    inDay packed(2:0) const;
    inYear packed(4:0) const;
    outJulianDay packed(5:0) options(*nopass);
  end-pi;

  dcl-s julianDay packed(5:0);
  dcl-s monthWork packed(2:0);
  dcl-s monthSaved packed(2:0);
  dcl-s yearWork packed(3:0);
  dcl-s yearDays packed(7:0);
  dcl-s weekDays packed(7:0);
  dcl-s dayOfWeekIndex packed(1:0);

  julianDay = 0;
  monthWork = inMonth - 3;
  monthSaved = monthWork;

  if monthWork < 0;
    monthWork += 12;
  endif;

  if monthSaved <> 0;
    eval(h) julianDay = monthWork * 30.6;
  endif;

  julianDay += inDay;
  yearWork = inYear - 1900;

  if yearWork <> 0;
    if monthSaved < 0;
      yearWork -= 1;
    endif;
  endif;

  yearDays = yearWork * 365.25;
  julianDay += yearDays;
  weekDays = %div(julianDay : 7);
  dayOfWeekIndex = %rem(julianDay : 7);

  if %parms >= 4;
    outJulianDay = julianDay;
  endif;

  return julianDay;
end-proc;
