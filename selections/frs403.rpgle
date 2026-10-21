     H DFTACTGRP(*NO) ACTGRP(*CALLER)

     FTOCITY    IF   E           K DISK
     FFRS403DF  CF   E             WORKSTN INFDS(WSDS)
     F                                     SFILE(SFL:SFLRN)
     D*
     D @F01            C                   CONST(X'31')
     D @F03            C                   CONST(X'33')
     D @F09            C                   CONST(X'39')
     D @F12            C                   CONST(X'3C')
     D @ENTER          C                   CONST(X'F1')
     D @HELP           C                   CONST(X'F3')
     D @PAGUP          C                   CONST(X'F4')
     D @PAGDN          C                   CONST(X'F5')
     D @PRINT          C                   CONST(X'F6')
     D*
     D @FALSE          C                   CONST('0')
     D @TRUE           C                   CONST('1')
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
     D WSDS            DS
     D  KEY                  369    369
     D  PAGRRN               378    379B 0
     D*
      /COPY 'protypes.rpgleinc'
     I*
     C*
     C     *ENTRY        PLIST
     C                   PARM                    PRMCTY           16             * RETURN START TIME
     C                   PARM                    PRMINT            3             * RETURN START TIME
     C*
     C                   RESET                   @EXIT                           * RESET EXIT FLAG
     C                   EXSR      @RMVMS
     C                   EXSR      @RESET                                        *
     C                   EXSR      @LOAD                                         * LOAD SFL
     C*
     C*
     C     @EXIT         DOUEQ     @TRUE                                         * DO UNTIL F3/F12
     C*
     C                   WRITE     FRSWIN                                        * WRITE MSGCTL
     C                   WRITE     FKEYS                                         * WRITE SFL CMDL
     C                   WRITE     MSGCTL                                        * WRITE MSGCTL
     C                   EXFMT     SFLCTL                                        * WRITE SFL CTL
     C*
     C                   Z-ADD     PAGRRN        SFLPS
     C*
     C     KEY           CASEQ     @F03          @F03SR                          F03 EXIT
     C     KEY           CASEQ     @F09          @F09SR                          F09 COMMAND LINE
     C     KEY           CASEQ     @F12          @F12SR                          F12 CANCEL
     C     KEY           CASEQ     @PAGDN        @PGDN                           PAGE DOWN
     C                   CAS                     @ENTKY                          Enter
     C                   ENDCS
     C*
     C                   ENDDO
     C*
     C*
     C                   MOVE      *ON           *INLR
     C*
     C*
     C*
     C     *INZSR        BEGSR                                                   * INIT SUBROUTN
     C*
     C                   SETOFF                                           50     * RESET ERR IND
     C*
     C     *LIKE         DEFINE    TOCNAM        ENDKEY
     C*
     C                   MOVE      ' '           MSGID             7
     C                   MOVE      *BLANKS       MSGDTA           80
     C                   MOVE      @PGM          MSGQUE           10
     C                   MOVE      @PGM          PGMQ
     C                   MOVE      @FALSE        @EXIT             1             * PGM EXIT = OFF
     C*
     C                   Z-ADD     0             SFLRN             4 0
     C                   Z-ADD     0             ENDRN             4 0
     C                   Z-ADD     1             SFLPS
     C*
     C                   MOVE      *BLANKS       TOCKEY           16
     C                   MOVEL     'A'           TOCKEY
     C*
     C     TOCKEY        SETLL     TOCITY
     C*
     C                   ENDSR
     C*
     C*
     C* Load subfile
     C*
     C*
     C     @LOAD         BEGSR
     C*
     C* Read a page of records or until EOF.
     C                   DO        4
     C                   READ      TOCITY                                 99
     C*
     C     *IN99         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
     C*
     C                   MOVEL     TOCNAM        STCTYN
     C                   MOVEL     TOCINT        STCTYI
     C*
     C                   ADD       1             SFLRN
     C                   WRITE     SFL                                           * WRITE SFL RCRD
     C*
     C                   ENDDO
     C*
     C                   MOVE      TOCNAM        ENDKEY                          * UPDATE END KEYS
     C                   Z-ADD     SFLRN         ENDRN                           * FOR FILE/SUBFILE
     C*
     C     *IN99         IFEQ      *OFF                                          * IF NOT EOF
     C                   READ      TOCITY                                 99     * READ ONE MORE
     C                   ENDIF                                                   * TO MAKE SURE
     C*
     C     SFLRN         IFEQ      *ZEROS                                        * IF NO RECS ADDED
     C                   MOVE      *OFF          *IN42                           * TO SFL SET ERR IN
     C                   ELSE                                                    * OTHERWISE
     C                   MOVE      *ON           *IN42                           * SET IND TO DSP SF
     C                   Z-ADD     SFLRN         SFLPS                           * SET SFL POSTN TO
     C                   ENDIF                                                   * PAGE JUST ADDED
     C*
     C                   ENDSR
     C*
     C*
     C     @RESET        BEGSR
     C                   MOVE      *ON           *IN40
     C                   WRITE     FRSWIN                                        * WRITE MSGCTL
     C                   WRITE     SFLCTL
     C                   MOVE      *OFF          *IN40
     C                   MOVE      *OFF          *IN42
     C*
     C                   RESET                   SFLRN
     C                   RESET                   ENDRN
     C                   RESET                   SFLPS
     C*
     C                   ENDSR
     C*
     C*
     C     @REPOS        BEGSR
     C*
     C                   EXSR      @RESET
     C     SEARCH        IFEQ      *BLANKS
     C                   MOVEL     TOCNAM        TOCKEY                          * UPDATE END KEYS
     C                   ENDIF
     C     TOCKEY        SETLL     TOCITY
     C                   EXSR      @LOAD
     C*
     C                   ENDSR
     C*
     C*
     C     @PGDN         BEGSR
     C*
     C     *IN99         IFEQ      *OFF
     C     ENDKEY        SETGT     TOCITY
     C                   Z-ADD     ENDRN         SFLRN
     C                   EXSR      @LOAD
     C                   ELSE
     C                   MOVE      *ON           *IN60
     C                   ENDIF
     C*
     C                   ENDSR
     C*
     C*
     C     @ENTKY        BEGSR
     C*
     C                   SETOFF                                           50     * RESET ERR IND
     C     SEARCH        IFNE      *BLANKS
     C                   MOVEL     SEARCH        TOCKEY
     C                   EXSR      @REPOS
->   C                   ELSE
->   C                   EXSR      @SFLRD
     C                   ENDIF
     C*
     C                   ENDSR
     C*
     C*
     C     @SFLRD        BEGSR                                                   * RD SFL CHG RCDS
     C*
     C                   EXSR      @RMVMS                                        * SND ERR MESSAGE
     C*
     C                   READC     SFL                                  9798     * SELECTION MADE?
     C*
     C     *IN97         IFEQ      '1'
     C                   EXSR      @REPOS                                        * REPOSITN SFL
     C                   GOTO      ENDSEL                                        * REPOSITN SFL
->   C                   ENDIF
     C*
     C     *IN98         DOWEQ     *OFF
     C*
     C     SELIO         IFEQ      '1'
     C                   MOVEL     STCTYN        PRMCTY
     C                   MOVEL     STCTYI        PRMINT
     C                   MOVE      @TRUE         @EXIT                           * SET EXIT FLAG ON
     C                   LEAVE
     C                   ENDIF
     C*
     C                   READC     SFL                                  9798
     C*
->   C     *IN97         IFEQ      '1'
     C                   EXSR      @REPOS                                        * REPOSITN SFL
     C                   EXSR      @SNDMS                                        * SND ERR MESSAGE
     C                   LEAVE                                                   * REPOSITN SFL
->   C                   ENDIF
     C*
     C                   ENDDO
     C*
     C     ENDSEL        ENDSR
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
     C     @F03SR        BEGSR                                                   * F3 SUBROUTINE
     C                   MOVE      @TRUE         @EXIT                           * SET EXIT FLAG ON
     C                   ENDSR
     C*
     C*
     C     @F09SR        BEGSR                                                   * F9 SUBROUTINE
     C                   CALLP     QUSCMDLN()                                    * GET CMD LINE
     C                   ENDSR
     C*
     C*
     C     @F12SR        BEGSR
     C                   MOVE      @TRUE         @EXIT
     C                   ENDSR
