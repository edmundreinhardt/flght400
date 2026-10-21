     H DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('FLGHT400F/FUTIL')

     FFNAME     IF   E             DISK
     FLNAME     IF   E             DISK
     FCUSTOMER  O  A F   70        DISK
     D*
     D UP              C                   CONST('ABCDEFGHIJKLMNOPQRS-
     D                                     TUVWXYZ')
     D LO              C                   CONST('abcdefghijklmnopqrs-
     D                                     tuvwxyz')
     D*
     D                 DS
     D  CUSTNM                 1     66
     D  FLDLEN                 1      2B 0 INZ(64)
     D  CNAME                  3     66
     D*
      /COPY 'protypes.rpgleinc'
     C*
     C  N77              Z-ADD     1             CUSTNO            9 077         * UPDATE TIME LCV
     C*
     C     CUSTNO        DOWLE     9999                                          * FOR EACH DAY-O-WK
     C*
     C                   MOVE      *BLANKS       CNAME
     C*
     C                   Z-ADD     1             BGNNBR            6 0           * START LCV TIMEDAY
     C                   Z-ADD     4724          ENDNBR            6 0           * START LCV TIMEDAY
     C                   Z-ADD     0             RTVNUM            6 0           * START LCV TIMEDAY
     C                   CALLP     getRandomNumber(BGNNBR:ENDNBR:RTVNUM)
     C*
     C     RTVNUM        CHAIN     LNAME                              79
     C     UP:LO         XLATE     LASTNM:2      LASTNM
     C                   MOVEL     LASTNM        CNAME
     C*
     C                   Z-ADD     1369          ENDNBR                          * START LCV TIMEDAY
     C                   Z-ADD     0             RTVNUM                          * START LCV TIMEDAY
     C                   CALLP     getRandomNumber(BGNNBR:ENDNBR:RTVNUM)
     C*
     C                   MOVE      ','           COMMA             1             * GET RANDOM NUM
     C     RTVNUM        CHAIN     FNAME                              78
     C     UP:LO         XLATE     FRSTNM:2      FRSTNM
     C                   CAT       COMMA:0       CNAME
     C                   CAT       FRSTNM:1      CNAME
     C     ' '           CHECKR    CNAME         FLDLEN                          * SET ERR MESSAGE
     C*
     C                   EXCEPT    ADDREC
     C*
     C     CUSTNO        ADD       1             CUSTNO                          * UPDATE TIME LCV
     C*
     C                   ENDDO
     C*
     C                   SETON                                            LR
     C*
     OCUSTOMER  EADD         ADDREC
     O                       CUSTNO               4B
     O                       CUSTNM              70
