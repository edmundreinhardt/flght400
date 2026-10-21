# Layer 6 -- Selection List Sub-Programs
# Understand: PGM_CALL inbound from reservation + maintenance programs

# FRS401 -- Select Agent
FRS401.PGM: frs401.rpgle FRS401DF.FILE \
    AGENTS.FILE AGENTSL.FILE
FRS401B.PGM: frs401b.rpgle FRS401DF.FILE \
    AGENTS.FILE AGENTSL.FILE

# FRS402 -- Select From City (7 inbound deps)
FRS402.PGM: frs402.rpgle FRS402DF.FILE \
    FRCITY.FILE FRCITYL.FILE
FRS402B.PGM: frs402b.rpgle FRS402DF.FILE \
    FRCITY.FILE FRCITYL.FILE

# FRS403 -- Select To City (6 inbound deps)
FRS403.PGM: frs403.rpgle FRS403DF.FILE \
    TOCITY.FILE TOCITYL.FILE

# FRS404 -- Select Flights (5 inbound deps)
FRS404.PGM: frs404.rpgle FRS404DF.FILE \
    FLIGHTSL.FILE
FRS404B.PGM: frs404b.rpgle FRS404DF.FILE \
    FLIGHTSL.FILE

# FRS405 -- Select Customer (6 inbound deps)
FRS405.PGM: frs405.rpgle FRS405DF.FILE \
    CUSTOMERS.FILE CUSTNAME.FILE CUSTOMER.FILE

# FRS406 -- Order Confirmation Window
FRS406.PGM: frs406.rpgle FRS406DF.FILE

# FRS407 -- Select Order by Date
FRS407.PGM: frs407.rpgle FRS407DF.FILE \
    ORDDATE.FILE CUSTOMERS.FILE

# FRS408 -- Select Order by Customer
FRS408.PGM: frs408.rpgle FRS408DF.FILE \
    ORDNAME.FILE CUSTORD.FILE

# FRS409 -- Modify Confirmation Window
FRS409.PGM: frs409.rpgle FRS409DF.FILE

# FRS410 -- Remove Confirmation Window
FRS410.PGM: frs410.rpgle FRS410DF.FILE

# FRS411 -- FAX Status Window
FRS411.PGM: frs411.rpgle FRS411DF.FILE

# FRS412 -- Select Airline (2 inbound deps)
FRS412.PGM: frs412.rpgle FRS412DF.FILE \
    AIRLINE.FILE AIRLINEL.FILE

# FRS413 -- Select All Flights (1 inbound dep)
FRS413.PGM: frs413.rpgle FRS413DF.FILE \
    FLIGHTSZ.FILE
