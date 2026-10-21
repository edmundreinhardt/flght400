     H DFTACTGRP(*NO) ACTGRP(*CALLER)

     FFRS009DF  CF   E             WORKSTN INFDS(WSDS)
     FORDERSZ   IF   E           K DISK
     D*
     D @F01            C                   CONST(X'31')
     D @F02            C                   CONST(X'32')
     D @F03            C                   CONST(X'33')
     D @F04            C                   CONST(X'34')
     D @F05            C                   CONST(X'35')
     D @F09            C                   CONST(X'39')
     D @F10            C                   CONST(X'3A')
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
      /COPY 'protypes.rpgleinc'

     I*
     C*
     C     *ENTRY        PLIST
     C                   PARM                    PAGENT            9 0
     C                   PARM                    RUNTYP            6
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
     C     KEY           CASEQ     @F05          @F05SR                          * F03 EXIT
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
     C                   SETOFF                                       505152     * ERROR IND. SC 1
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
     C                   SETOFF                                       515253     * ERROR IND. SC 1
     C*
     C                   EXSR      @RMVMS
     C*
     C     ORDER         IFEQ      *ZEROS                                        * RUN INTERACTIVE
     C                   SETON                                          5053     * SET ERR INDICATOR
     C                   MOVE      'FRS0090'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     ORDER         CHAIN     ORDNMZ                             44         * RUN INTERACTIVE
     C     *IN44         IFEQ      @TRUE                                         * RUN INTERACTIVE
     C                   SETON                                          5053     * SET ERR INDICATOR
     C                   MOVE      'FRS0091'     MSGID                           * SET ERR MESSAGE
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
     C                   SETOFF                                       505152     * ERROR IND. SC 1
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
     C                   CALLP     FRS408(CUSNAM:ORDER)                          * SELCT START INTRV
     C                   Z-ADD     0000          DODYY                           * RETURN START TIME
     C                   Z-ADD     00            DODMM                           * RETURN START TIME
     C                   Z-ADD     00            DODDD                           * RETURN START TIME
     C     ORDER         IFNE      0                                             * RETURN START TIME
     C                   EXSR      @F10SR
     C                   ENDIF
     C                   ENDSR
     C*
     C*
     C     @F05SR        BEGSR                                                   * F3 SUBROUTINE
     C                   CALLP     FRS407(DODYY:DODMM:DODDD:ORDER)               * SELCT START INTRV
     C                   MOVE      *BLANKS       CUSNAM                          * RETURN START TIME
     C     ORDER         IFNE      0                                             * RETURN START TIME
     C                   EXSR      @F10SR
     C                   ENDIF
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
     C                   SELECT                                                  * F02 REFRESH
     C     RUNTYP        WHENEQ    'UPDATE'                                      * F03 EXIT
     C                   CALLP     FRS002(PAGENT:ORDER)
     C     RUNTYP        WHENEQ    'DSPLAY'                                      * F03 EXIT
     C                   CALLP     FRS003(PAGENT:ORDER)
     C     RUNTYP        WHENEQ    'DELETE'                                      * F03 EXIT
     C                   CALLP     FRS004(PAGENT:ORDER)
     C     RUNTYP        WHENEQ    'FAX   '                                      * F03 EXIT
     C                   CALLP     FRS005(PAGENT:ORDER)
     C                   ENDSL                                                   * F12 CANCEL
     C*
     C                   EXSR      @F02SR
     C*
     C     F10END        ENDSR
     C*
     C*
     C     @F12SR        BEGSR
     C                   MOVE      @TRUE         @EXIT
     C                   ENDSR
     C*
