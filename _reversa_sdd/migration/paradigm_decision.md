---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:06Z
reversa:
  version: "1.3.6"
kind: paradigm_decision
producedBy: paradigm_advisor
hash: "sha256:38c3cacad0416446231df0514ff152be2f9776ee6ce06987424b6f476e1eb0c7"
---

# Paradigm Decision

> Conscious decision on how to handle the change (or absence) of paradigm between the legacy system and the target stack.

## Detected legacy paradigm
- **Main paradigm**: classic OO, framework-neutral library style.
- **Confidence**: 🟢 CONFIRMED
- **Evidence**:
  - `_reversa_sdd/architecture.md` § Runtime architecture describes `NanoHTTPD`, `HTTPSession`, `Response`, and module classes with handler/interceptor extension interfaces.
  - `_reversa_sdd/domain.md` § Glossary and Confirmed rules describes server/session/handler/response objects and class-based lifecycle and protocol rules.
  - `_reversa_sdd/inventory.md` § Repository structure shows Java modules and their class-based responsibilities.
- **Observed variations**: Interface-based extension points and modular components exist; no injection container, repository layer, or application business domain is described.

## Declared target stack
- Language: Java; provisional Java 17 minimum, confirmed by the maintainer on 2026-10-24.
- Framework: None; framework-neutral library.
- Infrastructure: Consumer-selected; no separately deployed service.

## Inferred natural paradigm
- **Paradigm**: object-oriented Java, with composition and interfaces available as idiomatic implementation tools.
- **Justification**: The target remains Java and framework-neutral. The catalog maps framework-based modern Java to OO with DI, but this brief does not select Spring, Quarkus, or a DI container.
- **Viable alternatives**: Add internal dependency injection/composition without a framework; this is optional and must not burden consumers or change public API without justification.

## Identified gap
- **Severity**: none for paradigm choice.
- **Concrete implications**:
  - Keep the `NanoHTTPD` start/stop lifecycle recognizable; `_reversa_sdd/core/requirements.md` FR-01 treats it as the listener boundary.
  - Preserve the `IHTTPSession` and handler contract unless compatibility evidence justifies a versioned change; `_reversa_sdd/core/requirements.md` FR-02 defines handler dispatch.
  - Keep optional capabilities modular; `_reversa_sdd/architecture.md` § Runtime architecture lists WebSocket, webserver, Nanolets, file upload, Markdown, samples, and relocation as distinct concerns.
  - Retain host-controlled storage and extension seams; `_reversa_sdd/domain.md` § Confirmed rules records replaceable temporary-file handling and `_reversa_sdd/fileupload/requirements.md` specifies a caller-supplied FileItemFactory.

## Options presented to the user
1. **Adopt the stack's natural paradigm** (transformational)
   - Move internals toward composition and explicit dependency injection, accepting broader structural change and extra compatibility review.
2. **Force a paradigm similar to the legacy one** (conservative)
   - Preserve the existing class-based structure and public extension contracts as closely as possible; limit changes to dependency/build modernization and narrowly justified internals.
3. **Hybrid** (balanced)
   - Preserve public APIs and lightweight design while selectively modernizing internal composition.

## User decision
- **Choice**: 2
- **User's justification**: “Conservative: keep the existing class based structure as closely as possible.” The user also confirmed the framework-neutral Java direction.
- **Decided on**: 2026-10-24

## Derived appetite
- `derived_appetite`: conservative

## Pending implications for the next agents
| Agent | Implication | How to honor it |
|---|---|---|
| Curator | No confirmed behavior is removed for paradigm reasons. | Keep all confirmed library contracts; surface gaps separately. |
| Strategist | Dependency modernization is the main goal. | Prefer an incremental strategy with compatibility checkpoints and dependency-by-dependency changes. |
| Designer | Keep a framework-neutral Java library. | Avoid mandatory DI containers or a service deployment topology; preserve module boundaries pending evidence. |
| Inspector | Compatibility matters. | Derive parity checks from existing specs and flag every intentionally changed public contract. |

## Notes
Java 17 is the maintainer-approved target minimum. Downstream Java 7 compatibility remains a release/support concern, not an unresolved target selection. The requested “latest reasonably possible” dependency versions need version and Java-baseline verification during implementation planning.
