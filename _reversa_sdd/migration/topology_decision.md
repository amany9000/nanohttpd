---
schemaVersion: 1
generatedAt: 2026-10-24T08:28:08Z
reversa:
  version: "1.3.6"
kind: topology_decision
producedBy: designer
hash: "sha256:4e6150b6fce208dcde23d7bd85a2566ff5070fd5bd5be928fb4e912e186a4d86"
---

# Topology Decision

> Conscious decision on how to organize the target system. This artifact is awaiting user approval.

## Legacy topology detected
- **Organizational pattern**: Multi-module Maven/Gradle monorepo organized mainly by capability, with an additional relocation packaging tree.
- **Confidence**: 🟢 CONFIRMED
- **Evidence**:
  - `_reversa_sdd/inventory.md` § Repository structure lists `core`, `websocket`, `webserver`, `nanolets`, `fileupload`, `markdown-plugin`, `samples`, and `relocation` as separate capability areas.
  - `_reversa_sdd/dependencies.md` § Build systems and Product dependencies confirms Maven parent modules and a parallel Gradle multi-project setup; the relocation tree is outside the root Maven module list.
  - `_reversa_sdd/architecture.md` § Runtime architecture assigns distinct responsibilities to core and optional modules.
- **Legacy tree sketch**:
  ```text
  nanohttpd/
  ├── core/
  ├── websocket/
  ├── webserver/
  ├── nanolets/
  ├── fileupload/
  ├── markdown-plugin/
  ├── samples/
  └── relocation/
  ```

## Structural diagnosis
- **Coupling**: Medium. Optional modules depend on `core`; `_reversa_sdd/dependencies.md` records internal `org.nanohttpd:nanohttpd` dependencies from extension/sample modules.
- **Cohesion by module**: Medium to high. Modules map to recognizable capabilities, though Markdown sits as a plugin over webserver and sample/example code is built alongside runtime modules.
- **Orphan/dead modules**: None established by the specs; samples are support code and relocation is a packaging compatibility area.
- **Redundant layers**: No redundant runtime layers documented.
- **Boundary violations**: Build metadata is duplicated between Maven and Gradle, and relocation artifacts are not included in the root Maven aggregator. These are release/build boundaries, not proven runtime violations.
- **Mixed paradigms/styles**: No paradigm shift; legacy is class-based Java with interface extension points.
- **Overall assessment**: Partially problematic. Capability boundaries are visible, but duplicated build declarations and separated relocation publishing increase drift risk.

## Modern topology proposed
- **Pattern**: Capability-oriented modular monolith with stable public API modules and internal ports/adapters at external-library boundaries.
- **Justification**: It groups runtime code by cohesive library capability, retains one JVM/library distribution model, and supports the user's Big Bang release choice through a coordinated module set. It avoids service decomposition or mandatory DI frameworks, consistent with the conservative paradigm decision.
- **Expected gains**:
  - Clearer ownership of dependency versions and external integrations per capability.
  - More explicit build/release boundaries for core, extensions, examples, and compatibility artifacts.
  - Better isolation of optional integrations (Commons FileUpload, Markdown renderer) from the core artifact.
- **Cost / risk**:
  - Renaming/re-grouping modules may break artifact coordinates and build consumers; under Big Bang this must be handled as a major-version compatibility change.
  - Maven/Gradle and relocation publication metadata must be reconciled together.
  - The project is small; overly elaborate hexagonal layers would add maintenance burden without a documented service/deployment need.
- **Proposed tree sketch**:
  ```text
  nanohttpd/
  ├── protocol-core/                 # sessions, handlers, responses, sockets
  ├── extensions/
  │   ├── websocket-protocol/        # upgrade and frame lifecycle
  │   ├── static-content/            # webserver + Markdown serving integration
  │   ├── uri-routing/               # Nanolets route matching and dispatch
  │   └── multipart-adapter/         # Commons FileUpload boundary
  ├── examples/                      # runnable sample applications
  ├── compatibility/
  │   └── maven-relocations/         # legacy coordinates and markers
  └── build-logic/                   # shared Maven/Gradle version and release policy
  ```

## Options presented to the user
1. **Preserve legacy topology** (conservative)
   - Keep current module names and boundaries; modernize dependency/build declarations with the least tree and artifact churn.
2. **Adopt the proposed capability topology** (transformational)
   - Regroup modules and build boundaries as shown above; requires a major release and explicit artifact relocation/deprecation mapping.
3. **Hybrid** (balanced)
   - Preserve published module/artifact boundaries and `core`, while consolidating build/version policy and grouping optional modules under capability-oriented source/build conventions; avoid moving public packages unless needed.

## User decision
- **Choice**: 1 — Preserve legacy topology.
- **User justification**: “Preserve the legacy module topology.”
- **Decided on**: 2026-10-24T08:28:08Z.

## Legacy to target mapping
| Legacy module / folder | Proposed capability | Mapping | Notes |
|---|---|---|---|
| `core/` | `protocol-core/` | preserved responsibility, renamed in proposal | Session and response protocols remain the core boundary. |
| `websocket/` | `extensions/websocket-protocol/` | preserved capability | Depends on protocol core. |
| `webserver/` + `markdown-plugin/` | `extensions/static-content/` | merged | Markdown is a plugin of static serving; keep optional renderer dependency isolated inside the capability. |
| `nanolets/` | `extensions/uri-routing/` | preserved capability | Route selection remains separate from core request parsing. |
| `fileupload/` | `extensions/multipart-adapter/` | preserved capability | External FileUpload boundary remains optional. |
| `samples/` | `examples/` | moved/support-only | Not part of the runtime library surface. |
| `relocation/` | `compatibility/maven-relocations/` | regrouped | Keep old coordinates resolving according to the approved support window. |
| Maven/Gradle root descriptors | `build-logic/` | consolidated policy | Build declarations remain supported; version policy should have one documented source of truth where feasible. |

## Implications for Designer next steps
| Designer stage | Implication | How to honor it |
|---|---|---|
| Bounded contexts | Preserve capabilities but group Markdown with static serving. | Group by cohesion and extension boundary; do not create a bounded context for each legacy folder by default. |
| Target architecture | One embeddable library, not distributed services. | Show protocol core and optional adapters in one process with no database or queue. |
| Target domain model | Preserve request/session/response and protocol lifecycle rules. | Map confirmed rules from `target_business_rules.md`; no business aggregates or persistence entities are implied. |
| Target data model | No application data store exists. | State that no DB schema migration is applicable; describe only library configuration and temporary storage where relevant. |

## Notes

The user approved preserving the legacy module topology. Keep module names and boundaries; modernize dependencies and build conventions within them. The proposed capability tree remains an unselected alternative. Big Bang describes release sequencing and does not authorize unapproved package or artifact renames.
