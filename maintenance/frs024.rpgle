     H DFTACTGRP(*NO) ACTGRP(*CALLER)

     FFRS024DF  CF   E             WORKSTN INFDS(WSDS)
     FCUSTNAME  IF   F   70    66AIDISK    KEYLOC(5)
     FCUSTOMRZ  UF A F   75    09AIDISK    KEYLOC(1)
     D*
     D @F01            C                   CONST(X'31')
     D @F02            C                   CONST(X'32')
     D @F03            C                   CONST(X'33')
     D @F04            C                   CONST(X'34')
     D @F09            C                   CONST(X'39')
     D @F10            C                   CONST(X'3A')
     D @F11            C                   CONST(X'3B')
     D @F12            C                   CONST(X'3C')
     D @ENTER          C                   CONST(X'F1')
     D @HELP           C                   CONST(X'F3')
     D @PRINT          C                   CONST(X'F6')
     D*
     D APOST           C                   CONST(X'7D')
     D*
     D @FALSE          C                   CONST('0')
     D @TRUE           C                   CONST('1')
     D*
     D @OFF            C                   CONST('0')
     D @ON             C                   CONST('1')
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
     D WSDS            DS
     D  KEY                  369    369
     D*
     D                 DS
     D  NBRCHK                 1      9  0
     D*
     D                 DS
     D  CUSKEY                 1     66
     D  CUSLEN                 1      2B 0
     D  CUSNAM                 3     66
     D*
      /COPY 'protypes.rpgleinc'

     I*
     ICUSTNAME  NS  01
     I                             B    1    4 0CUST#L
     I                                  5   70  CUSTNL
     I*
     ICUSTOMRZ  NS  02
     I                                  1    9 0CUST#Z
     I                                 10   75  CUSTNZ
     I*
     C*                                                     * D=DELETE
     C                   RESET                   SELCTR                          * REFRESH SCREEN -
     C                   EXSR      INZSR
     C*
     C     @EXIT         DOUEQ     @TRUE
     C*
     C                   WRITE     MSGCTL                                        * WRITE MSGCTL
     C                   EXFMT     SELCTR                                        * DISPLAY SCREEN
     C*
     C     KEY           CASEQ     @F02          @F02SR                          * F02 REFRESH
     C     KEY           CASEQ     @F03          @F03SR                          * F03 EXIT
     C     KEY           CASEQ     @F04          @F04SR                          * F03 EXIT
     C     KEY           CASEQ     @F09          @F09SR                          * F03 EXIT
     C     KEY           CASEQ     @F12          @F12SR                          * F12 CANCEL
     C                   CAS                     @ERRCK                          * CK FOR ERRORS
     C                   ENDCS
     C*
     C     KEY           IFEQ      @F10                                          * F10 PRESSED
     C     *INLR         ANDNE     *ON                                           * F10 PRESSED
     C     *IN50         ANDEQ     *OFF                                          * 50 OFF=NO ERRS
     C                   EXSR      @F10SR                                        * CREATE RECRD
     C                   ENDIF                                                   * END IF
     C*
     C     KEY           IFEQ      @F11                                          * F10 PRESSED
     C     *INLR         ANDNE     *ON                                           * F10 PRESSED
     C     *IN50         ANDEQ     *OFF                                          * 50 OFF=NO ERRS
     C                   EXSR      @F11SR                                        * CREATE RECRD
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
     C                   SETOFF                                         4450     * ERROR IND. SC 1
     C                   SETOFF                                         5152     * ERROR IND. SC 1
     C*
     C                   MOVE      ' '           MSGID             7
     C                   MOVE      *BLANKS       MSGDTA           80
     C                   MOVE      @PGM          MSGQUE           10
     C*
     C                   MOVE      @FALSE        @EXIT             1
     C                   MOVE      @PGM          PGMQ
     C*
     C     ENDINZ        ENDSR
     C*
     C*
     C*
     C     @ERRCK        BEGSR                                                   * CHK INPUT DATA
     C*
     C                   SETOFF                                         4450     * ERROR IND. SC 1
     C                   SETOFF                                         5152     * ERROR IND. SC 1
     C*
     C                   EXSR      @RMVMS
     C*
     C     SCUST#        IFEQ      *ZEROS                                        * RUN INTERACTIVE
     C                   SETON                                          5051     * SET ERR INDICATOR
     C                   MOVE      'FRS0064'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C                   Z-ADD     SCUST#        NBRCHK
     C     NBRCHK        CHAIN     CUSTOMRZ                           44
     C     *IN44         IFEQ      @OFF
     C                   MOVE      *BLANKS       CUSKEY                          * SET ERR MESSAGE
     C                   MOVEL     CUSTNZ        CUSKEY                          * SET ERR MESSAGE
     C                   MOVEL     CUSNAM        NAMECK           25             * SET ERR MESSAGE
     C     SCUSTN        CABEQ     NAMECK        ERREND                          * GET CMD LINE
     C                   ENDIF
     C*
     C                   MOVE      *BLANKS       CUSNAM                          * SET ERR MESSAGE
     C     ' '           CHECKR    SCUSTN        CUSLEN                          * SET ERR MESSAGE
     C                   MOVEL     SCUSTN        CUSNAM                          * SET ERR MESSAGE
     C     CUSKEY        CHAIN     CUSTNAME                           44         * RUN INTERACTIVE
     C     *IN44         IFEQ      @FALSE                                        * RUN INTERACTIVE
     C                   SETON                                          5052     * SET ERR INDICATOR
     C                   MOVE      'FRS0067'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C                   Z-ADD     00            CNMCHK            2 0
     C     CHARS         CHECKR    SCUSTN        CNMCHK                          * SET ERR MESSAGE
     C     CNMCHK        IFEQ      00                                            * RUN INTERACTIVE
     C                   SETON                                          5052     * SET ERR INDICATOR
     C                   MOVE      'FRS0066'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     ERREND        ENDSR
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
     C                   SETOFF                                         4450     * ERROR IND. SC 1
     C                   SETOFF                                         5152     * ERROR IND. SC 1
     C                   RESET                   SELCTR                          * REFRESH SCREEN -
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
     C*
     C                   Z-ADD     0             CUST#             9 0           * SET ERR MESSAGE
     C*
     C                   CALLP     FRS405(CUST#:SCUSTN)                          * SELCT START INTRV
     C*
     C                   Z-ADD     CUST#         SCUST#                          * SET ERR MESSAGE
     C*
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
     C                   Z-ADD     SCUST#        NBRCHK
     C     NBRCHK        CHAIN     CUSTOMRZ                           44
     C     *IN44         IFEQ      @ON
     C                   Z-ADD     SCUST#        CUST#Z                          * GET CMD LINE
     C                   MOVE      *BLANKS       CUSNAM                          * SET ERR MESSAGE
     C     ' '           CHECKR    SCUSTN        CUSLEN                          * SET ERR MESSAGE
     C                   MOVEL     SCUSTN        CUSNAM                          * SET ERR MESSAGE
     C                   MOVE      CUSKEY        CUSTNZ                          * GET CMD LINE
     C                   EXCEPT    ADDCUS
     C                   ELSE
     C                   MOVE      *BLANKS       CUSNAM                          * SET ERR MESSAGE
     C     ' '           CHECKR    SCUSTN        CUSLEN                          * SET ERR MESSAGE
     C                   MOVEL     SCUSTN        CUSNAM                          * SET ERR MESSAGE
     C                   MOVE      CUSKEY        CUSTNZ                          * GET CMD LINE
     C                   EXCEPT    UPDCUS
     C                   ENDIF
     C*
     C                   EXSR      @F02SR
     C*
     C                   ENDSR
     C*
     C*
     C     @F11SR        BEGSR                                                   * F10 SUBROUTINE
     C*
     C                   Z-ADD     SCUST#        NBRCHK
     C     NBRCHK        CHAIN     CUSTOMRZ                           44
     C     *IN44         IFEQ      @OFF
     C                   EXCEPT    DELCUS
     C                   ENDIF
     C*
     C                   EXSR      @F02SR
     C*
     C                   ENDSR
     C*
     C*
     C     @F12SR        BEGSR
     C                   MOVE      @TRUE         @EXIT
     C                   ENDSR
     C*
     OCUSTOMRZ  EADD         ADDCUS
     O                       CUST#Z               9
     O                       CUSTNZ              75
     O*
     OCUSTOMRZ  E            UPDCUS
     O                       CUSTNZ              75
     O*
     OCUSTOMRZ  EDEL         DELCUS
     O*
