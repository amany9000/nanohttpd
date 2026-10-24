# ADR 004: Set Java 7 as the source and target level

- **Status:** Retrospective; decision inferred from source history
- **Date:** 2017-01-04
- **Evidence:** commit `d0978f5` (“Bumped JDK versions to 1.7 in POM.xml”); current root Maven and Gradle descriptors specify 1.7
- **Confidence:** 🟢 CONFIRMED for the configured value; 🟡 INFERRED for the rationale

## Context

The project explicitly configured Java compiler source and target compatibility to 1.7.

## Decision

Compile the project for Java 7 compatibility in the checked-out snapshot.

## Consequences

- The library avoids requiring newer language features at compile time.
- Modern Java APIs and syntax are constrained by the configured compatibility level.
- The history does not establish whether Java 7 remains a current support commitment or only reflects the age of this snapshot.

## Alternatives considered

No alternatives are recorded in the cited commit.
