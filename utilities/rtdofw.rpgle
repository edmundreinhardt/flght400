**FREE
ctl-opt nomain;

//======================================================================
// RTDOFW - Return Day of the Week Name for a Gregorian Date
// Procedure: getDayOfWeek
//======================================================================

// Week day number and description arrays (compile-time data)
dcl-s dayNumber zoned(1:0) dim(7) perrcd(1) ascend ctdata;
dcl-s dayName char(16) dim(7) alt(dayNumber);

dcl-proc getDayOfWeek export;
  dcl-pi *n char(16) extproc(*dclcase);
    inMonth packed(2:0) const;
    inDay packed(2:0) const;
    inYear packed(4:0) const;
    outDayOfWeek char(16) options(*nopass);
  end-pi;

  dcl-s julianDay packed(5:0);
  dcl-s monthWork packed(2:0);
  dcl-s monthSaved packed(2:0);
  dcl-s yearWork packed(3:0);
  dcl-s yearDays packed(7:0);
  dcl-s weekDays packed(7:0);
  dcl-s dayOfWeekIndex packed(1:0);
  dcl-s resultDayName char(16);
  dcl-s tableIndex int(10);

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

  // Search the week day table
  dayOfWeekIndex += 1;
  tableIndex = %lookup(dayOfWeekIndex : dayNumber);
  if tableIndex > 0;
    resultDayName = dayName(tableIndex);
  else;
    resultDayName = *blanks;
  endif;

  if %parms >= 4;
    outDayOfWeek = resultDayName;
  endif;

  return resultDayName;
end-proc;

**CTDATA dayNumber
1Wednesday
2Thursday
3Friday
4Saturday
5Sunday
6Monday
7Tuesday
