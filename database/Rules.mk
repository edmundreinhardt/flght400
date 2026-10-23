# Layer 0 -- Tables (formerly Physical Files)
AGENTS.FILE:    agents.table
AIRLINE.FILE:   airline.table
CUSTOMERS.FILE: customers.table
FLIGHTS.FILE:   flights.table
FNAME.FILE:     fname.table
FNEXTO.FILE:    fnexto.table
FRCITY.FILE:    frcity.table
LNAME.FILE:     lname.table
ORDERS.FILE:    orders.table
TOCITY.FILE:    tocity.table

# Layer 1 -- Indexes (formerly Logical Files with alternate key only)
AGENTSL.FILE:   agentsl.index  AGENTS.FILE
AGENTSZ.FILE:   agentsz.index  AGENTS.FILE
AIRLINEL.FILE:  airlinel.index AIRLINE.FILE
CUSTOMER.FILE:  customer.index CUSTOMERS.FILE
CUSTNAME.FILE:  custname.index CUSTOMERS.FILE
CUSTOMRZ.FILE:  customrz.index CUSTOMERS.FILE
FLIGHTSL.FILE:  flightsl.index FLIGHTS.FILE
FLIGHTSZ.FILE:  flightsz.index FLIGHTS.FILE
FRCITYL.FILE:   frcityl.index  FRCITY.FILE
ORDERSZ.FILE:   ordersz.index  ORDERS.FILE
TOCITYL.FILE:   tocityl.index  TOCITY.FILE

# Layer 1 -- Views (formerly Join Logical Files)
CUSTORD.FILE:   custord.view  CUSTOMERS.FILE ORDERS.FILE
ORDDATE.FILE:   orddate.view  ORDERS.FILE CUSTOMERS.FILE
ORDNAME.FILE:   ordname.view  ORDERS.FILE CUSTOMERS.FILE
