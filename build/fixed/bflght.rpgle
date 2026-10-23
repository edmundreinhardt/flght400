     H DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('FUTIL')

     FFRCITY    IP   E           K DISK
     FTOCITY    IF   E           K DISK
     FFLIGHTS   O  A F  228        DISK
     D*
     D TABA1#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA1D          S             32    DIM(9) ALT(TABA1#)
     D TABA2#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA2D          S             32    DIM(9) ALT(TABA2#)
     D TABA3#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA3D          S             32    DIM(9) ALT(TABA3#)
     D TABA4#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA4D          S             32    DIM(9) ALT(TABA4#)
     D TABA5#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA5D          S             32    DIM(9) ALT(TABA5#)
     D TABA6#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA6D          S             32    DIM(9) ALT(TABA6#)
     D TABA7#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA7D          S             32    DIM(9) ALT(TABA7#)
     D TABA8#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA8D          S             32    DIM(9) ALT(TABA8#)
     D TABA9#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * ARRVL TIME DSCRPTN
     D TABA9D          S             32    DIM(9) ALT(TABA9#)
     D TABD1#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD1D          S             32    DIM(9) ALT(TABD1#)
     D TABD2#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD2D          S             32    DIM(9) ALT(TABD2#)
     D TABD3#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD3D          S             32    DIM(9) ALT(TABD3#)
     D TABD4#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD4D          S             32    DIM(9) ALT(TABD4#)
     D TABD5#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD5D          S             32    DIM(9) ALT(TABD5#)
     D TABD6#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD6D          S             32    DIM(9) ALT(TABD6#)
     D TABD7#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD7D          S             32    DIM(9) ALT(TABD7#)
     D TABD8#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD8D          S             32    DIM(9) ALT(TABD8#)
     D TABD9#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * DPART TIME DSCRPTN
     D TABD9D          S             32    DIM(9) ALT(TABD9#)
     D TABDY#          S              1  0 DIM(7) CTDATA PERRCD(1) ASCEND       * WEEK DAY DESCRIPTI
     D TABDYD          S             16    DIM(7) ALT(TABDY#)
     D TABTP#          S              1  0 DIM(9) CTDATA PERRCD(1) ASCEND       * TICKET PRICES DSCR
     D TABTPD          S             22    DIM(9) ALT(TABTP#)
     D*
     D                 DS
     D  ARRINT                 1     18
     D  FLDL01                 1      2B 0 INZ(3)
     D  ARRI16                 3     18
     D*
     D                 DS
     D  ARRCTY                 1     18
     D  ARRCLN                 1      2B 0 INZ
     D  ARRC16                 3     18
     D*
     D                 DS
     D  DEPINT                 1     18
     D  FLDL03                 1      2B 0 INZ(3)
     D  DEPI16                 3     18
     D*
     D                 DS
     D  DEPCTY                 1     18
     D  DEPCLN                 1      2B 0 INZ
     D  DEPC16                 3     18
     D*
     D                 DS
     D  AIRLIN                 1     34
     D  FLDL05                 1      2B 0 INZ(3)
     D  AIRL32                 3     34
     D*
     D                 DS
     D  DAYOWK                 1     18
     D  DAYOLN                 1      2B 0 INZ
     D  DAYO16                 3     18
     D*
     D                 DS
     D  ARRTIM                 1     34
     D  FLDL07                 1      2B 0 INZ(8)
     D  ARRT32                 3     34
     D*
     D                 DS
     D  DEPTIM                 1     34
     D  FLDL08                 1      2B 0 INZ(8)
     D  DEPT32                 3     34
     D*
     D                 DS
     D  TICKTS                 1     24
     D  FLDL09                 1      2B 0 INZ(3)
     D  TICK22                 3     24
     D*
     D FLGHTA          DS
     D  WEEKA                  1      1
     D  TIMEA                  2      2
     D  COUNTA                 3      7
     D*
     D @RESET          C                   CONST('                ')
     D @OFF            C                   CONST('0')
     D @ON             C                   CONST('1')
     D*
      /COPY 'protypes.rpgleinc'
     I*
     C                   Z-ADD     250           SEATS#            9 0           * SET OUTPUT
     C                   Z-ADD     1250          MILES#            9 0           * SET OUTPUT
     C*
     C                   MOVEL     FRCALN        AIRL32                          * MOVE TO OUTPUT
     C                   MOVEL     FRCINT        DEPI16                          * MOVE TO OUTPUT
     C     ' '           CHECKR    FRCNAM        DEPCLN                          * SET ERR MESSAGE
     C                   MOVEL     FRCNAM        DEPC16                          * MOVE TO OUTPUT
     C*
     C  N77              Z-ADD     00001         FCOUNT            5 077         * UPDATE TIME LCV
     C*
     C     @RESET        SETLL     TOCITY                                        * RESTART TOCITY
     C*
     C     *IN88         DOWEQ     @OFF                                          * DO UNTIL EOF
     C*
     C                   READ      TOCITY                                 88     * READ TO CITIES
     C*
     C     *IN88         CABEQ     @ON           END                             * IF EOF GOTO END
     C     TOCNAM        CABEQ     FRCNAM        NXTCTY                          * NOT IF SAME CITY
     C*
     C     ' '           CHECKR    TOCNAM        ARRCLN                          * SET ERR MESSAGE
     C                   MOVEL     TOCNAM        ARRC16                          * MOVE TO OUTPUT
     C                   MOVEL     TOCINT        ARRI16                          * MOVE TO OUTPUT
     C*
     C                   Z-ADD     1             BGNNBR            6 0           * START LCV TIMEDAY
     C                   Z-ADD     9             ENDNBR            6 0           * START LCV TIMEDAY
     C                   Z-ADD     0             RNDVAL            6 0           * START LCV TIMEDAY
     C                   CALLP     getRandomNumber(BGNNBR:ENDNBR:RNDVAL)
     C*
     C                   Z-ADD     RNDVAL        RTVNUM            1 0           * START LCV TIMEDAY
     C*
     C                   Z-ADD     1             WEEKCT            1 0           * START LCV WEEKDAY
     C*
     C     WEEKCT        DOWGE     1                                             * FOR EACH DAY-O-WK
     C     WEEKCT        ANDLE     7                                             * FOR TIME-O-DAY
     C*
     C     WEEKCT        LOOKUP    TABDY#        TABDYD                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABDYD        DAYO16                          * MOVE TO OUTPUT
     C     ' '           CHECKR    TABDYD        DAYOLN                          * SET ERR MESSAGE
     C*
     C                   Z-ADD     1             TIMECT            1 0           * START LCV TIMEDAY
     C*
     C     TIMECT        DOWGE     1                                             * FOR TIME-O-DAY
     C     TIMECT        ANDLE     9                                             * FOR TIME-O-DAY
     C*
     C     TIMECT        LOOKUP    TABTP#        TABTPD                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABTPD        TICK22                          * MOVE TO OUTPUT
     C*
     C                   MOVE      *BLANKS       ARRT32                          * MOVE TO OUTPUT
     C                   MOVE      *BLANKS       DEPT32                          * MOVE TO OUTPUT
     C*
     C                   SELECT                                                  * PRCSS RANDOM NO
     C     TIMECT        WHENEQ    1                                             * RANDOM = 1
     C     RTVNUM        LOOKUP    TABA1#        TABA1D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD1#        TABD1D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA1D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD1D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    2                                             * RANDOM = 2
     C     RTVNUM        LOOKUP    TABA2#        TABA2D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD2#        TABD2D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA2D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD2D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    3                                             * RANDOM = 3
     C     RTVNUM        LOOKUP    TABA3#        TABA3D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD3#        TABD3D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA3D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD3D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    4                                             * RANDOM = 4
     C     RTVNUM        LOOKUP    TABA4#        TABA4D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD4#        TABD4D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA4D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD4D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    5                                             * RANDOM = 5
     C     RTVNUM        LOOKUP    TABA5#        TABA5D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD5#        TABD5D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA5D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD5D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    6                                             * RANDOM = 6
     C     RTVNUM        LOOKUP    TABA6#        TABA6D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD6#        TABD6D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA6D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD6D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    7                                             * RANDOM = 7
     C     RTVNUM        LOOKUP    TABA7#        TABA7D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD7#        TABD7D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA7D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD7D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    8                                             * RANDOM = 8
     C     RTVNUM        LOOKUP    TABA8#        TABA8D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD8#        TABD8D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA8D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD8D        DEPT32                          * MOVE TO OUTPUT
     C     TIMECT        WHENEQ    9                                             * RANDOM = 9
     C     RTVNUM        LOOKUP    TABA9#        TABA9D                   15     * SRCH TABL 4 DSCR
     C     RTVNUM        LOOKUP    TABD9#        TABD9D                   15     * SRCH TABL 4 DSCR
     C                   MOVEL     TABA9D        ARRT32                          * MOVE TO OUTPUT
     C                   MOVEL     TABD9D        DEPT32                          * MOVE TO OUTPUT
     C                   ENDSL
     C*
     C                   MOVE      WEEKCT        WEEKA
     C                   MOVE      TIMECT        TIMEA
     C                   MOVE      FCOUNT        COUNTA
     C                   MOVE      FLGHTA        FLGHTN            9 0
     C*
     C                   EXCEPT    ADDREC
     C*
     C     FCOUNT        ADD       00001         FCOUNT                          * UPDATE TIME LCV
     C     TIMECT        ADD       1             TIMECT                          * UPDATE TIME LCV
     C*
     C                   ENDDO
     C*
     C     WEEKCT        ADD       1             WEEKCT                          * UPDATE WEEKDAY LC
     C*
     C                   ENDDO
     C*
     C     NXTCTY        TAG
     C                   ENDDO
     C*
     C*
     C     END           TAG
     C                   SETOFF                                           88
     C*
     OFLIGHTS   EADD         ADDREC
     O                       FLGHTN               4B
     O                       DEPINT              22
     O                       DEPCTY              40
     O                       DAYOWK              58
     O                       ARRINT              76
     O                       ARRCTY              94
     O                       DEPTIM             128
     O                       ARRTIM             162
     O                       AIRLIN             196
     O                       SEATS#             200B
     O                       TICKTS             224
     O                       MILES#             228B
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
