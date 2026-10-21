     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('FLGHT400F/FUTIL')

     FFRS001DF  CF   E             WORKSTN INFDS(WSDS)
     FFRCITY    IF   E           K DISK
     FTOCITY    IF   E           K DISK
     FFNEXTO    UF   E           K DISK
     FCUSTOMER  IF A F   70    04AIDISK    KEYLOC(1)
     FCUSTNAME  IF   F   70    66AIDISK    KEYLOC(5)
     FORDERS    O  A F   67    09AIDISK    KEYLOC(1)
     FFLIGHTSZ  IF   F  233    09AIDISK    KEYLOC(1)
     D*
     D @F01            C                   CONST(X'31')
     D @F02            C                   CONST(X'32')
     D @F03            C                   CONST(X'33')
     D @F04            C                   CONST(X'34')
     D @F05            C                   CONST(X'35')
     D @F06            C                   CONST(X'36')
     D @F07            C                   CONST(X'37')
     D @F09            C                   CONST(X'39')
     D @F10            C                   CONST(X'3A')
     D @F12            C                   CONST(X'3C')
     D @ENTER          C                   CONST(X'F1')
     D @HELP           C                   CONST(X'F3')
     D @PRINT          C                   CONST(X'F6')
     D*
     D @OFF            C                   CONST('0')
     D @ON             C                   CONST('1')
     D*
     D @FALSE          C                   CONST('0')
     D @TRUE           C                   CONST('1')
     D*
     D CHARS           C                   CONST('ABCDEFGHIJKLMNOPQRST-
     D                                     UVWXYZabcdefghijklmn-
     D                                     opqrstuvwxyz ')
     D*
     D                SDS
     D  @PGM                   1     10                                          _ERR_
     D  @STAT                 11     15  0                                       _ERR_
     D  @PARMS                37     39  0                                       _ERR_
     D  @MSGID                40     46                                          _ERR_
     D  @DATA                 91    169                                          _ERR_
     D  @JOBNA               244    253                                          _ERR_
     D  @USRNA               254    263                                          _ERR_
     D  @JOBNO               264    269                                          _ERR_
     D  @SRCF                304    313                                          _ERR_
     D  @SRCL                314    323                                          _ERR_
     D  @SRCM                324    333                                          _ERR_
     D*
     D APIERR          DS
     D  ERRSIZ                 1      4B 0 INZ(256)
     D  ERRLEN                 5      8B 0 INZ(0)
     D  ERRMIC                 9     15    INZ
     D  ERRNBR                16     16    INZ
     D  ERRDTA                17    256    INZ
     D*
     D                 DS
     D  MSGCTR                 1      4B 0 INZ(0)
     D  MSGLEN                 5      8B 0 INZ(80)
     D  MSGF                   9     28    INZ('FRSMSGF   FLGHT400  ')
     D  MSGTYP                29     38    INZ('*INFO     ')
     D  MSGKEY                39     42    INZ('    ')
     D*
     D                 DS
     D  RMVCTR                 1      4B 0 INZ(0)
     D  RMVMSQ                 5     14    INZ('*         ')
     D  RMVCLR                15     24    INZ('*ALL      ')
     D  RMVKEY                25     28    INZ('    ')
     D*
     D DTTMDS          DS
     D  DTCENT                 1      1    INZ('0')
     D  DTDATE                 2      7
     D  DTTIME                 8     13  0
     D  DTMILS                14     16  0
     D*
     D                 DS
     D  CVTDIF                 1     10    INZ('*MDY      ')
     D  CVTDOF                11     20    INZ('*JUL      ')
     D*
     D INDATE          DS
     D  INPTMM                 1      2  0
     D  INPTDD                 3      4  0
     D  INPTYY                 5      6  0
     D*
     D WSDS            DS
     D  KEY                  369    369
     D*
     D                 DS
     D  FLGHTK                 1     58
     D  DSFRL                  1      2B 0
     D  DSFRC                  3     18
     D  DSTOL                 19     20B 0
     D  DSTOC                 21     36
     D  DSDOWL                37     38B 0
     D  DSDOWK                39     54
     D  FLGT09                55     58B 0
     D*
     D                 DS
     D  PRICEA                 1     24
     D  PRICEL                 1      2B 0
     D  PRICEN                 3      5
     D  BLNK19                 6     24
     D*
     D                 DS
     D  DPTIMA                 1     34
     D  DPTIML                 1      2B 0
     D  DPTIM8                 3     10
     D  DPREST                11     34
     D*
     D                 DS
     D  ARTIMA                 1     34
     D  ARTIML                 1      2B 0
     D  ARTIM8                 3     10
     D  ARREST                11     34
     D*
     D                 DS
     D  AIRLNA                 1     34
     D  AIRLNL                 1      2B 0
     D  AIRLN3                 3      5
     D  ALREST                 6     34
     D*
     D                 DS
     D  CUSTKY                 1     66
     D  CUSTLN                 1      2B 0
     D  CUSTNM                 3     66
     D*
     D                 DS
     D  CLASSK                 1      3
     D  CLASSL                 1      2B 0
     D  CLASSN                 3      3
     D*
     D                 DS
     D  SENDSK                 1     18
     D  SENDSL                 1      2B 0 INZ(1)
     D  SENDSN                 3     18    INZ('N               ')
     D*
     D                 DS
     D  DSDPTT                 1      8
     D  DSDPHH                 1      2  0
     D  DSDPMM                 4      5
     D  DSAMPM                 7      8
     D*
     D                 DS
     D  TSDPRT                 1     26
     D  TSYY                   1      4
     D  TSDSH1                 5      5    INZ('-')
     D  TSMM                   6      7
     D  TSDSH2                 8      8    INZ('-')
     D  TSDD                   9     10
     D  TSDSH3                11     11    INZ('-')
     D  TSHH                  12     13
     D  TSDOT                 14     14    INZ('.')
     D  TSMN                  15     16
     D  TSREST                17     26    INZ('.00.000000')
     D*
     D                 DS
     D  DDPCNA                 1     18
     D  DDPCNL                 1      2B 0
     D  DDPCNM                 3     18
     D*
     D                 DS
     D  DARCNA                 1     18
     D  DARCNL                 1      2B 0
     D  DARCNM                 3     18
     D*
     D                 DS
     D  DYOWKA                 1     18
     D  DYOWKL                 1      2B 0
     D  DYOWKN                 3     18
     D*
     D                 DS
     D  ORDRKY                 1      9  0 INZ(000000000)
     D*
     D CNT            UDS
     D  CNTCHR                 1      9
     D  CNTDEC                 1      9  0
     D  FILL                  10    128
     D*
     D FLTPRM          S              7P 0
     D CVTDIV          S             16A
     D CVTDOV          S             16A
     D*
      /COPY 'protypes.rpgleinc'
     I*
     ICUSTOMER  NS  01
     I                             B    1    4 0CNUMBR
     I*
     ICUSTNAME  NS  02
     I                             B    1    4 0CNNMBR
     I*
     IFLIGHTSZ  NS  04
     I                                  1    9 0FFLGHT
     I                                 28   45  FDPCNM
     I                                 46   63  FDYOWK
     I                                 82   99  FARCNM
     C*
     C     *ENTRY        PLIST
     C                   PARM                    AGENT#            9 0
     C*                                                     * D=DELETE
     C                   RESET                   FRSADR                          * REFRESH SCREEN -
     C                   EXSR      INZSR
     C*
     C     @EXIT         DOUEQ     @TRUE
     C*
     C                   WRITE     MSGCTL                                        * WRITE MSGCTL
     C                   EXFMT     FRSADR                                        * DISPLAY SCREEN
     C*
     C     KEY           CASEQ     @F02          @F02SR                          * F02 REFRESH
     C     KEY           CASEQ     @F03          @F03SR                          * F03 EXIT
     C     KEY           CASEQ     @F04          @F04SR                          * F03 EXIT
     C     KEY           CASEQ     @F05          @F05SR                          * F03 EXIT
     C     KEY           CASEQ     @F07          @F07SR                          * F03 EXIT
     C     KEY           CASEQ     @F09          @F09SR                          * F03 EXIT
     C     KEY           CASEQ     @F12          @F12SR                          * F12 CANCEL
     C                   CAS                     @ERRCK                          * CK FOR ERRORS
     C                   ENDCS
     C*
     C     KEY           IFEQ      @F06                                          * F03 EXIT
     C     *IN50         ANDEQ     *OFF                                          * 50 OFF=NO ERRS
     C                   EXSR      @F06SR                                        * CREATE RECRD
     C                   ENDIF                                                   * END IF
     C*
     C     KEY           IFEQ      @F10                                          * F10 PRESSED
     C     *INLR         ANDNE     *ON                                           * F10 PRESSED
     C     *IN50         ANDEQ     *OFF                                          * 50 OFF=NO ERRS
     C                   EXSR      @F10SR                                        * CREATE RECRD
     C                   EXSR      @F02SR                                        * CREATE RECRD
     C                   ENDIF                                                   * END IF
     C*
     C                   ENDDO                                                   * END DO
     C*
     C     END           TAG
     C*
     C                   MOVE      *ON           *INLR                           * LAST RECORD=ON
     C*
     C*
     C*
     C     INZSR         BEGSR                                                   * SET OUTPT SCREEN
     C*
     C                   SETOFF                                           39     * UNPROT TIL F6
     C                   SETON                                            40     * PROT TIL F6
     C                   SETOFF                                         3950     * ERROR IND. SC 1
     C                   SETOFF                                       515253     * ERROR IND. SC 1
     C                   SETOFF                                       545556     * ERROR IND. SC 1
     C*
     C                   MOVE      ' '           MSGID             7
     C                   MOVE      *BLANKS       MSGDTA           80
     C                   MOVE      @PGM          MSGQUE           10
     C*
     C                   MOVE      @FALSE        @EXIT             1
     C                   MOVE      @PGM          PGMQ
     C*
     C                   MOVEL     20            DOFYR
     C                   MOVE      UYEAR         DOFYR
     C                   Z-ADD     UMONTH        DOFMON                          * SET ERR MESSAGE
     C                   Z-ADD     UDAY          DOFDAY                          * SET ERR MESSAGE
     C                   MOVE      'X'           COSECO
     C                   MOVE      01            TCKETS
     C*
     C     ENDINZ        ENDSR
     C*
     C*
     C*
     C     @ERRCK        BEGSR                                                   * CHK INPUT DATA
     C*
     C                   SETOFF                                         4450     * ERROR IND. SC 1
     C                   SETOFF                                       515253     * ERROR IND. SC 1
     C                   SETOFF                                       545556     * ERROR IND. SC 1
     C*
     C                   EXSR      @RMVMS
     C*
     C     KEY           IFNE      @F10                                          * F10 PRESSED
     C     *IN39         CABEQ     @ON           CHKRGT
     C                   END
     C*
     C     DOFMON        IFEQ      00                                            * RUN INTERACTIVE
     C     DOFDAY        OREQ      00                                            * RUN INTERACTIVE
     C     DOFYR         OREQ      0000                                          * RUN INTERACTIVE
     C                   SETON                                          5051     * SET ERR INDICATOR
     C                   MOVE      'FRS0058'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C                   MOVE      DOFMON        INPTMM                          * SET DS MONTH
     C                   MOVE      DOFDAY        INPTDD                          * SET DS DAY
     C                   MOVE      DOFYR         INPTYY                          * SET DS YEAR
     C                   MOVEL     INDATE        DTDATE                          * SET DS DATE
     C*
     C                   EXSR      @DATCK
     C     DATERR        CABEQ     'Y'           ERREND
     C*
     C                   Z-ADD     0             DOFJUL            5 0           * SET ERR MESSAGE
     C                   CALLP     gregorianToJulian(DOFMON:DOFDAY:DOFYR:DOFJUL) * SELCT START INTRV
     C*
     C                   Z-ADD     UMONTH        NOWMM             2 0           * SET ERR MESSAGE
     C                   Z-ADD     UDAY          NOWDD             2 0           * SET ERR MESSAGE
     C                   Z-ADD     2000          NOWYY             4 0           * SET ERR MESSAGE
     C     NOWYY         ADD       UYEAR         NOWYY                           * SET ERR MESSAGE
     C                   Z-ADD     0             NOWJUL            5 0           * SET ERR MESSAGE
     C                   CALLP     gregorianToJulian(NOWMM:NOWDD:NOWYY:NOWJUL)   * SELCT START INTRV
     C*
     C     DOFJUL        IFLE      NOWJUL                                        * RUN INTERACTIVE
     C                   SETON                                          5051     * SET ERR INDICATOR
     C                   MOVE      'FRS0060'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     FCITY         IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5052     * SET ERR INDICATOR
     C                   MOVE      'FRS0061'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     FCITY         CHAIN     FRCITY                             52         * RUN INTERACTIVE
     C     *IN52         IFEQ      @ON                                           * RUN INTERACTIVE
     C                   SETON                                        50         * SET ERR INDICATOR
     C                   MOVE      'FRS0062'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     TCITY         IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5053     * SET ERR INDICATOR
     C                   MOVE      'FRS0071'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     TCITY         CHAIN     TOCITY                             53         * RUN INTERACTIVE
     C     *IN53         IFEQ      @ON                                           * RUN INTERACTIVE
     C                   SETON                                        50         * SET ERR INDICATOR
     C                   MOVE      'FRS0072'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     FCITY         IFEQ      TCITY                                         * RUN INTERACTIVE
     C                   SETON                                          5053     * SET ERR INDICATOR
     C                   MOVE      'FRS0075'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     FLIGHT        IFNE      0
     C                   Z-ADD     FLIGHT        FLGTCK            9 0
     C     FLGTCK        CHAIN     FLIGHTSZ                           45
     C                   MOVE      FDPCNM        DDPCNA
     C                   MOVE      FARCNM        DARCNA
     C                   MOVE      FDYOWK        DYOWKA
     C                   MOVE      *BLANKS       DSDOWK
     C                   CALLP     getDayOfWeek(DOFMON:DOFDAY:DOFYR:DSDOWK)      * SELCT START INTRV
     C                   MOVE      FDPCNM        DDPCNA
     C                   MOVE      FARCNM        DARCNA
     C     KEY           IFNE      @F06                                          * F03 EXIT
     C     FCITY         IFNE      DDPCNM
     C     TCITY         ORNE      DARCNM
     C     DSDOWK        ORNE      DYOWKN
     C                   SETON                                          50       * SET ERR INDICATOR
     C                   SETON                                        515253     * SET ERR INDICATOR
     C                   MOVE      'FRS0040'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C*
     C     KEY           IFNE      @F10                                          * F10 PRESSED
     C     *IN40         CABEQ     @ON           ERREND
     C                   END
     C*
     C     CHKRGT        TAG
     C*
     C     FLIGHT        IFEQ      0
     C                   SETON                                          50       * SET ERR INDICATOR
     C                   SETON                                        515253     * SET ERR INDICATOR
     C                   MOVE      'FRS0021'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     CUSNAM        IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5054     * SET ERR INDICATOR
     C                   MOVE      'FRS0065'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C                   Z-ADD     00            CNMCHK            2 0
     C     CHARS         CHECKR    CUSNAM        CNMCHK                          * SET ERR MESSAGE
     C     CNMCHK        IFEQ      00                                            * RUN INTERACTIVE
     C                   SETON                                          5054     * SET ERR INDICATOR
     C                   MOVE      'FRS0066'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C                   Z-ADD     0             COSCHK            1 0
     C                   Z-ADD     0             ADJPRC
     C                   Z-ADD     0.00          PRICE                           * RETURN START TIME
     C                   MOVE      PRICEN        PRICE                           * RETURN START TIME
     C     PRICEL        IFEQ      2                                             * RETURN START TIME
     C     PRICE         MULT      10            PRICE                           * RETURN START TIME
     C                   ELSE
     C     PRICE         MULT      100           PRICE                           * RETURN START TIME
     C                   ENDIF
     C     COSFIR        IFNE      ' '                                           * RUN INTERACTIVE
     C     PRICE         MULT      3             ADJPRC            6 2
     C     COSCHK        ADD       1             COSCHK
     C                   ENDIF
     C     COSBUS        IFNE      ' '                                           * RUN INTERACTIVE
     C     PRICE         MULT      2             ADJPRC
     C     COSCHK        ADD       1             COSCHK
     C                   ENDIF
     C     COSECO        IFNE      ' '                                           * RUN INTERACTIVE
     C                   Z-ADD     PRICE         ADJPRC
     C     COSCHK        ADD       1             COSCHK
     C                   ENDIF
     C     COSCHK        IFEQ      0                                             * RUN INTERACTIVE
     C                   SETON                                          5055     * SET ERR INDICATOR
     C                   MOVE      'FRS0081'     MSGID                           * SET ERR MESSAGE
     C                   ENDIF
     C     COSCHK        IFGT      1                                             * RUN INTERACTIVE
     C                   SETON                                          5055     * SET ERR INDICATOR
     C                   MOVE      'FRS0082'     MSGID                           * SET ERR MESSAGE
     C                   ENDIF
     C     *IN50         IFEQ      @ON                                           * RUN INTERACTIVE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   ENDIF
     C*
     C     TCKETS        IFEQ      00                                            * RUN INTERACTIVE
     C                   SETON                                          5056     * SET ERR INDICATOR
     C                   MOVE      'FRS0085'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   ELSE
     C                   Z-ADD     ADJPRC        PRICE
     C     TCKETS        MULT      PRICE         PRICE
     C     PRICE         MULT      .04           TAXDUE
     C     PRICE         ADD       TAXDUE        TOTAL
     C                   END
     C*
     C     TCKETS        IFGT      10                                            * RUN INTERACTIVE
     C                   SETON                                          5056     * SET ERR INDICATOR
     C                   MOVE      'FRS0086'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   END
     C*
     C     ERREND        ENDSR
     C*
     C*
     C     @DATCK        BEGSR
     C*
     C                   MOVE      'N'           DATERR            1             * CLEAR DS TIME
     C                   CLEAR                   DTTIME                          * CLEAR DS TIME
     C                   CLEAR                   DTMILS                          * CLEAR DS MILS
     C                   MOVEL     DTTMDS        CVTDIV                          * MOVE TO VARIABLE
     C                   CLEAR                   CVTDOV                          * Output variable
     C                   MOVE      *BLANKS       ERRMIC                          * Output variable
     C*
     C                   CALLP     QWCCVTDT(CVTDIF:CVTDIV:CVTDOF:CVTDOV:APIERR)
     C*
     C     ERRMIC        IFEQ      'CPF1060'
     C                   SETON                                          5051
     C                   MOVE      'FRS0059'     MSGID
     C                   MOVE      'Y'           DATERR                          * CLEAR DS TIME
     C                   EXSR      @SNDMS
     C                   ENDIF
     C*
     C                   ENDSR
     C*
     C*
     C     @RMVMS        BEGSR
     C                   CALLP     QMHRMVPM(RMVMSQ:RMVCTR:RMVKEY:RMVCLR:APIERR)
     C                   ENDSR
     C*
     C*
     C     @SNDMS        BEGSR
     C                   CALLP     QMHSNDPM(MSGID:MSGF:MSGDTA:MSGLEN:MSGTYP:
     C                             MSGQUE:MSGCTR:MSGKEY:APIERR)
     C                   ENDSR
     C*
     C*
     C     @F02SR        BEGSR                                                   * F2 SUBROUTINE
     C                   SETON                                            40     * PROTECT UNTIL F6
     C                   SETOFF                                         3950     * ERROR IND. SC 1
     C                   SETOFF                                       515253     * ERROR IND. SC 1
     C                   SETOFF                                       545556     * ERROR IND. SC 1
     C                   RESET                   FRSADR                          * REFRESH SCREEN -
     C                   MOVEL     20            DOFYR
     C                   MOVE      UYEAR         DOFYR
     C                   Z-ADD     UMONTH        DOFMON                          * SET ERR MESSAGE
     C                   Z-ADD     UDAY          DOFDAY                          * SET ERR MESSAGE
     C                   MOVE      'X'           COSECO
     C                   MOVE      01            TCKETS
     C                   EXSR      @RMVMS
     C                   ENDSR
     C*
     C*
     C     @F03SR        BEGSR                                                   * F3 SUBROUTINE
     C                   MOVE      @TRUE         @EXIT                           * SET EXIT FLAG ON
     C                   ENDSR
     C*
     C*
     C     @F04SR        BEGSR                                                   * F3 SUBROUTINE
     C                   MOVE      '   '         FCITYI            3
     C                   MOVE      '   '         FCITYA            3
     C                   CALLP     FRS402(FCITY:FCITYI:FCITYA)                   * SELCT START INTRV
     C                   ENDSR
     C*
     C*
     C     @F05SR        BEGSR                                                   * F3 SUBROUTINE
     C                   MOVE      '   '         TCITYI            3
     C                   CALLP     FRS403(TCITY:TCITYI)                          * SELCT START INTRV
     C                   EXSR      @ERRCK
     C                   ENDSR
     C*
     C*
     C     @F06SR        BEGSR                                                   * F3 SUBROUTINE
     C*
     C                   SETON                                            39     * PROTECT LEFT
     C                   SETOFF                                           40     * UNPROTECT RIGHT
     C*
     C                   MOVE      *BLANKS       DSDOWK
     C                   CALLP     getDayOfWeek(DOFMON:DOFDAY:DOFYR:DSDOWK)      * SELCT START INTRV
     C     ' '           CHECKR    DSDOWK        DSDOWL                          * SET ERR MESSAGE
     C*
     C                   MOVE      *BLANKS       DSFRC                           * SET ERR MESSAGE
     C     ' '           CHECKR    FCITY         DSFRL                           * SET ERR MESSAGE
     C                   MOVEL     FCITY         DSFRC                           * SET ERR MESSAGE
     C*
     C                   MOVE      *BLANKS       DSTOC                           * SET ERR MESSAGE
     C     ' '           CHECKR    TCITY         DSTOL                           * SET ERR MESSAGE
     C                   MOVEL     TCITY         DSTOC                           * SET ERR MESSAGE
     C*
     C                   Z-ADD     0             FLGT09                          * RETURN START TIME
     C*
     C                   CALLP     FRS404(FLGHTK:FLTPRM:DPTIMA:ARTIMA:
     C                             AIRLNA:PRICEA)
     C*
     C     FLTPRM        IFEQ      0
     C                   SETOFF                                           39     * PROTECT LEFT
     C                   SETON                                            40     * UNPROTECT RIGHT
     C                   GOTO      ENDF06
     C                   ENDIF
     C*
     C                   Z-ADD     FLTPRM        FLIGHT                          * SET ERR MESSAGE
     C                   MOVEL     DPTIM8        DPTIME                          * SET ERR MESSAGE
     C                   MOVEL     ARTIM8        ARTIME                          * SET ERR MESSAGE
     C                   MOVEL     AIRLN3        AIRLIN                          * SET ERR MESSAGE
     C                   Z-ADD     0.00          PRICE                           * RETURN START TIME
     C                   MOVE      PRICEN        PRICE                           * RETURN START TIME
     C     PRICEL        IFEQ      2                                             * RETURN START TIME
     C     PRICE         MULT      10            PRICE                           * RETURN START TIME
     C                   ELSE
     C     PRICE         MULT      100           PRICE                           * RETURN START TIME
     C                   ENDIF
     C*
     C                   Z-ADD     0             ADJPRC
     C     COSFIR        IFNE      ' '                                           * RUN INTERACTIVE
     C     PRICE         MULT      3             ADJPRC
     C                   ENDIF
     C     COSBUS        IFNE      ' '                                           * RUN INTERACTIVE
     C     PRICE         MULT      2             ADJPRC
     C                   ENDIF
     C     COSECO        IFNE      ' '                                           * RUN INTERACTIVE
     C                   Z-ADD     PRICE         ADJPRC
     C                   ENDIF
     C*
     C     TCKETS        IFGE      01                                            * RUN INTERACTIVE
     C                   Z-ADD     ADJPRC        PRICE
     C     TCKETS        MULT      PRICE         PRICE
     C     PRICE         MULT      .04           TAXDUE
     C     PRICE         ADD       TAXDUE        TOTAL
     C                   END
     C*
     C     ENDF06        ENDSR
     C*
     C*
     C     @F07SR        BEGSR                                                   * F3 SUBROUTINE
     C                   Z-ADD     0             CUST#             9 0           * RETURN START TIME
     C                   CALLP     FRS405(CUST#:CUSNAM)                          * SELCT START INTRV
     C                   EXSR      @ERRCK
     C                   ENDSR
     C*
     C*
     C     @F09SR        BEGSR                                                   * F9 SUBROUTINE
     C                   CALLP     QUSCMDLN()                                    * GET CMD LINE
     C                   ENDSR
     C*
     C*
     C     @F10SR        BEGSR                                                   * F10 SUBROUTINE
     C*
     C     ORDRKY        SETLL     NXTNUM
     C                   READ      NXTNUM                               4748
     C*
     C*                    CALL 'MSGPRG'
     C                   IN        CNT
     C                   Z-ADD     0             COUNT             9 0
     C     COUNT         DOWLT     CNTDEC
     C                   ADD       1             COUNT
     C                   END
     C     *DTAARA       DEFINE                  CNT
     C*
     C     CUST#         IFEQ      0
     C                   MOVE      *BLANKS       CUSTKY                          * SET ERR MESSAGE
     C     ' '           CHECKR    CUSNAM        CUSTLN                          * SET ERR MESSAGE
     C                   MOVEL     CUSNAM        CUSTNM                          * SET ERR MESSAGE
     C     CUSTKY        CHAIN     CUSTNAME                           44
     C     *IN44         IFEQ      @ON
     C                   READ      CUSTOMER                             4748
     C     CNUMBR        ADD       1             CNUMBR
     C                   EXCEPT    ADDCUS
     C                   Z-ADD     CNUMBR        CUST#
     C                   ELSE
     C                   Z-ADD     CNNMBR        CUST#
     C                   ENDIF
     C                   ENDIF
     C*
     C                   SELECT                                                  * PRCSS RANDOM NO
     C     COSFIR        WHENNE    ' '
     C                   MOVE      '1'           CLASSN                          * SET ERR MESSAGE
     C     COSBUS        WHENNE    ' '
     C                   MOVE      '2'           CLASSN                          * SET ERR MESSAGE
     C     COSECO        WHENNE    ' '
     C                   MOVE      '3'           CLASSN                          * SET ERR MESSAGE
     C                   ENDSL
     C                   Z-ADD     1             CLASSL                          * SET ERR MESSAGE
     C*
     C                   Z-ADD     TCKETS        TCKET#            9 0
     C*
     C                   MOVE      DOFYR         TSYY                            * SET ERR MESSAGE
     C                   MOVE      DOFMON        TSMM                            * SET ERR MESSAGE
     C                   MOVE      DOFDAY        TSDD                            * SET ERR MESSAGE
     C                   MOVEL     DPTIME        DSDPTT                          * SET ERR MESSAGE
     C     DSAMPM        IFEQ      'PM'
     C     DSDPHH        ANDNE     12                                            * SET ERR MESSAGE
     C     DSDPHH        ADD       12            DSDPHH                          * SET ERR MESSAGE
     C                   ENDIF
     C                   MOVE      DSDPHH        TSHH                            * SET ERR MESSAGE
     C                   MOVE      DSDPMM        TSMN                            * SET ERR MESSAGE
     C*
     C     NXTORD        ADD       1             NXTORD
     C                   UPDATE    NXTNUM
     C                   Z-ADD     NXTORD        ORDER#
     C                   EXCEPT    ADDORD
     C*
     C                   MOVE      'N'           ENDYN             1             * RETURN START TIME
     C                   CALLP     FRS406(ORDER#:ENDYN)                          * SELCT START INTRV
     C     ENDYN         IFEQ      'Y'
     C                   MOVE      @TRUE         @EXIT
     C                   ENDIF
     C*
     C                   Z-ADD     0             ORDER#            9 0
     C                   Z-ADD     0             CUST#
     C*
     C     F10END        ENDSR
     C*
     C*
     C     @F12SR        BEGSR
     C                   MOVE      @TRUE         @EXIT
     C                   ENDSR
     C*
     OCUSTOMER  EADD         ADDCUS
     O                       CNUMBR               4B
     O                       CUSTKY              70
     O*
     O*XTNUM  E                UPDNXT
     O*                        ORDER#     9
     O*
     OORDERS    EADD         ADDORD
     O                       ORDER#               4B
     O                       AGENT#               8B
     O                       CUST#               12B
     O                       FLIGHT              16B
     O                       TSDPRT              42
     O                       TCKET#              46B
     O                       CLASSK              49
     O                       SENDSK              67
