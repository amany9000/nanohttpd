---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_specs
producedBy: inspector
hash: "sha256:ae81deb48db5490f1d2c9b6ef34820637baae2b5de5b87d7b68bb5984fd5ac55"
---

# Parity Specs

> Validation contract for the Big Bang major release of this embeddable Java library. The paradigm and module topology are preserved; approved security/resource recommendations are explicit target behavior changes.

## General strategy
- [x] Characterization specs derived from the documented legacy behavior
- [x] Contract checks for public API, module artifacts, and protocol responses
- [ ] Shadow mode (no service traffic boundary; downstream hosts own traffic)
- [ ] Data parity (no persistent data store exists)
- **Test artifacts**: Gherkin specs in `parity_tests/`; implementation teams choose the executable test framework.
- **API surface**: compare public packages/signatures and module coordinates against the prior stable release; intentional breaking changes must be covered by the approved major-version policy.
- **Build parity**: Maven and Gradle must resolve compatible dependency graphs and package equivalent modules.

## Acceptance criteria for parity
- **Primary metric**: 100% pass rate across the confirmed contract scenarios below; zero unexplained divergence in HTTP/session/response, WebSocket, router, upload adapter, static serving, Markdown, and relocation contracts.
- **Observation window**: one complete release-candidate cycle plus downstream smoke validation; a time-based production observation period is not applicable to a library artifact.
- **Cutover blocker**: any unexplained confirmed-contract failure, public API break outside the approved major-version plan, Maven/Gradle artifact mismatch, or unresolved critical security/dependency issue blocks stable publication.
- **Expected improvements**: approved request/frame/upload caps, canonical filesystem containment, escaping/sanitization, and safer failure handling are tested against the approved target policy and listed under Exceptions; they are not treated as parity failures when behavior intentionally tightens.

## Paradigm-adapted coverage

### No paradigm change
Use ordinary observable equivalence: same request and configuration produce the same documented response, callback, lifecycle, and cleanup effects. No event ordering, idempotency, queue, or aggregate-transition dimensions apply.

## Validation types
- **Functional**: run the `.feature` scenarios against target modules and compare status, headers, body semantics, callbacks, and cleanup.
- **Contract**: compare public API signatures, extension interfaces, Maven coordinates, relocation metadata, and documented module dependencies.
- **Load/performance**: compare representative request throughput, startup/shutdown behavior, memory use around configured body/frame limits, and response streaming against the prior stable release; numeric thresholds must be set by the release owner before implementation.
- **Resilience**: exercise malformed requests, callback exceptions, interrupted uploads, WebSocket close/error paths, and temporary-resource cleanup.

## Reuse of discovery characterization specs
- **Source**: no separate `_reversa_sdd/characterization_specs/` suite was found. Scenarios are derived from `_reversa_sdd/flowcharts/`, per-module requirements/contracts, domain rules, and the code-spec matrix.
- **Adaptation**: keep confirmed behavior as compatibility assertions. Apply the maintainer-approved security/resource recommendations as explicit target exceptions.

## Screen parity

Skipped. `_reversa_sdd/migration/screen_modernization_decision.md` records that the repository is a library without product UI. No visual golden comparison is required. HTML returned by samples and tests is covered by response behavior only where stated in the feature specs.

## Approved target exceptions

- **EX-01 — Resource bounds**: implement configurable finite limits for request/header/body/upload sizes and WebSocket frame/message sizes; use documented client/protocol failure behavior. Exact numeric defaults remain an implementation decision before release.
- **EX-02 — Malformed encoding**: reject malformed percent-encoding rather than preserving or normalizing invalid input.
- **EX-03 — Temporary storage**: use secure temporary storage, restrictive permissions where supported, cleanup on success/error, and a configurable threshold; exact threshold and platform guarantees must be documented.
- **EX-04 — WebSocket validation/failure**: enforce client masking and close/report consistently after handler failure.
- **EX-05 — Filesystem containment**: enforce root containment after canonicalization and symlink resolution.
- **EX-06 — Directory listing and CORS**: keep listings configurable, escape rendered values, and make CORS opt-in with explicit origins.
- **EX-07 — Nanolets**: preserve existing priority and callback behavior; specify responder lifecycle before changing it.
- **EX-08 — Upload adapter**: retain caller-supplied FileItemFactory, expose upload limits, and document single-consumption unless explicitly buffered.
- **EX-09 — Markdown**: decode UTF-8 and provide safe rendering by default; permit raw HTML only through an explicit trusted/configured mode.
- **EX-10 — Samples**: escape reflected request values in sample HTML.
- **EX-11 — Relocation**: retain old coordinates through at least one announced major release cycle and publish the sunset horizon.
- **EX-12 — Operations guidance**: keep authentication at host handlers and document secure exposure/TLS/resource-limit guidance.

## Outputs
- `parity_tests/*.feature`: eight Gherkin specifications with explicit source and target traceability.

## Notes

The Big Bang strategy means all included modules move together in one major release; it does not remove the need for a candidate cycle or compatibility checks. Java 17 is confirmed as the target minimum. Dependency versions and any runtime/API changes need release-note coverage.
