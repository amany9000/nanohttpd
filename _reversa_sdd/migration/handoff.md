---
schemaVersion: 1
generatedAt: 2026-10-24T08:34:12Z
reversa:
  version: "1.3.6"
kind: handoff
producedBy: orchestrator
hash: "sha256:455ba5e551d80c4447ff6686c3147e269a8c12d13e627bdf16d1384dd2432246"
---

# Handoff to the Coding Agent

New system to be built in the classic object-oriented Java paradigm, preserving the legacy multi-module topology, screens: none (system without UI). Before any code, read `paradigm_decision.md` and `topology_decision.md`.

## ⚠️ Mandatory reading first

1. **`paradigm_decision.md`** — required; keep the framework-neutral, class-based design.
2. **`topology_decision.md`** — required; preserve the existing module names and boundaries.
3. Screen Translator skipped, legacy without UI. Read `screen_modernization_decision.md` for the skip rationale; there is no visual mode to implement.

## Recommended reading order

1. `paradigm_decision.md`
2. `topology_decision.md`
3. `migration_brief.md`
4. `target_business_rules.md`
5. `migration_strategy.md`
6. `target_architecture.md`
7. `target_domain_model.md`
8. `target_data_model.md`
9. `data_migration_plan.md`
10. `parity_specs.md` and `parity_tests/`
11. `risk_register.md` and `cutover_plan.md`
12. `screen_modernization_decision.md` and `target_screens.md` (skip record; no UI)
13. `screen_deviation_log.md` (empty; no UI)
14. `discard_log.md`
15. `ambiguity_log.md`

## Produced artifacts

| Artifact | Producer | Status |
|---|---|---|
| `migration_brief.md` | orchestrator | created; Java 17 minimum confirmed |
| `paradigm_decision.md` | paradigm advisor | created; conservative, no paradigm shift |
| `target_business_rules.md` | curator | created; 14 rules migrate, 13 recommendations approved |
| `discard_log.md` | curator | created; no confirmed behavior discarded |
| `migration_strategy.md` | strategist | created; Big Bang selected by maintainer |
| `risk_register.md` | strategist | created |
| `cutover_plan.md` | strategist | created for coordinated major release |
| `topology_decision.md` | designer, Phase 1 | created; legacy module topology preserved |
| `target_architecture.md` | designer | created and approved |
| `target_domain_model.md` | designer | created; no business aggregates invented |
| `target_data_model.md` | designer | created; no database |
| `data_migration_plan.md` | designer | created; no persistent data ETL |
| `screen_modernization_decision.md` | screen translator | skipped; no product UI |
| `target_screens.md` | screen translator | skipped; no product UI |
| `screen_deviation_log.md` | screen translator | empty; no visual deviations |
| `_reversa_sdd/screens/inventory.json` | screen translator | created; zero product screens |
| `parity_specs.md` | inspector | created |
| `parity_tests/01-http-core.feature` | inspector | created |
| `parity_tests/02-request-body-storage.feature` | inspector | created |
| `parity_tests/03-websocket.feature` | inspector | created |
| `parity_tests/04-static-serving.feature` | inspector | created |
| `parity_tests/05-nanolets-routing.feature` | inspector | created |
| `parity_tests/06-fileupload.feature` | inspector | created |
| `parity_tests/07-markdown-plugin.feature` | inspector | created |
| `parity_tests/08-packaging-and-samples.feature` | inspector | created |
| `ambiguity_log.md` | orchestrator | 0 pending, 13 resolved, 4 deferred to coding |
| `.state.json` | orchestrator | complete; six agents recorded |
| `.logs/<timestamp>-migrate.log` | orchestrator | full timestamped run log |

## Blockers to starting implementation

No remaining human decision blocks implementation planning. Four detailed items are deferred and must be concretized before the stable release:

- `DEFER-001`: numeric request/header/body/upload and WebSocket limits.
- `DEFER-002`: exact temporary storage threshold/platform guarantees and HTML sanitization allowlist.
- `DEFER-003`: calendar sunset date for old Maven relocation coordinates.
- `DEFER-004`: exact dependency versions, license review, and Maven/Gradle graph for Java 17.

## Next steps for the coding agent

1. Read `paradigm_decision.md` and preserve the framework-neutral class-based Java contracts.
2. Read `topology_decision.md`; keep `core/`, `websocket/`, `webserver/`, `nanolets/`, `fileupload/`, `markdown-plugin/`, `samples/`, and `relocation/` module boundaries.
3. Use Java 17 as the confirmed minimum; document the major-version impact for consumers who require Java 7.
4. Inventory current direct and transitive dependencies, verify supported releases and licenses, and align Maven and Gradle declarations before changing modules. Select the newest versions compatible with Java 17 and the approved API policy.
5. Update the full module set together on a major-release branch. Keep old published artifacts available; do not rename packages or coordinates without compatibility mapping.
6. Turn each `parity_tests/*.feature` into executable tests in the chosen test stack. Add API compatibility, dependency resolution, and Maven/Gradle artifact comparison checks.
7. Resolve `DEFER-001` through `DEFER-004` into numeric/configuration details and release notes before stable publication.
8. Publish a coordinated candidate, address all parity blockers, then follow `cutover_plan.md` go/no-go and rollback steps for the major release.

## Auto-decided items

This pipeline ran interactively, not with `--auto`. The user delegated general migration judgment, then explicitly approved the Curator recommendations and selected the paradigm, strategy, topology, and architecture. Java 17 was confirmed by the user.

## Final notes

No legacy application files were modified. This pipeline produced migration planning specifications only; it did not update dependencies or run tests. Current dependency versions must be verified during implementation because release status changes over time.
