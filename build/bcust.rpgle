**FREE
// -----------------------------------------------------------------
// BCUST_FREE.RPGLE - Build Customer File
// Converted from Fixed-Format RPGLE to Fully Free-Format RPGLE
// -----------------------------------------------------------------
CTL-OPT DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('FUTIL');

DCL-F FNAME DISK(*EXT) USAGE(*INPUT);
DCL-F LNAME DISK(*EXT) USAGE(*INPUT);
DCL-F CUSTOMER DISK(70) USAGE(*OUTPUT);

DCL-C UP 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
DCL-C LO 'abcdefghijklmnopqrstuvwxyz';

DCL-DS custrec;
  CUSTNO BINDEC(9:0) POS(1);
  CUSTNM CHAR(66)    POS(5);
  FLDLEN BINDEC(4:0) POS(5) INZ(64);
  CNAME  CHAR(64)    POS(7);
END-DS;

DCL-S BGNNBR PACKED(6:0);
DCL-S ENDNBR PACKED(6:0);
DCL-S RTVNUM PACKED(6:0);
DCL-S COMMA  CHAR(1) INZ(',');

/COPY 'reservations/protypes.rpgleinc'

CUSTNO = 1;

DOW CUSTNO <= 9999;
  CNAME = *BLANKS;

  BGNNBR = 1;
  ENDNBR = 4724;
  RTVNUM = 0;
  getRandomNumber(BGNNBR: ENDNBR: RTVNUM);

  CHAIN RTVNUM LNAME;
  LASTNM = %XLATE(UP: LO: LASTNM: 2);
  CNAME = LASTNM;

  ENDNBR = 1369;
  RTVNUM = 0;
  getRandomNumber(BGNNBR: ENDNBR: RTVNUM);

  CHAIN RTVNUM FNAME;
  FRSTNM = %XLATE(UP: LO: FRSTNM: 2);
  CNAME = %TRIMR(CNAME) + COMMA + ' ' + %TRIMR(FRSTNM);
  FLDLEN = %CHECKR(' ': CNAME);

  WRITE CUSTOMER custrec;

  CUSTNO += 1;
ENDDO;

*INLR = *ON;
