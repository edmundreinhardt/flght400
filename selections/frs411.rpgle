     H DFTACTGRP(*NO) ACTGRP(*CALLER)

     FFRS411DF  CF   E             WORKSTN INFDS(WSDS)
     D*
     D @F03            C                   CONST(X'33')
     D @F12            C                   CONST(X'3C')
     D @ENTER          C                   CONST(X'F1')
     D @PRINT          C                   CONST(X'F6')
     D*
     D @FALSE          C                   CONST('0')
     D @TRUE           C                   CONST('1')
     D*
     D WSDS            DS
     D  KEY                  369    369
     D*
     D CRTCMD          DS
     D  TXT1                   1     16    INZ('DLYJOB DLY(00000')
     D  DLYTIM                17     17
     D  TXT2                  18     18    INZ(')')
     D*
      /COPY 'protypes.rpgleinc'
     C*
     C                   WRITE     FRSWIN                                        * WRITE MSGCTL
     C                   EXFMT     FKEYS                                         * WRITE MSGCTL
     C     KEY           CABEQ     @F03          END                             F03 EXIT
     C     KEY           CABEQ     @F12          END                             F03 EXIT
     C*
     C                   WRITE     FKEYS2                                        * WRITE MSGCTL
     C                   MOVE      '2'           DLYTIM
     C                   EXSR      FAXDLY
     C*
     C                   WRITE     FKEYS3                                        * WRITE MSGCTL
     C                   MOVE      '3'           DLYTIM
     C                   EXSR      FAXDLY
     C*
     C                   WRITE     FKEYS4                                        * WRITE MSGCTL
     C                   MOVE      '4'           DLYTIM
     C                   EXSR      FAXDLY
     C*
     C                   EXFMT     FKEYS5                                        * WRITE SFL CMDL
     C*
     C     END           TAG
     C*
     C                   MOVE      *ON           *INLR
     C*
     C*
     C     FAXDLY        BEGSR
     C                   Z-ADD     18            CMDLEN           15 5
     C                   CALLP     QCMDEXC(CRTCMD:CMDLEN)
     C                   ENDSR
     C*
