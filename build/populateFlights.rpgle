**FREE
// -----------------------------------------------------------------
// Program:     BFLGHT
// Source file: populateFlights.rpgle
// Description: Build flight schedule from city tables
// -----------------------------------------------------------------

CTL-OPT DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('FUTIL');

// File declarations
DCL-F FRCITY DISK(*EXT) KEYED USAGE(*INPUT);
DCL-F TOCITY DISK(*EXT) KEYED USAGE(*INPUT);
DCL-F FLIGHTS DISK(228) USAGE(*OUTPUT);

// Compile-time arrays for arrival times
DCL-S arrTimeSlot1Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot1Val CHAR(32) DIM(9) ALT(arrTimeSlot1Key);
DCL-S arrTimeSlot2Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot2Val CHAR(32) DIM(9) ALT(arrTimeSlot2Key);
DCL-S arrTimeSlot3Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot3Val CHAR(32) DIM(9) ALT(arrTimeSlot3Key);
DCL-S arrTimeSlot4Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot4Val CHAR(32) DIM(9) ALT(arrTimeSlot4Key);
DCL-S arrTimeSlot5Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot5Val CHAR(32) DIM(9) ALT(arrTimeSlot5Key);
DCL-S arrTimeSlot6Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot6Val CHAR(32) DIM(9) ALT(arrTimeSlot6Key);
DCL-S arrTimeSlot7Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot7Val CHAR(32) DIM(9) ALT(arrTimeSlot7Key);
DCL-S arrTimeSlot8Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot8Val CHAR(32) DIM(9) ALT(arrTimeSlot8Key);
DCL-S arrTimeSlot9Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S arrTimeSlot9Val CHAR(32) DIM(9) ALT(arrTimeSlot9Key);

// Compile-time arrays for departure times
DCL-S depTimeSlot1Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot1Val CHAR(32) DIM(9) ALT(depTimeSlot1Key);
DCL-S depTimeSlot2Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot2Val CHAR(32) DIM(9) ALT(depTimeSlot2Key);
DCL-S depTimeSlot3Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot3Val CHAR(32) DIM(9) ALT(depTimeSlot3Key);
DCL-S depTimeSlot4Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot4Val CHAR(32) DIM(9) ALT(depTimeSlot4Key);
DCL-S depTimeSlot5Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot5Val CHAR(32) DIM(9) ALT(depTimeSlot5Key);
DCL-S depTimeSlot6Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot6Val CHAR(32) DIM(9) ALT(depTimeSlot6Key);
DCL-S depTimeSlot7Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot7Val CHAR(32) DIM(9) ALT(depTimeSlot7Key);
DCL-S depTimeSlot8Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot8Val CHAR(32) DIM(9) ALT(depTimeSlot8Key);
DCL-S depTimeSlot9Key ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S depTimeSlot9Val CHAR(32) DIM(9) ALT(depTimeSlot9Key);

// Compile-time array for days of the week
DCL-S dayOfWeekKey ZONED(1:0) DIM(7) CTDATA PERRCD(1) ASCEND;
DCL-S dayOfWeekVal CHAR(16) DIM(7) ALT(dayOfWeekKey);

// Compile-time array for ticket prices
DCL-S ticketPriceKey ZONED(1:0) DIM(9) CTDATA PERRCD(1) ASCEND;
DCL-S ticketPriceVal CHAR(22) DIM(9) ALT(ticketPriceKey);

// Data structure for flight record output
DCL-DS flightRecord LEN(228);
  flightNumber BINDEC(9:0) POS(1);
  departureIntlField CHAR(18) POS(5);
  depIntlLength BINDEC(4:0) POS(5) INZ(3);
  departureIataCode CHAR(16) POS(7);
  departureCityField CHAR(18) POS(23);
  departureCityLength BINDEC(4:0) POS(23) INZ(0);
  departureCityName CHAR(16) POS(25);
  dayOfWeekField CHAR(18) POS(41);
  dayOfWeekLength BINDEC(4:0) POS(41) INZ(0);
  dayOfWeekName CHAR(16) POS(43);
  arrivalIntlField CHAR(18) POS(59);
  arrIntlLength BINDEC(4:0) POS(59) INZ(3);
  arrivalIataCode CHAR(16) POS(61);
  arrivalCityField CHAR(18) POS(77);
  arrivalCityLength BINDEC(4:0) POS(77) INZ(0);
  arrivalCityName CHAR(16) POS(79);
  departureTimeField CHAR(34) POS(95);
  depTimeLength BINDEC(4:0) POS(95) INZ(8);
  departureTimeValue CHAR(32) POS(97);
  arrivalTimeField CHAR(34) POS(129);
  arrTimeLength BINDEC(4:0) POS(129) INZ(8);
  arrivalTimeValue CHAR(32) POS(131);
  airlineField CHAR(34) POS(163);
  airlineLength BINDEC(4:0) POS(163) INZ(3);
  airlineName CHAR(32) POS(165);
  seatCount BINDEC(9:0) POS(197);
  ticketPriceField CHAR(24) POS(201);
  ticketPriceLength BINDEC(4:0) POS(201) INZ(3);
  ticketPriceValue CHAR(22) POS(203);
  flightMiles BINDEC(9:0) POS(225);
END-DS;

// Flight key formatting data structure
DCL-DS flightKeyDS;
  weekDayKey CHAR(1) POS(1);
  timeSlotKey CHAR(1) POS(2);
  flightSequenceKey CHAR(5) POS(3);
END-DS;

// Constants
DCL-C @RESET '                ';
DCL-C @OFF '0';
DCL-C @ON '1';

// Standalone work variables
DCL-S flightCount PACKED(5:0) INZ(1);
DCL-S rangeBegin PACKED(6:0);
DCL-S rangeEnd PACKED(6:0);
DCL-S randomValue PACKED(6:0);
DCL-S retrieveIndex PACKED(1:0);
DCL-S weekDayCounter PACKED(1:0);
DCL-S timeSlotCounter PACKED(1:0);
DCL-S lookupIndex INT(10);

/COPY 'reservations/protypes.rpgleinc'

// Main logic
flightCount = 1;

READ FRCITY;
DOW NOT %EOF(FRCITY);
  seatCount = 250;
  flightMiles = 1250;

  airlineName = FRCALN;
  departureIataCode = FRCINT;
  departureCityLength = %CHECKR(' ' : FRCNAM);
  departureCityName = FRCNAM;

  SETLL @RESET TOCITY;

  READ TOCITY;
  DOW NOT %EOF(TOCITY);
    IF TOCNAM <> FRCNAM;
      arrivalCityLength = %CHECKR(' ' : TOCNAM);
      arrivalCityName = TOCNAM;
      arrivalIataCode = TOCINT;

      rangeBegin = 1;
      rangeEnd = 9;
      randomValue = 0;
      randomValue = getRandomNumber(rangeBegin : rangeEnd : randomValue);

      retrieveIndex = randomValue;

      FOR weekDayCounter = 1 TO 7;
        lookupIndex = %LOOKUP(weekDayCounter : dayOfWeekKey);
        IF lookupIndex > 0;
          dayOfWeekName = dayOfWeekVal(lookupIndex);
          dayOfWeekLength = %CHECKR(' ' : dayOfWeekVal(lookupIndex));
        ENDIF;

        FOR timeSlotCounter = 1 TO 9;
          lookupIndex = %LOOKUP(timeSlotCounter : ticketPriceKey);
          IF lookupIndex > 0;
            ticketPriceValue = ticketPriceVal(lookupIndex);
          ENDIF;

          arrivalTimeValue = *BLANKS;
          departureTimeValue = *BLANKS;

          SELECT;
            WHEN timeSlotCounter = 1;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot1Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot1Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot1Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot1Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 2;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot2Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot2Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot2Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot2Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 3;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot3Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot3Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot3Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot3Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 4;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot4Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot4Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot4Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot4Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 5;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot5Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot5Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot5Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot5Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 6;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot6Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot6Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot6Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot6Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 7;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot7Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot7Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot7Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot7Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 8;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot8Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot8Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot8Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot8Val(lookupIndex);
              ENDIF;
            WHEN timeSlotCounter = 9;
              lookupIndex = %LOOKUP(retrieveIndex : arrTimeSlot9Key);
              IF lookupIndex > 0;
                arrivalTimeValue = arrTimeSlot9Val(lookupIndex);
              ENDIF;
              lookupIndex = %LOOKUP(retrieveIndex : depTimeSlot9Key);
              IF lookupIndex > 0;
                departureTimeValue = depTimeSlot9Val(lookupIndex);
              ENDIF;
          ENDSL;

          weekDayKey = %CHAR(weekDayCounter);
          timeSlotKey = %CHAR(timeSlotCounter);
          flightSequenceKey = %EDITC(flightCount : 'X');
          flightNumber = %DEC(flightKeyDS : 7 : 0);

          WRITE FLIGHTS flightRecord;

          flightCount += 1;
        ENDFOR;
      ENDFOR;
    ENDIF;

    READ TOCITY;
  ENDDO;

  READ FRCITY;
ENDDO;

*INLR = *ON;

** ARRIVAL TIMES - 1
109:05 AM
209:12 AM
309:19 AM
409:26 AM
509:33 AM
609:40 AM
709:47 AM
809:54 AM
910:01 AM
** ARRIVAL TIMES - 2
110:08 AM
210:15 AM
310:22 AM
410:29 AM
510:36 AM
610:43 AM
710:50 AM
810:57 AM
911:03 AM
** ARRIVAL TIMES - 3
111:10 AM
211:17 AM
311:24 AM
411:31 AM
511:38 AM
611:45 AM
711:52 AM
811:59 AM
912:06 PM
** ARRIVAL TIMES - 4
112:13 PM
212:20 PM
312:27 PM
412:34 PM
512:41 PM
612:48 PM
712:55 PM
801:02 PM
901:09 PM
** ARRIVAL TIMES - 5
101:27 PM
201:34 PM
301:41 PM
401:48 PM
502:27 PM
602:34 PM
702:41 PM
802:48 PM
902:55 PM
** ARRIVAL TIMES - 6
103:05 PM
203:12 PM
303:19 PM
403:26 PM
503:33 PM
603:40 PM
703:47 PM
803:54 PM
904:01 PM
** ARRIVAL TIMES - 7
104:33 PM
204:40 PM
304:47 PM
404:54 PM
505:01 PM
605:08 PM
705:15 PM
805:22 PM
905:29 PM
** ARRIVAL TIMES - 8
106:34 PM
206:41 PM
306:48 PM
406:55 PM
507:02 PM
607:09 PM
707:16 PM
807:23 PM
907:30 PM
** ARRIVAL TIMES - 9
108:22 PM
208:29 PM
308:36 PM
408:43 PM
509:00 PM
609:07 PM
709:14 PM
809:21 PM
909:28 PM
** DEPARTURE TIMES - 1
107:05 AM
207:12 AM
307:19 AM
407:26 AM
507:33 AM
607:40 AM
707:47 AM
807:54 AM
908:01 AM
** DEPARTURE TIMES - 2
108:08 AM
208:15 AM
308:22 AM
408:29 AM
508:36 AM
608:43 AM
708:50 AM
808:57 AM
909:03 AM
** DEPARTURE TIMES - 3
109:10 AM
209:17 AM
309:24 AM
409:31 AM
509:38 AM
609:45 AM
709:52 AM
809:59 AM
910:06 AM
** DEPARTURE TIMES - 4
110:13 AM
210:20 AM
310:27 AM
410:34 AM
510:41 AM
610:48 AM
710:55 AM
811:02 AM
911:09 AM
** DEPARTURE TIMES - 5
111:27 AM
211:34 AM
311:41 AM
411:48 AM
512:27 PM
612:34 PM
712:41 PM
812:48 PM
912:55 PM
** DEPARTURE TIMES - 6
101:05 PM
201:12 PM
301:19 PM
401:26 PM
501:33 PM
601:40 PM
701:47 PM
801:54 PM
902:01 PM
** DEPARTURE TIMES - 7
102:33 PM
202:40 PM
302:47 PM
402:54 PM
503:01 PM
603:08 PM
703:15 PM
803:22 PM
903:29 PM
** DEPARTURE TIMES - 8
104:34 PM
204:41 PM
304:48 PM
404:55 PM
505:02 PM
605:09 PM
705:16 PM
805:23 PM
905:30 PM
** DEPARTURE TIMES - 9
106:22 PM
206:29 PM
306:36 PM
406:43 PM
507:00 PM
607:07 PM
707:14 PM
807:21 PM
907:28 PM
** DAY OF THE WEEK
1Monday
2Tuesday
3Wednesday
4Thursday
5Friday
6Saturday
7Sunday
** TICKET PRICES
1169
2179
3199
4199
5299
6299
7299
8269
9199
