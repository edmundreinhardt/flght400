# Layer 9 -- CL Programs

# FRS001CL -- New order CL wrapper (calls FRS001)
FRS001CL.PGM: frs001cl.clp FRS001.PGM

# FRS411CL -- FAX confirmation CL wrapper (calls FRS411)
FRS411CL.PGM: frs411cl.clp FRS411.PGM

# BLDCST -- Build customers wrapper (calls BCUST)
BLDCST.PGM: bldcst.clp BCUST.PGM

# Standalone CL utilities (no object dependencies)
MSGPRG.PGM: msgprg.clp
MSGPRGH.PGM: msgprgh.clp
MSGPGM2.PGM: msgpgm2.clp MSGPANEL.FILE
TESTIT.PGM: testit.clp
USECLEAR.PGM: useclear.clp
USERESET.PGM: usereset.clp
