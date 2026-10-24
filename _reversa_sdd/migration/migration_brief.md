---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:06Z
reversa:
  version: "1.3.6"
kind: migration_brief
producedBy: orchestrator
hash: "sha256:0865aec46cd57a92d829d683aef77ea6d980b03573a443e925c76c3e448f79b4"
---

# Migration Brief

> Migration criteria document collected in an interview at the start of `/reversa-migrate`.
> Consumed by the six agents of the Migration Team. It does not ask about the paradigm (the Paradigm Advisor's responsibility) or appetite (derived in `paradigm_decision.md`).

## Migration goal
Modernize nanohttpd by updating dependencies to the latest reasonably compatible versions. Preserve its purpose as a lightweight embeddable Java HTTP server library and maintain compatibility where practical. The user delegated remaining choices to the migration team.

## Success metrics
- Dependencies are updated to supported, reasonably current releases without avoidable compatibility or security regressions.
- Existing documented HTTP server behavior and public APIs remain compatible unless a change is justified and recorded.
- The resulting library builds and its parity expectations are clear for the implementing team.

## Constraints
- **Deadline**: Unspecified.
- **Budget**: Unspecified; team and hiring assumptions are unspecified.
- **Technical**: Java library. Existing specs identify Java 7 source/target compatibility and both Maven and Gradle build support. The maintainer confirmed Java 17 as the minimum target for this migration. Existing Java 7 consumers may require a major-version transition or a maintained legacy branch. No target framework, database, or messaging system was specified.
- **Operational**: Unspecified; no deployment or SLA constraints supplied.

## Known risk factors
- Raising the Java baseline or dependency versions may break downstream consumers or binary/source compatibility.
- The current specs include unresolved security and resource-limit policy gaps; retain these as explicit decisions rather than inventing contracts.
- Dependency freshness and compatibility may conflict with the library's lightweight and legacy compatibility goals.

## Stakeholders
| Name / role | Responsibility in the migration |
|---|---|
| Aman / maintainer | Review migration decisions and preserve intended compatibility |
| Library consumers / downstream integrators | Validate compatibility needs; representatives unspecified |
| Implementing coding agent / migration team | Prepare target design and implementation handoff |

## Target stack
- **Language**: Java; provisional Java 17 minimum for planning, subject to explicit validation.
- **Framework**: None specified; preserve framework-neutral library design.
- **Database**: None; not applicable to the HTTP server library.
- **Messaging**: None specified; not applicable unless a future use case requires it.
- **Infrastructure**: Consumer-selected; this is an embeddable library, not a deployable service.
- **Other relevant components**: Preserve Maven and Gradle build support if feasible; update dependencies to latest reasonably compatible releases. Observability is consumer-controlled unless the specs indicate otherwise.

## Declared scope
- **Included**: All documented nanohttpd modules and packaging/relocation artifacts, with dependency modernization prioritized.
- **Excluded**: Unspecified; no module has been explicitly excluded.

## Free notes
The maintainer asked: “Try to update the dependencies to as latest as reasonably possible. Use your best judgement for rest.” The provisional Java 17 target and compatibility goals are planning assumptions, not additional maintainer decisions. Revisit the target Java baseline and any behavior changes before implementation.
