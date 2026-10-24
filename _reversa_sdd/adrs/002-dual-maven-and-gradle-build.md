# ADR 002: Add Gradle support alongside Maven

- **Status:** Retrospective; decision inferred from source history
- **Date:** 2018-01-21
- **Evidence:** commit `952481e` (“Added gradle build support”)
- **Confidence:** 🟡 INFERRED

## Context

The commit added root and per-module Gradle build files, a settings file, and Gradle-related ignore rules while retaining Maven POMs.

## Decision

Maintain Gradle as an additional build path for the existing multi-module project.

## Consequences

- Consumers and contributors can use either build ecosystem.
- Dependency versions and plugin behavior are duplicated and can drift between Maven and Gradle.
- The current snapshot still contains both descriptor sets; no single canonical build is identified by the source.

## Alternatives considered

The commit message does not record alternatives. Removing Maven or migrating fully to Gradle would have reduced duplicate configuration but changed the existing build interface.
