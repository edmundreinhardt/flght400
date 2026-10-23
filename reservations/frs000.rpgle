**FREE
// ============================================================
// Program  : FRS000
// Purpose  : Flight Reservations - Logon / Entry Screen
//
// Refactored: subroutines -> subprocedures with parameters,
//             short cryptic names -> descriptive identifiers,
//             API parameters encapsulated inside procedures.
//
// Conversion notes:
//   - AGENTSL has external DDS; re-declared as DISK(*EXT) KEYED.
//   - I-specs and program-described key DSes removed; fields
//     resolve directly from DDS (AGNMBR, AGNAME, AGPASS).
// ============================================================

CTL-OPT DFTACTGRP(*NO) ACTGRP(*CALLER);

// ---- File Declarations -------------------------------------
DCL-F FRS000DF WORKSTN INFDS(wsInfoDs);
DCL-F AGENTSL  DISK(*EXT) KEYED USAGE(*INPUT);

// ---- Workstation Feedback Data Structure -------------------
// Captures the AID key byte that caused the last EXFMT to return.
DCL-DS wsInfoDs;
  pressedKey  CHAR(1)  POS(369);
END-DS;

// ---- AID Key Constants (EBCDIC byte values) ----------------
DCL-C KEY_F1     X'31';
DCL-C KEY_F2     X'32';
DCL-C KEY_F3     X'33';
DCL-C KEY_F4     X'34';
DCL-C KEY_F9     X'39';
DCL-C KEY_F10    X'3A';
DCL-C KEY_F12    X'3C';
DCL-C KEY_ENTER  X'F1';
DCL-C KEY_HELP   X'F3';
DCL-C KEY_PRINT  X'F6';

DCL-C APOSTROPHE X'7D';

// ---- Exit-Flag Constants -----------------------------------
DCL-C EXIT_NO  '0';
DCL-C EXIT_YES '1';

// ---- Program Status Data Structure -------------------------
DCL-DS *N PSDS;
  programName    CHAR(10)    POS(1);
  programStatus  ZONED(5:0)  POS(11);
  parmCount      ZONED(3:0)  POS(37);
  statusMsgId    CHAR(7)     POS(40);
  statusData     CHAR(79)    POS(91);
  jobName        CHAR(10)    POS(244);
  jobUser        CHAR(10)    POS(254);
  jobNumber      CHAR(6)     POS(264);
  sourceFile     CHAR(10)    POS(304);
  sourceLib      CHAR(10)    POS(314);
  sourceMember   CHAR(10)    POS(324);
END-DS;

// ---- API Error Data Structure ------------------------------
// Shared by all QMHRMVPM / QMHSNDPM calls.
DCL-DS apiError;
  errorBufferSize  BINDEC(9:0)  INZ(256);
  errorLength      BINDEC(9:0)  INZ(0);
  errorMessageId   CHAR(7)      INZ;
  errorNbr         CHAR(1)      INZ;
  errorData        CHAR(240)    INZ;
END-DS;

// ---- Program-Level Exit Flag --------------------------------
DCL-S exitFlag  CHAR(1)  INZ(EXIT_NO);

// ---- Prototypes (external copy) ----------------------------
/COPY 'protypes.rpgleinc'

// ---- Prototypes: local subprocedures -----------------------
DCL-PR initialize        END-PR;

DCL-PR validateLogon     IND  END-PR;

DCL-PR removeMessages    END-PR;

DCL-PR sendMessage;
  p_messageId  CHAR(7)  CONST;
END-PR;

DCL-PR handleRefresh     END-PR;

DCL-PR handleExit        END-PR;

DCL-PR handleAgentSelect END-PR;

DCL-PR handleCommandLine END-PR;

DCL-PR processEntry;
  p_agentNumber  PACKED(9:0)  VALUE;
  p_runType      CHAR(6)      CONST;
END-PR;

DCL-PR processMaintMenu  END-PR;

DCL-PR processReportMenu END-PR;

// ---- Program Entry Interface --------------------------------
DCL-PI *N;
  runType  CHAR(6);
END-PI;

// ---- Main Logic --------------------------------------------
RESET LOGONR;
initialize();

DOU exitFlag = EXIT_YES;

  WRITE MSGCTL;
  EXFMT LOGONR;

  SELECT;
    WHEN pressedKey = KEY_F2;
      handleRefresh();
    WHEN pressedKey = KEY_F3;
      handleExit();
    WHEN pressedKey = KEY_F4;
      handleAgentSelect();
    WHEN pressedKey = KEY_F9;
      handleCommandLine();
    WHEN pressedKey = KEY_F12;
      handleExit();
    OTHER;
      IF validateLogon();
        IF pressedKey = KEY_F10 AND NOT *INLR;
          processEntry(AGNMBR : runType);
          LEAVE;
        ENDIF;
      ENDIF;
  ENDSL;

ENDDO;

*INLR = *ON;

// ============================================================
// Procedure: initialize
// Sets up indicators and display-file fields for first display.
// ============================================================
DCL-PROC initialize;
  *IN50 = *OFF;
  *IN51 = *OFF;
  *IN52 = *OFF;

  PGMQ     = programName;
  exitFlag = EXIT_NO;
END-PROC;

// ============================================================
// Procedure: validateLogon
// Validates the agent name and password entered on the logon
// screen. Sets display-file error indicators (*IN50/*IN51/*IN52)
// and sends appropriate error messages on failure.
// Returns *ON when logon is valid, *OFF otherwise.
// ============================================================
DCL-PROC validateLogon;
  DCL-PI *N  IND  END-PI;

  *IN44 = *OFF;
  *IN50 = *OFF;
  *IN51 = *OFF;
  *IN52 = *OFF;

  removeMessages();

  // Agent name is required
  IF AGNTNM = *BLANKS;
    *IN50 = *ON;
    *IN51 = *ON;
    sendMessage('FRS0050');
  ENDIF;

  // Password is required; stop here if blank (nothing to look up)
  IF PASSWD = *BLANKS;
    *IN50 = *ON;
    *IN52 = *ON;
    sendMessage('FRS0055');
    RETURN *OFF;
  ENDIF;

  // Look up the agent by name
  CHAIN AGNTNM AGENTSL;
  IF NOT %FOUND(AGENTSL);
    *IN50 = *ON;
    *IN51 = *ON;
    sendMessage('FRS0052');
    RETURN *OFF;
  ENDIF;

  // Verify password matches the stored value
  IF PASSWD <> AGPASS;
    *IN50 = *ON;
    *IN52 = *ON;
    sendMessage('FRS0057');
    RETURN *OFF;
  ENDIF;

  RETURN *ON;
END-PROC;

// ============================================================
// Procedure: removeMessages
// Clears all messages from the program message queue using the
// QMHRMVPM API. All API parameters are local to this procedure.
// ============================================================
DCL-PROC removeMessages;
  DCL-S msgQueueName  CHAR(10)    STATIC INZ('*         ');
  DCL-S msgQueueCtr   BINDEC(9:0) STATIC INZ(0);
  DCL-S msgKey        CHAR(4)     STATIC INZ('    ');
  DCL-S removeType    CHAR(10)    STATIC INZ('*ALL      ');

  CALLP QMHRMVPM(msgQueueName : msgQueueCtr : msgKey : removeType : apiError);
END-PROC;

// ============================================================
// Procedure: sendMessage
// Sends an informational message to the program message queue
// using the QMHSNDPM API. All API parameters except the message
// ID are encapsulated locally.
//   p_messageId - 7-character message ID from FRSMSGF
// ============================================================
DCL-PROC sendMessage;
  DCL-PI *N;
    p_messageId  CHAR(7)  CONST;
  END-PI;

  DCL-S messageIdWork    CHAR(7)      STATIC;
  DCL-S msgFile          CHAR(20)     STATIC INZ('FRSMSGF   FLGHT400  ');
  DCL-S messageData      CHAR(80)     STATIC INZ;
  DCL-S messageDataLen   BINDEC(9:0)  STATIC INZ(80);
  DCL-S messageType      CHAR(10)     STATIC INZ('*INFO     ');
  DCL-S programQueue     CHAR(10)     STATIC;
  DCL-S msgQueueCtr      BINDEC(9:0)  STATIC INZ(0);
  DCL-S returnedMsgKey   CHAR(4)      STATIC INZ('    ');

  messageIdWork = p_messageId;
  programQueue  = programName;

  CALLP QMHSNDPM(messageIdWork  : msgFile       : messageData     :
                 messageDataLen : messageType   : programQueue    :
                 msgQueueCtr    : returnedMsgKey : apiError);

  // Write the returned message key into the WORKSTN MSGRCD field
  // so the display file can show the message on screen.
  MSGKEY = returnedMsgKey;
  PGMQ   = programQueue;
END-PROC;

// ============================================================
// Procedure: handleRefresh
// F2 - clears error indicators, resets the logon screen, and
// removes any pending program messages.
// ============================================================
DCL-PROC handleRefresh;
  *IN50 = *OFF;
  *IN51 = *OFF;
  *IN52 = *OFF;
  RESET LOGONR;
  removeMessages();
END-PROC;

// ============================================================
// Procedure: handleExit
// F3 / F12 - sets the exit flag to end the main loop.
// ============================================================
DCL-PROC handleExit;
  exitFlag = EXIT_YES;
END-PROC;

// ============================================================
// Procedure: handleAgentSelect
// F4 - clears the agent name field and calls the agent
// selection program (FRS401) so the user can pick an agent.
// ============================================================
DCL-PROC handleAgentSelect;
  DCL-S agentNameWork  CHAR(10)  STATIC INZ(*BLANKS);

  agentNameWork = AGNTNM;
  FRS401(agentNameWork);
  AGNTNM = agentNameWork;
END-PROC;

// ============================================================
// Procedure: handleCommandLine
// F9 - opens the interactive command line (QUSCMDLN).
// ============================================================
DCL-PROC handleCommandLine;
  QUSCMDLN();
END-PROC;

// ============================================================
// Procedure: processEntry
// F10 - routes to the appropriate downstream program based on
// the run type passed at program invocation. CMDEXC commands
// and command length are encapsulated locally.
//   p_agentNumber - agent number read from AGENTSL
//   p_runType     - operation code: CREATE / UPDATE / DSPLAY /
//                   DELETE / FAX / MAINT / REPORT
// ============================================================
DCL-PROC processEntry;
  DCL-PI *N;
    p_agentNumber  PACKED(9:0)  VALUE;
    p_runType      CHAR(6)      CONST;
  END-PI;

  // Work copies needed because prototypes expect by-reference params
  DCL-S agentNumWork  PACKED(9:0) STATIC;
  DCL-S runTypeWork   CHAR(6)     STATIC;

  agentNumWork = p_agentNumber;
  runTypeWork  = p_runType;

  SELECT;
    WHEN p_runType = 'CREATE';
      FRS001(agentNumWork);
    WHEN p_runType = 'UPDATE' OR p_runType = 'DSPLAY'
      OR p_runType = 'DELETE' OR p_runType = 'FAX   ';
      FRS009(agentNumWork : runTypeWork);
    WHEN p_runType = 'MAINT ';
      processMaintMenu();
    WHEN p_runType = 'REPORT';
      processReportMenu();
  ENDSL;
END-PROC;

// ============================================================
// Procedure: processMaintMenu
// Launches the maintenance menu via QCMDEXC.
// Command string and length are local to this procedure.
// ============================================================
DCL-PROC processMaintMenu;
  DCL-S goCommand     CHAR(19)     STATIC INZ('GO FLGHT400/FRSMANT');
  DCL-S commandLength PACKED(15:5) STATIC INZ(19);

  QCMDEXC(goCommand : commandLength);
END-PROC;

// ============================================================
// Procedure: processReportMenu
// Launches the report menu via QCMDEXC.
// Command string and length are local to this procedure.
// ============================================================
DCL-PROC processReportMenu;
  DCL-S goCommand     CHAR(19)     STATIC INZ('GO FLGHT400/FRSREPT');
  DCL-S commandLength PACKED(15:5) STATIC INZ(19);

  QCMDEXC(goCommand : commandLength);
END-PROC;
