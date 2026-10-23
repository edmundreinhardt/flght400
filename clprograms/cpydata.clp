      /*%METADATA                                                     */
      /* %TEXT Copy database files from FLGHT400_O to FLGHT400        */
      /*%EMETADATA                                                    */
             PGM

             /* Clear target tables */
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/AGENTS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/AIRLINE') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/CUSTOMERS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/FLIGHTS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/FNAME') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/FNEXTO') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/FRCITY') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/LNAME') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/ORDERS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('DELETE FROM FLGHT400/TOCITY') COMMIT(*NONE)

             /* Copy data from FLGHT400_O into FLGHT400 */
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/AGENTS SELECT * +
                          FROM FLGHT400_O/AGENTS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/AIRLINE SELECT * +
                          FROM FLGHT400_O/AIRLINE') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/CUSTOMERS SELECT * +
                          FROM FLGHT400_O/CUSTOMERS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/FLIGHTS SELECT * +
                          FROM FLGHT400_O/FLIGHTS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/FNAME SELECT * +
                          FROM FLGHT400_O/FNAME') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/FNEXTO SELECT * +
                          FROM FLGHT400_O/FNEXTO') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/FRCITY SELECT * +
                          FROM FLGHT400_O/FRCITY') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/LNAME SELECT * +
                          FROM FLGHT400_O/LNAME') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/ORDERS +
                          (ORDER_NUMBER, AGENT_NO, CUSTOMER_NO, +
                          FLIGHT_NUMBER, DEPARTURE_DATE, +
                          TICKETS_ORDERED, CLASS, +
                          SEND_SIGNATURE_WITH_ORDER) SELECT +
                          ORDER_NUMBER, AGENT_NO, CUSTOMER_NO, +
                          FLIGHT_NUMBER, DATE(DEPARTURE_DATE), +
                          TICKETS_ORDERED, CLASS, +
                          SEND_SIGNATURE_WITH_ORDER FROM +
                          FLGHT400_O/ORDERS') COMMIT(*NONE)
             QSYS/RUNSQL SQL('INSERT INTO FLGHT400/TOCITY SELECT * +
                          FROM FLGHT400_O/TOCITY') COMMIT(*NONE)

             QSYS/SNDPGMMSG MSG('Data copy from FLGHT400_O to FLGHT400 +
                          completed successfully.') MSGTYPE(*COMP)

             ENDPGM
