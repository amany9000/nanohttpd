---
schemaVersion: 1
generatedAt: 2026-10-24T08:33:48Z
reversa:
  version: "1.3.6"
kind: migration_strategy
producedBy: strategist
hash: "sha256:b0850d64de766bdb456e7a178a4e364dec4aa2801a532aa9c96b0c4fcd9039dd"
---

# Migration Strategy

> Strategies evaluated with explicit trade-offs. The recommendation is subject to the user's decision.

## Context
- **System size**: 7 Maven modules plus a relocation tree; 87 tracked Java files and 36 test classes by the discovery inventory.
- **Runtime shape**: embeddable library in consumer JVMs; no production database, service topology, or persistent data migration was identified.
- **Appetite**: conservative, per `paradigm_decision.md`.
- **Paradigm gap**: none; retain framework-neutral, class-based Java design.
- **Brief constraints**: update dependencies to latest reasonably compatible releases; deadline, budget, and maintenance window are unspecified.
- **Critical rules**: preserve HTTP/session/response behavior and public extension contracts; maintain Maven/Gradle support and relocation behavior until an approved deprecation plan.

## Strategies evaluated

### Strategy A: Branch by Abstraction (recommended)
- **Description**: Modernize dependencies and internal build/API boundaries incrementally behind existing contracts, module by module; validate parity at each step and publish a candidate only after the matrix passes.
- **When it applies**: Internal library modernization where the domain and public API should remain stable.
- **Cost**: low to medium (catalog: low).
- **Risk**: low to medium (catalog: low; library compatibility raises practical risk).
- **Time**: medium.
- **Fit with appetite**: Strong. It permits conservative, reviewable dependency changes and rollback before a stable release.
- **Fit with paradigm gap**: Strong; no paradigm shift is required.
- **Trade-offs**:
  - Pros: isolates dependency incompatibilities; preserves existing module boundaries; supports side-by-side candidate releases and API checks.
  - Cons: temporary build/version complexity; may require compatibility bridges and a longer release cycle.

### Strategy B: Big Bang major release
- **Description**: Update all modules and dependencies together in one major release, with a single coordinated compatibility review.
- **When it applies**: Small systems with a tolerable release window and few live integrations. It is technically possible because this is a library without a persistent data store, but downstream consumers still integrate the artifact.
- **Cost**: low (catalog).
- **Risk**: high (catalog), especially for consumers with pinned/transitive dependencies or the Java baseline.
- **Time**: short (catalog).
- **Fit with appetite**: Weak for the selected conservative appetite.
- **Fit with paradigm gap**: No gap, but the release can still introduce broad API/build changes at once.
- **Trade-offs**:
  - Pros: one coherent dependency graph and short migration calendar.
  - Cons: large compatibility blast radius; harder to attribute regressions; rollback requires republishing or restoring the previous release line.

### Strategy C: Strangler Fig
- **Description**: Route traffic gradually from legacy implementation to a replacement.
- **When it applies**: Production services with proxy/gateway routing seams.
- **Cost**: medium; **risk**: low; **time**: long (catalog).
- **Fit with appetite**: Conservative in general, but poor project fit.
- **Trade-offs**:
  - Pros: gradual traffic movement where consumers control routing.
  - Cons: this repository is an embeddable library, not a deployed service; routing is owned by downstream applications, so the library team cannot execute a true strangler cutover.

## Comparative assessment

| Criterion | Branch by Abstraction | Big Bang | Strangler Fig |
|---|---|---|---|
| Cost | Low to medium | Low | Medium |
| Risk | Low to medium | High | Low in service settings; poor fit here |
| Time | Medium | Short | Long |
| Appetite fit | Strong | Weak | General fit, project mismatch |
| Compatibility | Incremental checks and bridges | One large compatibility boundary | Requires consumer-owned routing |

## Recommendation
- **Recommended strategy**: A — Branch by Abstraction, implemented as module-by-module dependency modernization behind current public contracts.
- **Justification**: This is a small but externally consumed library. The user wants recent dependencies while preserving a conservative class-based design. Incremental module changes, API compatibility checks, and candidate releases limit downstream risk. There is no application traffic or data store for a strangler or data migration to manage. Deadline and budget remain undefined, so avoid assuming a compressed big-bang schedule.

## Signals and caveats
- Java 17 minimum confirmed by the maintainer; choose dependency versions compatible with that baseline.
- Keep Java 7 consumers in view until a release policy explicitly changes the baseline.
- “Latest reasonably possible” means the newest versions compatible with the selected Java baseline, public API, licensing, and both Maven and Gradle builds; verify current versions during implementation planning.
- No production cutover window or downstream consumer cohort was supplied.

## Decision for the user
- **Strategy chosen**: B — Big Bang major release.
- **Who decided**: Aman (maintainer).
- **When**: 2026-10-24.
- **Justification**: The maintainer chose to update all modules together in one major release.
