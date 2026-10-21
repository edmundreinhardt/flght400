     H DFTACTGRP(*NO) ACTGRP(*CALLER)

     FFRS021DF  CF   E             WORKSTN INFDS(WSDS)
     FAIRLINE   IF   E           K DISK
     FAIRLINEL  IF   E           K DISK
     FFLIGHTSZ  UF A F  233    09AIDISK    KEYLOC(1)
     FFRCITY    IF   E           K DISK
     FTOCITY    IF   E           K DISK
     D*
     D TABDAY          S              9    DIM(7) CTDATA PERRCD(1)                            CRIPTI
     D*
     D @F01            C                   CONST(X'31')
     D @F02            C                   CONST(X'32')
     D @F03            C                   CONST(X'33')
     D @F04            C                   CONST(X'34')
     D @F06            C                   CONST(X'36')
     D @F07            C                   CONST(X'37')
     D @F08            C                   CONST(X'38')
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
     D  ARRINT                 1     18
     D  ARRINL                 1      2B 0 INZ(3)
     D  ARRIN3                 3      5
     D  ARRINN                 3     18
     D*
     D                 DS
     D  ARRCTY                 1     18
     D  ARRCTL                 1      2B 0
     D  ARRCTN                 3     18
     D*
     D                 DS
     D  DEPINT                 1     18
     D  DEPINL                 1      2B 0 INZ(3)
     D  DEPIN3                 3      5
     D  DEPINN                 3     18
     D*
     D                 DS
     D  DEPCTY                 1     18
     D  DEPCTL                 1      2B 0
     D  DEPCTN                 3     18
     D*
     D                 DS
     D  AIRLNK                 1     34
     D  AIRLNG                 1      2B 0 INZ(3)
     D  AIRLN3                 3      5
     D  AIRLNN                 3     34
     D*
     D                 DS
     D  DAYOWK                 1     18
     D  DAYOWL                 1      2B 0
     D  DAYOWN                 3     18
     D*
     D                 DS
     D  ARRTIM                 1     34
     D  ARRTIL                 1      2B 0 INZ(8)
     D  ARRHH                  3      4
     D  ARRCOL                 5      5    INZ(':')
     D  ARRMM                  6      7
     D  ARRBLK                 8      8    INZ(' ')
     D  ARRAP                  9     10
     D  ARRTIN                11     34
     D*
     D                 DS
     D  DEPTIM                 1     34
     D  DEPTIL                 1      2B 0 INZ(8)
     D  DEPHH                  3      4
     D  DEPCOL                 5      5    INZ(':')
     D  DEPMM                  6      7
     D  DEPBLK                 8      8    INZ(' ')
     D  DEPAP                  9     10
     D  DEPTIN                11     34
     D*
     D                 DS
     D  TICKTP                 1     24
     D  TICKTL                 1      2B 0
     D  TICKTN                 3     24
     D*
      /COPY 'protypes.rpgleinc'
     I*
     IFLIGHTSZ  NS  02
     I                                  1    9 0FFLGHT
     I                                 10   27  FDPCIN
     I                                 28   45  FDPCNM
     I                                 46   63  FDYOWK
     I                                 64   81  FARCIN
     I                                 82   99  FARCNM
     I                                100  133  FDPTTM
     I                                134  167  FARVTM
     I                                168  201  FAIRLN
     I                             B  202  205 0FSEATS
     I                                206  229  FTCKTP
     I                             B  230  233 0FMILES
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
     C     KEY           CASEQ     @F06          @F06SR                          * F03 EXIT
     C     KEY           CASEQ     @F07          @F07SR                          * F03 EXIT
     C     KEY           CASEQ     @F08          @F08SR                          * F03 EXIT
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
     C                   SETOFF                                       445051     * ERROR IND. SC 1
     C                   SETOFF                                       525354     * ERROR IND. SC 1
     C                   SETOFF                                       555657     * ERROR IND. SC 1
     C                   SETOFF                                       585960     * ERROR IND. SC 1
     C*
     C                   MOVE      ' '           MSGID             7
     C                   MOVE      *BLANKS       MSGDTA           80
     C                   MOVE      @PGM          MSGQUE           10
     C*
     C                   MOVE      @FALSE        @EXIT             1
     C                   MOVE      @PGM          PGMQ
     C*
     C                   MOVE      '00'          SDPTHH
     C                   MOVE      '00'          SDPTMM
     C                   MOVE      'PM'          SDPTAP
     C*
     C                   MOVE      '00'          SARRHH
     C                   MOVE      '00'          SARRMM
     C                   MOVE      'PM'          SARRAP
     C*
     C     ENDINZ        ENDSR
     C*
     C*
     C*
     C     @ERRCK        BEGSR                                                   * CHK INPUT DATA
     C*
     C                   SETOFF                                       445051     * ERROR IND. SC 1
     C                   SETOFF                                       525354     * ERROR IND. SC 1
     C                   SETOFF                                       555657     * ERROR IND. SC 1
     C                   SETOFF                                       585960     * ERROR IND. SC 1
     C*
     C                   EXSR      @RMVMS
     C*
     C     SFLGHT        IFEQ      *ZEROS                                        * RUN INTERACTIVE
     C                   SETON                                          5051     * SET ERR INDICATOR
     C                   MOVE      'FRS0021'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SDYOWK        IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5052     * SET ERR INDICATOR
     C                   MOVE      'FRS0022'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SDYOWK        LOOKUP    TABDAY                                 44     * SRCH TABL 4 DSCR
     C     *IN44         IFEQ      @OFF
     C                   SETON                                          5052     * SET ERR INDICATOR
     C                   MOVE      'FRS0023'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   ENDIF
     C*
     C     SFRCTY        IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5053     * SET ERR INDICATOR
     C                   MOVE      'FRS0061'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SFRCTY        CHAIN     FRCTYR                             44
     C     *IN44         IFEQ      @ON
     C                   SETON                                          5053     * SET ERR INDICATOR
     C                   MOVE      'FRS0062'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   ENDIF
     C                   MOVEL     FRCINT        SFRINT
     C*
     C     STOCTY        IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5054     * SET ERR INDICATOR
     C                   MOVE      'FRS0071'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     STOCTY        CHAIN     TOCTYR                             44
     C     *IN44         IFEQ      @ON
     C                   SETON                                          5054     * SET ERR INDICATOR
     C                   MOVE      'FRS0072'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   ENDIF
     C                   MOVEL     TOCINT        STOINT
     C*
     C     SDPTHH        IFEQ      '00'                                          * RUN INTERACTIVE
     C     SDPTMM        ANDEQ     '00'                                          * RUN INTERACTIVE
     C                   SETON                                          5055     * SET ERR INDICATOR
     C                   MOVE      'FRS0024'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SDPTHH        IFGT      '12'                                          * RUN INTERACTIVE
     C     SDPTMM        ORGT      '59'                                          * RUN INTERACTIVE
     C                   SETON                                          5055     * SET ERR INDICATOR
     C                   MOVE      'FRS0024'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SDPTAP        IFNE      'AM'                                          * RUN INTERACTIVE
     C     SDPTAP        ANDNE     'PM'                                          * RUN INTERACTIVE
     C                   SETON                                          5055     * SET ERR INDICATOR
     C                   MOVE      'FRS0024'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SARRHH        IFEQ      '00'                                          * RUN INTERACTIVE
     C     SARRMM        ANDEQ     '00'                                          * RUN INTERACTIVE
     C                   SETON                                          5056     * SET ERR INDICATOR
     C                   MOVE      'FRS0024'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SARRHH        IFGT      '12'                                          * RUN INTERACTIVE
     C     SARRMM        ORGT      '59'                                          * RUN INTERACTIVE
     C                   SETON                                          5056     * SET ERR INDICATOR
     C                   MOVE      'FRS0024'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SARRAP        IFNE      'AM'                                          * RUN INTERACTIVE
     C     SARRAP        ANDNE     'PM'                                          * RUN INTERACTIVE
     C                   SETON                                          5056     * SET ERR INDICATOR
     C                   MOVE      'FRS0024'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SMILES        IFEQ      *ZEROS                                        * RUN INTERACTIVE
     C                   SETON                                          5057     * SET ERR INDICATOR
     C                   MOVE      'FRS0025'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SAIRLN        IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5058     * SET ERR INDICATOR
     C                   MOVE      'FRS0041'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SAIRLN        CHAIN     AIRLINE                            44         * RUN INTERACTIVE
     C     *IN44         IFEQ      @TRUE                                                    ACTIVE
     C                   SETON                                          5058     * SET ERR INDICATOR
     C                   MOVE      'FRS0042'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SSEATS        IFEQ      *ZEROS                                        * RUN INTERACTIVE
     C                   SETON                                          5059     * SET ERR INDICATOR
     C                   MOVE      'FRS0083'     MSGID                           * SET ERR MESSAGE
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   GOTO      ERREND
     C                   END
     C*
     C     SPRICE        IFEQ      *BLANKS                                       * RUN INTERACTIVE
     C                   SETON                                          5060     * SET ERR INDICATOR
     C                   MOVE      'FRS0084'     MSGID                           * SET ERR MESSAGE
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
     C                   SETOFF                                       445051     * ERROR IND. SC 1
     C                   SETOFF                                       525354     * ERROR IND. SC 1
     C                   SETOFF                                       555657     * ERROR IND. SC 1
     C                   SETOFF                                       585960     * ERROR IND. SC 1
     C                   RESET                   SELCTR                          * REFRESH SCREEN -
     C                   EXSR      @RMVMS
     C                   MOVE      '00'          SDPTHH
     C                   MOVE      '00'          SDPTMM
     C                   MOVE      'PM'          SDPTAP
     C                   MOVE      '00'          SARRHH
     C                   MOVE      '00'          SARRMM
     C                   MOVE      'PM'          SARRAP
     C                   ENDSR
     C*
     C*
     C     @F03SR        BEGSR                                                   * F3 SUBROUTINE
     C                   MOVE      @TRUE         @EXIT                           * SET EXIT FLAG ON
     C                   ENDSR
     C*
     C*
     C     @F04SR        BEGSR                                                   * F3 SUBROUTINE
     C                   CALLP     FRS413(SFLGHT:SDYOWK:SFRCTY:STOCTY:SDPTHH:
     C                             SDPTMM:SDPTAP:SARRHH:SARRMM:SARRAP:SMILES:
     C                             SAIRIN:SSEATS:SPRICE)
     C*
     C     SAIRIN        CHAIN     AIRLINEL                           44
     C     *IN44         IFEQ      @FALSE
     C                   MOVEL     AIRLNM        SAIRLN
     C                   ENDIF
     C*
     C     SFRCTY        CHAIN     FRCITY                             44
     C     *IN44         IFEQ      @FALSE
     C                   MOVEL     FRCINT        SFRINT
     C                   ENDIF
     C*
     C     STOCTY        CHAIN     FRCITY                             44
     C     *IN44         IFEQ      @FALSE
     C                   MOVEL     TOCINT        STOINT
     C                   ENDIF
     C*
     C                   ENDSR
     C*
     C*
     C     @F06SR        BEGSR                                                   * F3 SUBROUTINE
     C                   CALLP     FRS402(SFRCTY:SFRINT:SAIRIN)                  * SELCT START INTRV
     C*
     C     SAIRIN        CHAIN     AIRLINEL                           44
     C     *IN44         IFEQ      @FALSE
     C                   MOVEL     AIRLNM        SAIRLN
     C                   ENDIF
     C                   ENDSR
     C*
     C*
     C     @F07SR        BEGSR                                                   * F3 SUBROUTINE
     C                   CALLP     FRS403(STOCTY:STOINT)                         * SELCT START INTRV
     C                   ENDSR
     C*
     C*
     C     @F08SR        BEGSR                                                   * F3 SUBROUTINE
     C                   CALLP     FRS412(SAIRLN:SAIRIN)                         * SELCT START INTRV
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
     C     SFLGHT        CHAIN     FLIGHTSZ                           44
     C*
     C     *IN44         IFEQ      @ON
     C*
     C                   Z-ADD     SFLGHT        FFLGHT                          * GET CMD LINE
     C                   MOVE      *BLANKS       DEPINN                          * GET CMD LINE
     C                   MOVEL     SFRINT        DEPIN3                          * GET CMD LINE
     C                   MOVEL     DEPINT        FDPCIN                          * GET CMD LINE
     C                   MOVE      *BLANKS       DEPCTN                          * GET CMD LINE
     C     ' '           CHECKR    SFRCTY        DEPCTL                          * SET ERR MESSAGE
     C                   MOVEL     SFRCTY        DEPCTN                          * GET CMD LINE
     C                   MOVEL     DEPCTY        FDPCNM                          * GET CMD LINE
     C                   MOVE      *BLANKS       ARRINN                          * GET CMD LINE
     C                   MOVEL     STOINT        ARRIN3                          * GET CMD LINE
     C                   MOVEL     ARRINT        FARCIN                          * GET CMD LINE
     C                   MOVE      *BLANKS       ARRCTN                          * GET CMD LINE
     C     ' '           CHECKR    STOCTY        ARRCTL                          * SET ERR MESSAGE
     C                   MOVEL     STOCTY        ARRCTN                          * GET CMD LINE
     C                   MOVEL     ARRCTY        FARCNM                          * GET CMD LINE
     C                   MOVE      *BLANKS       DAYOWN                          * GET CMD LINE
     C     ' '           CHECKR    SDYOWK        DAYOWL                          * SET ERR MESSAGE
     C                   MOVEL     SDYOWK        DAYOWN                          * GET CMD LINE
     C                   MOVEL     DAYOWK        FDYOWK                          * GET CMD LINE
     C                   MOVE      *BLANKS       DEPTIN                          * GET CMD LINE
     C                   MOVEL     SDPTHH        DEPHH                           * GET CMD LINE
     C                   MOVEL     SDPTMM        DEPMM                           * GET CMD LINE
     C                   MOVEL     SDPTAP        DEPAP                           * GET CMD LINE
     C                   MOVEL     DEPTIM        FDPTTM                          * GET CMD LINE
     C                   MOVE      *BLANKS       ARRTIN                          * GET CMD LINE
     C                   MOVEL     SARRHH        ARRHH                           * GET CMD LINE
     C                   MOVEL     SARRMM        ARRMM                           * GET CMD LINE
     C                   MOVEL     SARRAP        ARRAP                           * GET CMD LINE
     C                   MOVEL     ARRTIM        FARVTM                          * GET CMD LINE
     C                   MOVE      *BLANKS       AIRLNN                          * GET CMD LINE
     C     SAIRLN        CHAIN     AIRLINE                            44
     C     *IN44         IFEQ      @FALSE
     C                   MOVEL     AIRLIN        AIRLN3
     C                   ENDIF
     C                   MOVEL     AIRLNK        FAIRLN                          * GET CMD LINE
     C                   Z-ADD     SSEATS        FSEATS                          * GET CMD LINE
     C                   MOVE      *BLANKS       TICKTN                          * GET CMD LINE
     C     ' '           CHECKR    SPRICE        TICKTL                          * SET ERR MESSAGE
     C                   MOVEL     SPRICE        TICKTN                          * SET ERR MESSAGE
     C                   MOVEL     TICKTP        FTCKTP                          * GET CMD LINE
     C                   Z-ADD     SMILES        FMILES                          * GET CMD LINE
     C                   EXCEPT    ADDFLT
     C*
     C                   ELSE
     C*
     C                   MOVE      *BLANKS       DEPINN                          * GET CMD LINE
     C                   MOVEL     SFRINT        DEPIN3                          * GET CMD LINE
     C                   MOVEL     DEPINT        FDPCIN                          * GET CMD LINE
     C                   MOVE      *BLANKS       DEPCTN                          * GET CMD LINE
     C     ' '           CHECKR    SFRCTY        DEPCTL                          * SET ERR MESSAGE
     C                   MOVEL     SFRCTY        DEPCTN                          * GET CMD LINE
     C                   MOVEL     DEPCTY        FDPCNM                          * GET CMD LINE
     C                   MOVE      *BLANKS       ARRINN                          * GET CMD LINE
     C                   MOVEL     STOINT        ARRIN3                          * GET CMD LINE
     C                   MOVEL     ARRINT        FARCIN                          * GET CMD LINE
     C                   MOVE      *BLANKS       ARRCTN                          * GET CMD LINE
     C     ' '           CHECKR    STOCTY        ARRCTL                          * SET ERR MESSAGE
     C                   MOVEL     STOCTY        ARRCTN                          * GET CMD LINE
     C                   MOVEL     ARRCTY        FARCNM                          * GET CMD LINE
     C                   MOVE      *BLANKS       DAYOWN                          * GET CMD LINE
     C     ' '           CHECKR    SDYOWK        DAYOWL                          * SET ERR MESSAGE
     C                   MOVEL     SDYOWK        DAYOWN                          * GET CMD LINE
     C                   MOVEL     DAYOWK        FDYOWK                          * GET CMD LINE
     C                   MOVE      *BLANKS       DEPTIN                          * GET CMD LINE
     C                   MOVEL     SDPTHH        DEPHH                           * GET CMD LINE
     C                   MOVEL     SDPTMM        DEPMM                           * GET CMD LINE
     C                   MOVEL     SDPTAP        DEPAP                           * GET CMD LINE
     C                   MOVEL     DEPTIM        FDPTTM                          * GET CMD LINE
     C                   MOVE      *BLANKS       ARRTIN                          * GET CMD LINE
     C                   MOVEL     SARRHH        ARRHH                           * GET CMD LINE
     C                   MOVEL     SARRMM        ARRMM                           * GET CMD LINE
     C                   MOVEL     SARRAP        ARRAP                           * GET CMD LINE
     C                   MOVEL     ARRTIM        FARVTM                          * GET CMD LINE
     C                   MOVE      *BLANKS       AIRLNN                          * GET CMD LINE
     C     SAIRLN        CHAIN     AIRLINE                            44
     C     *IN44         IFEQ      @FALSE
     C                   MOVEL     AIRLIN        AIRLN3
     C                   ENDIF
     C                   MOVEL     AIRLNK        FAIRLN                          * GET CMD LINE
     C                   Z-ADD     SSEATS        FSEATS                          * GET CMD LINE
     C                   MOVE      *BLANKS       TICKTN                          * GET CMD LINE
     C     ' '           CHECKR    SPRICE        TICKTL                          * SET ERR MESSAGE
     C                   MOVEL     SPRICE        TICKTN                          * SET ERR MESSAGE
     C                   MOVEL     TICKTP        FTCKTP                          * GET CMD LINE
     C                   Z-ADD     SMILES        FMILES                          * GET CMD LINE
     C                   EXCEPT    UPDFLT
     C*
     C                   ENDIF
     C*
     C                   EXSR      @F02SR
     C*
     C                   ENDSR
     C*
     C*
     C     @F11SR        BEGSR                                                   * F10 SUBROUTINE
     C*
     C     SFLGHT        CHAIN     FLIGHTSZ                           44
     C     *IN44         IFEQ      @OFF
     C                   EXCEPT    DELFLT
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
     C*
     OFLIGHTSZ  EADD         ADDFLT
     O                       FFLGHT               9
     O                       FDPCIN              27
     O                       FDPCNM              45
     O                       FDYOWK              63
     O                       FARCIN              81
     O                       FARCNM              99
     O                       FDPTTM             133
     O                       FARVTM             167
     O                       FAIRLN             201
     O                       FSEATS             205B
     O                       FTCKTP             229
     O                       FMILES             233B
     O*
     OFLIGHTSZ  E            UPDFLT
     O                       FDPCIN              27
     O                       FDPCNM              45
     O                       FDYOWK              63
     O                       FARCIN              81
     O                       FARCNM              99
     O                       FDPTTM             133
     O                       FARVTM             167
     O                       FAIRLN             201
     O                       FSEATS             205B
     O                       FTCKTP             229
     O                       FMILES             233B
     O*
     OFLIGHTSZ  EDEL         DELFLT
     O*
** DAY OF THE WEEK
Sunday
Monday
Tuesday
Wednesday
Thursday
Friday
Saturday
