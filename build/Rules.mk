# Layer 8 -- Data Population Build Programs
# Understand: BOUND_SRVPGM -> FUTIL

# BFLGHT -- Builds FLIGHTS, FRCITY, TOCITY, AIRLINE test data
BFLGHT.PGM: bflght.rpgle \
    FLIGHTS.FILE FRCITY.FILE TOCITY.FILE \
    AIRLINE.FILE \
    FUTIL.SRVPGM

# BCUST -- Builds CUSTOMERS test data using FNAME/LNAME tables
BCUST.PGM: bcust.rpgle \
    CUSTOMERS.FILE FNAME.FILE LNAME.FILE \
    FUTIL.SRVPGM
