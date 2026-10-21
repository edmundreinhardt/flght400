# Layer 4 -- Utility Modules (no dependencies)
GTOJCV.MODULE: gtojcv.rpgle
JTOGCV.MODULE: jtogcv.rpgle
RTDOFW.MODULE: rtdofw.rpgle
RTRAND.MODULE: rtrand.rpgle
RTSEED.MODULE: rtseed.rpgle

# Layer 5 -- Service Program
# Understand: BOUND_MODULE -> GTOJCV JTOGCV RTDOFW RTRAND RTSEED
FUTIL.SRVPGM: futil.bnd \
    GTOJCV.MODULE \
    JTOGCV.MODULE \
    RTDOFW.MODULE \
    RTRAND.MODULE \
    RTSEED.MODULE
