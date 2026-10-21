resume previous task about decomposing the FLGHT400 application into functional components.  Document into a markdown complete with mermaid diagrams.  Partition the source into SOURCe physicals in FLGHT400F library according to this partitioning.  Use the UNDERSTAND scan for "Flight 400" to enable this

All tasks are complete. Here is a summary of everything delivered:

---

## Summary

### Documentation — [`ARCHITECTURE.md`](ARCHITECTURE.md)

A comprehensive markdown document covering:

1. **Application Overview** — purpose, five functional components, mixed OPM/ILE state
2. **High-Level Architecture** — full Mermaid `flowchart` showing UI, transaction, maintenance, selection, service program, and database layers
3. **Data Model** — core physical files with column inventory, an **ER diagram** in Mermaid, and all 14 logical files/views
4. **Functional Components** — detailed Mermaid call graphs for:
   - Reservation Transactions (FRS000–FRS009)
   - Flight Maintenance (FRS021–FRS024)
   - Selection Lists (FRS401–FRS413)
   - Utility Service Program (FUTIL with 4 bound modules)
   - Data Population Build Programs
5. **ILE vs OPM Inventory** — pie chart + table (44 ILE / 37 OPM programs)
6. **RPGUnit Test Suites** — TEQUIV and four unit suites
7. **Source Physical File Partitioning** — full Mermaid diagram + member-assignment tables for all 11 source files
8. **OPM Legacy Retirement Candidates** — paired comparison table showing which OPM programs have ILE equivalents
9. **Modernisation Signals** — risk table from the Understand scan

### Source Physical File Partitioning (FLGHT400F)

| Source File | Members | Content |
|---|---|---|
| `QDDSSRCF` | 24 | Database PF/LF DDS (copied from FLGHT400/QDDSSRCF) |
| `QDDSSRC` | 25 | Display file DDS (copied from FLGHT400/QDDSSRC) |
| `QMNUSRC` | 6 | Menu DDS (copied from FLGHT400/QMNUSRC) |
| `QRESVRSRC` | 12 | Reservation transaction RPGLE (FRS000–FRS009) |
| `QMNTSRC` | 4 | Maintenance RPGLE (FRS021–FRS024) |
| `QSELSRC` | 16 | Selection list RPGLE (FRS401–FRS413 + B variants) |
| `QUTILSRC` | 4 | Utility module RPGLE (GTOJCV, JTOGCV, RTDOFW, RTRAND) |
| `QSRVSRC` | 1 | Binder language (FUTIL) |
| `QBUILDSRC` | 2 | Build program RPGLE (BFLGHT, BCUST) |
| `QCLPSRC` | 10 | CL programs (FRS001CL, FRS411CL, BLDCST, MSGPRG, etc.) |
| `QTESTSRC` | 5 | RPGUnit test suites |

> `QRPGLESRC` (38 members) is retained as-is for backward compatibility — it remains the original migration landing pad and is not deleted.