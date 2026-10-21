      /*%METADATA                                                     */
      /* %TEXT Invokes the build of the Customers file                */
      /*%EMETADATA                                                    */
PGM

OVRDBF     FILE(CUSTOMER) TOFILE(FLGHT400/CUSTOMERS)
CALL       BCUST
DLTOVR     CUSTOMER

ENDPGM
