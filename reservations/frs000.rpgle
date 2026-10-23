**FREE
// ============================================================
// Program  : FRS000
// Purpose  : Flight Reservations - Logon / Entry Screen
// Converted: Fixed-form RPGLE to fully free-format RPGLE
//
// Conversion notes:
//   - AGENTSL was declared as program-described (F) in the original
//     F-spec but the *FILE object has external DDS (PROGRAM_DESCRIBED=NO).
//     Re-declared as DISK(*EXT) KEYED - I-specs removed, fields resolve
//     from DDS (AGNMBR, AGNAME, AGPASS).
//   - AGNKEY/PWDKEY variable-length key DSes removed; CHAIN now uses
//     AGNTNM directly on the externally described keyed file.
//   - CHECKR/MOVEL key-build pattern replaced by direct field comparison.
// ============================================================

CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER);

// ---- File Declarations -------------------------------------
DCL-F FRS000DF WORKSTN INFDS(WSDS);
DCL-F AGENTSL DISK(*EXT) KEYED USAGE(*INPUT);

// ---- Named Constants ---------------------------------------
DCL-C @F01   X'31';
DCL-C @F02   X'32';
DCL-C @F03   X'33';
DCL-C @F04   X'34';
DCL-C @F09   X'39';
DCL-C @F10   X'3A';
DCL-C @F12   X'3C';
DCL-C @ENTER X'F1';
DCL-C @HELP  X'F3';
DCL-C @PRINT X'F6';

DCL-C APOST  X'7D';

DCL-C @FALSE '0';
DCL-C @TRUE  '1';

// ---- Program Status Data Structure -------------------------
DCL-DS *N PSDS;
  @PGM    CHAR(10)   POS(1);
  @STAT   ZONED(5:0) POS(11);
  @PARMS  ZONED(3:0) POS(37);
  @MSGID  CHAR(7)    POS(40);
  @DATA   CHAR(79)   POS(91);
  @JOBNA  CHAR(10)   POS(244);
  @USRNA  CHAR(10)   POS(254);
  @JOBNO  CHAR(6)    POS(264);
  @SRCF   CHAR(10)   POS(304);
  @SRCL   CHAR(10)   POS(314);
  @SRCM   CHAR(10)   POS(324);
END-DS;

// ---- API Error Data Structure ------------------------------
DCL-DS APIERR;
  ERRSIZ  BINDEC(9:0)  INZ(256);
  ERRLEN  BINDEC(9:0)  INZ(0);
  ERRMIC  CHAR(7)      INZ;
  ERRNBR  CHAR(1)      INZ;
  ERRDTA  CHAR(240)    INZ;
END-DS;

// ---- Send Message Parameters --------------------------------
DCL-S MSGCTR  BINDEC(9:0) INZ(0);
DCL-S MSGLEN  BINDEC(9:0) INZ(80);
DCL-S MSGF    CHAR(20)    INZ('FRSMSGF   FLGHT400  ');
DCL-S MSGTYP  CHAR(10)    INZ('*INFO     ');

// ---- Remove Message Parameters ------------------------------
DCL-S RMVCTR  BINDEC(9:0) INZ(0);
DCL-S RMVMSQ  CHAR(10)    INZ('*         ');
DCL-S RMVCLR  CHAR(10)    INZ('*ALL      ');
DCL-S RMVKEY  CHAR(4)     INZ('    ');

// ---- Workstation INFDS -------------------------------------
DCL-DS WSDS;
  KEY  CHAR(1)  POS(369);
END-DS;

// ---- Command Data Structures --------------------------------
DCL-DS CRTCMD;
  GOCMD1  CHAR(19) INZ('GO FLGHT400/FRSMANT');
END-DS;

DCL-DS CRTCM2;
  GOCMD2  CHAR(19) INZ('GO FLGHT400/FRSREPT');
END-DS;

// ---- Prototypes (external copy) ----------------------------
/COPY 'protypes.rpgleinc'

// ---- Program Entry Interface --------------------------------
DCL-PI *N;
  RUNTYP  CHAR(6);
END-PI;

// ---- Standalone Variables -----------------------------------
DCL-S @EXIT   CHAR(1);
DCL-S CMDLEN  PACKED(15:5);
DCL-S AGENT#  PACKED(9:0);
DCL-S MSGID   CHAR(7)   INZ;
DCL-S MSGDTA  CHAR(80)  INZ;
DCL-S MSGQUE  CHAR(10)  INZ;

// ---- Main Logic --------------------------------------------
RESET LOGONR;
EXSR INZSR;

DOU @EXIT = @TRUE;

  WRITE MSGCTL;
  EXFMT LOGONR;

  IF KEY = @F02;
    EXSR @F02SR;
  ELSEIF KEY = @F03;
    EXSR @F03SR;
  ELSEIF KEY = @F04;
    EXSR @F04SR;
  ELSEIF KEY = @F09;
    EXSR @F09SR;
  ELSEIF KEY = @F12;
    EXSR @F12SR;
  ELSE;
    EXSR @ERRCK;
  ENDIF;

  IF KEY = @F10 AND NOT *INLR AND NOT *IN50;
    EXSR @F10SR;
    LEAVE;
  ENDIF;

ENDDO;

*INLR = *ON;

// ============================================================
// Subroutine: INZSR - Initialization
// ============================================================
BEGSR INZSR;
  *IN50 = *OFF;
  *IN51 = *OFF;
  *IN52 = *OFF;

  MSGID  = '       ';
  MSGDTA = *BLANKS;
  MSGQUE = @PGM;

  @EXIT = @FALSE;
  PGMQ  = @PGM;
ENDSR;

// ============================================================
// Subroutine: @ERRCK - Validate Input Data
//
// Original used CHECKR+MOVEL to build a varying-length key DS
// (AGNKEY/PWDKEY) for CHAIN on the program-described file.
// Since AGENTSL is now externally described (*EXT), CHAIN uses
// AGNTNM directly and PASSWD is compared to AGPASS from the
// file record.
// ============================================================
BEGSR @ERRCK;
  *IN44 = *OFF;
  *IN50 = *OFF;
  *IN51 = *OFF;
  *IN52 = *OFF;

  EXSR @RMVMS;

  IF AGNTNM = *BLANKS;
    *IN50 = *ON;
    *IN51 = *ON;
    MSGID = 'FRS0050';
    EXSR @SNDMS;
  ENDIF;

  IF PASSWD = *BLANKS;
    *IN50 = *ON;
    *IN52 = *ON;
    MSGID = 'FRS0055';
    EXSR @SNDMS;
    LEAVESR;
  ENDIF;

  CHAIN AGNTNM AGENTSL;
  IF NOT %FOUND(AGENTSL);
    *IN50 = *ON;
    *IN51 = *ON;
    MSGID = 'FRS0052';
    EXSR @SNDMS;
    LEAVESR;
  ENDIF;

  IF PASSWD <> AGPASS;
    *IN50 = *ON;
    *IN52 = *ON;
    MSGID = 'FRS0057';
    EXSR @SNDMS;
    LEAVESR;
  ENDIF;

ENDSR;

// ============================================================
// Subroutine: @RMVMS - Remove Messages
// ============================================================
BEGSR @RMVMS;
  CALLP QMHRMVPM(RMVMSQ:RMVCTR:RMVKEY:RMVCLR:APIERR);
ENDSR;

// ============================================================
// Subroutine: @SNDMS - Send Message
// ============================================================
BEGSR @SNDMS;
  CALLP QMHSNDPM(MSGID:MSGF:MSGDTA:MSGLEN:MSGTYP:
                 MSGQUE:MSGCTR:MSGKEY:APIERR);
ENDSR;

// ============================================================
// Subroutine: @F02SR - F2 Refresh
// ============================================================
BEGSR @F02SR;
  *IN50 = *OFF;
  *IN51 = *OFF;
  *IN52 = *OFF;
  RESET LOGONR;
  EXSR @RMVMS;
ENDSR;

// ============================================================
// Subroutine: @F03SR - F3 Exit
// ============================================================
BEGSR @F03SR;
  @EXIT = @TRUE;
ENDSR;

// ============================================================
// Subroutine: @F04SR - F4 Agent Select
// ============================================================
BEGSR @F04SR;
  AGNTNM = *BLANKS;
  CALLP FRS401(AGNTNM);
ENDSR;

// ============================================================
// Subroutine: @F09SR - F9 Command Line
// ============================================================
BEGSR @F09SR;
  CALLP QUSCMDLN();
ENDSR;

// ============================================================
// Subroutine: @F10SR - F10 Process Record
//
// Original used MOVEL AGNMBR AGENT# to move the binary field
// into a local zoned numeric. AGNMBR is now INT-compatible via
// the externally described file; direct assignment handles the
// type conversion automatically.
// ============================================================
BEGSR @F10SR;
  AGENT# = AGNMBR;

  SELECT;
    WHEN RUNTYP = 'CREATE';
      CALLP FRS001(AGENT#);
    WHEN RUNTYP = 'UPDATE';
      CALLP FRS009(AGENT#:RUNTYP);
    WHEN RUNTYP = 'DSPLAY';
      CALLP FRS009(AGENT#:RUNTYP);
    WHEN RUNTYP = 'DELETE';
      CALLP FRS009(AGENT#:RUNTYP);
    WHEN RUNTYP = 'FAX   ';
      CALLP FRS009(AGENT#:RUNTYP);
    WHEN RUNTYP = 'MAINT ';
      CMDLEN = 19;
      CALLP QCMDEXC(CRTCMD:CMDLEN);
    WHEN RUNTYP = 'REPORT';
      CMDLEN = 19;
      CALLP QCMDEXC(CRTCM2:CMDLEN);
  ENDSL;
ENDSR;

// ============================================================
// Subroutine: @F12SR - F12 Cancel
// ============================================================
BEGSR @F12SR;
  @EXIT = @TRUE;
ENDSR;
