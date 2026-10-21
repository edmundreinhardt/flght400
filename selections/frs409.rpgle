     H DFTACTGRP(*NO) ACTGRP(*CALLER)

     FFRS409DF  CF   E             WORKSTN INFDS(WSDS)
     D*
     D @F01            C                   CONST(X'31')
     D @F03            C                   CONST(X'33')
     D @F12            C                   CONST(X'3C')
     D @ENTER          C                   CONST(X'F1')
     D @HELP           C                   CONST(X'F3')
     D @PRINT          C                   CONST(X'F6')
     D*
     D @FALSE          C                   CONST('0')
     D @TRUE           C                   CONST('1')
     D*
     D WSDS            DS
     D  KEY                  369    369
     C*
     C     *ENTRY        PLIST
     C                   PARM                    ORDER#            9 0           * RETURN START TIME
     C                   PARM                    ENDYN             1             * RETURN START TIME
     C*
     C                   EXSR      INZSR                                         * RESET EXIT FLAG
     C*
     C     @EXIT         DOUEQ     @TRUE                                         * DO UNTIL F3/F12
     C*
     C                   WRITE     FRSWIN                                        * WRITE MSGCTL
     C                   EXFMT     FKEYS                                         * WRITE SFL CMDL
     C*
     C     KEY           CASEQ     @F03          @F03SR                          F03 EXIT
     C     KEY           CASEQ     @F12          @F12SR                          F12 CANCEL
     C                   CAS                     @ENTKY                          Enter
     C                   ENDCS
     C*
     C     NEXT          TAG
     C                   ENDDO
     C*
     C                   MOVE      *ON           *INLR
     C*
     C*
     C*
     C     INZSR         BEGSR                                                   * INIT SUBROUTN
     C                   MOVE      ORDER#        ORDER                           * RETURN START TIME
     C                   MOVE      'N'           ENDYN                           * RETURN START TIME
     C                   MOVE      @FALSE        @EXIT             1             * PGM EXIT = OFF
     C                   ENDSR
     C*
     C*
     C     @ENTKY        BEGSR
     C                   MOVE      @TRUE         @EXIT                           * SET EXIT FLAG ON
     C                   ENDSR
     C*
     C*
     C     @F03SR        BEGSR                                                   * F3 SUBROUTINE
     C                   MOVE      'Y'           ENDYN                           * RETURN START TIME
     C                   MOVE      @TRUE         @EXIT                           * SET EXIT FLAG ON
     C                   ENDSR
     C*
     C*
     C     @F12SR        BEGSR
     C                   MOVE      'Y'           ENDYN                           * RETURN START TIME
     C                   MOVE      @TRUE         @EXIT
     C                   ENDSR
