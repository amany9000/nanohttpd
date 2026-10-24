---
schemaVersion: 1
generatedAt: 2026-10-24T08:22:46Z
reversa:
  version: "1.3.6"
kind: target_business_rules
producedBy: curator
hash: "sha256:938c6d95e038216d5af2ce16b8246ad5bb99e636c6d47e97d1cdbc7199fbd374"
---

# Target Business Rules

> Legacy rules classified for migration under the conservative, framework-neutral Java direction. Unresolved policy gaps remain HUMAN DECISION items.

## Summary
- Total rules analyzed: 27
- MIGRATE: 14
- DISCARD: 0
- HUMAN DECISION: 13

## MIGRATE rules

### BR-MIGRATE-001
- **Source**: `_reversa_sdd/core/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Unknown methods and malformed requests produce HTTP 400.
- **Migration justification**: Protocol compatibility is central to the library.
- **Compatibility with the target paradigm**: Keep parsing and response behavior stable; add explicit tests before parser changes.

### BR-MIGRATE-002
- **Source**: `_reversa_sdd/core/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: HTTP/1.1 connections remain open unless Connection contains close, subject to response policy.
- **Migration justification**: Core connection semantics are part of the embedding contract.
- **Compatibility with the target paradigm**: Preserve keep-alive behavior and response overrides.

### BR-MIGRATE-003
- **Source**: `_reversa_sdd/core/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Request bodies below 1,024 bytes use memory and larger bodies use temporary storage.
- **Migration justification**: This storage behavior is documented and supports the lightweight server.
- **Compatibility with the target paradigm**: Preserve threshold behavior unless a measured compatibility-safe change is approved.

### BR-MIGRATE-004
- **Source**: `_reversa_sdd/core/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Multipart POST requires a boundary; URL-encoded/raw POST and PUT bodies are exposed through their documented session fields.
- **Migration justification**: Consumers may rely on request parsing and body access.
- **Compatibility with the target paradigm**: Preserve current field semantics and stream lifecycle.

### BR-MIGRATE-005
- **Source**: `_reversa_sdd/websocket/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: WebSocket upgrade validates required headers/version/key; ping returns matching pong; control frames are final and at most 125 bytes.
- **Migration justification**: These are protocol-level contracts.
- **Compatibility with the target paradigm**: Maintain handshake and control-frame behavior; treat resource caps as an open policy decision.

### BR-MIGRATE-006
- **Source**: `_reversa_sdd/webserver/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Static serving rejects `../`, redirects directory paths to a slash form, and serves an index or listing.
- **Migration justification**: These behaviors define the optional static server module.
- **Compatibility with the target paradigm**: Preserve routing while resolving the outstanding containment and listing security policies.

### BR-MIGRATE-007
- **Source**: `_reversa_sdd/webserver/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Range and ETag requests can produce 206, 304, or 416 responses.
- **Migration justification**: HTTP conditional and range semantics are confirmed behavior.
- **Compatibility with the target paradigm**: Retain response semantics and verify against the existing spec cases.

### BR-MIGRATE-008
- **Source**: `_reversa_sdd/nanolets/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Nanolets requires full URI-pattern matches and selects the first matching route in prioritizer order.
- **Migration justification**: The behavior is a confirmed routing contract.
- **Compatibility with the target paradigm**: Preserve normalization, priority order, and fallback callbacks.

### BR-MIGRATE-009
- **Source**: `_reversa_sdd/nanolets/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Nanolets dispatches method callbacks and converts responder errors to HTTP 500.
- **Migration justification**: Consumers implement responder callbacks against this behavior.
- **Compatibility with the target paradigm**: Preserve current callbacks and error mapping pending lifecycle policy decision.

### BR-MIGRATE-010
- **Source**: `_reversa_sdd/fileupload/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Multipart detection applies to POST; the adapter exposes UTF-8 and delegates parsing to a caller-supplied FileItemFactory.
- **Migration justification**: This keeps storage configurable by the host.
- **Compatibility with the target paradigm**: Maintain the adapter boundary and avoid imposing a storage factory on consumers.

### BR-MIGRATE-011
- **Source**: `_reversa_sdd/markdown-plugin/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: The optional plugin serves Markdown as UTF-8 HTML, uses `index.md`, and falls back when reading fails.
- **Migration justification**: This is the current optional module contract.
- **Compatibility with the target paradigm**: Keep the plugin optional; implement the still-open sanitization/trust policy as a documented decision.

### BR-MIGRATE-012
- **Source**: `_reversa_sdd/samples/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Samples demonstrate request inspection and custom temporary-file cleanup.
- **Migration justification**: Examples are part of the consumer-facing learning surface.
- **Compatibility with the target paradigm**: Keep representative examples, with the escaping gap resolved before recommending public exposure.

### BR-MIGRATE-013
- **Source**: `_reversa_sdd/relocation/requirements.md § Business Rules`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: Legacy Maven coordinates redirect to `org.nanohttpd` artifacts through relocation metadata.
- **Migration justification**: Coordinate continuity supports existing consumers.
- **Compatibility with the target paradigm**: Retain relocation metadata during migration; support horizon remains a maintainer decision.

### BR-MIGRATE-014
- **Source**: `_reversa_sdd/architecture.md § System shape`
- **Original confidence**: 🟢 CONFIRMED
- **Description**: NanoHTTPD remains an embeddable Java library whose host application supplies request business logic.
- **Migration justification**: This matches the migration brief and selected conservative direction.
- **Compatibility with the target paradigm**: Avoid converting the library into a separately deployed service or adding mandatory application infrastructure.

## DISCARD rules

None. The user included all documented modules and selected a conservative approach; no confirmed rule is out of scope or invalidated by a paradigm change.

## HUMAN DECISION rules

### BR-HUMAN-001
- **Source**: _reversa_sdd/core/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 1
- **Type of ambiguity**: 🔴 GAP
- **Description**: Request line, header, request body, and upload size limits are not a unified contract.
- **Options**: Maintainer must select compatibility defaults and whether core and upload limits are independently configurable.
- **Curator's recommendation**: Recommend configurable finite defaults with explicit override points and consistent failure responses.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-002
- **Source**: _reversa_sdd/core/design.md § URI decoding; `_reversa_sdd/questions.md` Question 2
- **Type of ambiguity**: 🔴 GAP
- **Description**: Malformed percent-encoding behavior is unspecified.
- **Options**: Maintainer must decide reject, preserve, or normalize for compatibility.
- **Curator's recommendation**: Recommend reject malformed encodings with a client error while retaining valid legacy decoding behavior.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-003
- **Source**: _reversa_sdd/core/questions.md and `_reversa_sdd/fileupload/questions.md`; `_reversa_sdd/questions.md` Question 3
- **Type of ambiguity**: 🔴 GAP
- **Description**: Temporary storage location, permissions, cleanup guarantees, and memory-to-disk threshold are not fully specified as supported policy.
- **Options**: Confirm supported locations, permissions, cleanup guarantees, and threshold.
- **Curator's recommendation**: Recommend secure OS-managed temporary storage, restrictive permissions where supported, guaranteed cleanup on normal/error paths, and configurable threshold.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-004
- **Source**: _reversa_sdd/websocket/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 4
- **Type of ambiguity**: 🔴 GAP
- **Description**: Maximum WebSocket frame allocation and assembled-message size are unspecified.
- **Options**: Select default caps and configurability.
- **Curator's recommendation**: Recommend configurable finite frame and assembled-message caps with protocol-appropriate closure on overflow.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-005
- **Source**: _reversa_sdd/websocket/contracts.md; `_reversa_sdd/questions.md` Question 5
- **Type of ambiguity**: 🔴 GAP
- **Description**: Incoming masking enforcement and callback-failure close/callback behavior are not fully specified.
- **Options**: Confirm protocol enforcement and callback/close semantics.
- **Curator's recommendation**: Recommend enforce client masking and close the connection predictably after callback failure while reporting the error hook once.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-006
- **Source**: _reversa_sdd/webserver/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 6
- **Type of ambiguity**: 🔴 GAP
- **Description**: Canonical path and symlink containment within configured roots are unspecified.
- **Options**: Confirm containment/security compatibility policy.
- **Curator's recommendation**: Recommend canonicalize and ensure resolved paths remain beneath an allowed root, including symlink resolution.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-007
- **Source**: _reversa_sdd/webserver/questions.md; `_reversa_sdd/questions.md` Question 7
- **Type of ambiguity**: 🔴 GAP
- **Description**: Directory listing default, HTML escaping, and CORS expectations need maintainer validation.
- **Options**: Confirm defaults and CORS policy.
- **Curator's recommendation**: Recommend preserve listing only as an explicit configurable feature, escape all listing data, and keep CORS opt-in with explicit origins.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-008
- **Source**: _reversa_sdd/nanolets/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 8
- **Type of ambiguity**: 🔴 GAP
- **Description**: Handler lifecycle, route priority, and unsupported method compatibility are not fully specified.
- **Options**: Confirm instance scope and unsupported-method response expectations.
- **Curator's recommendation**: Recommend preserve current priority order and callback behavior; document responder instance lifecycle before changing it.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-009
- **Source**: _reversa_sdd/fileupload/contracts.md; `_reversa_sdd/questions.md` Question 9
- **Type of ambiguity**: 🔴 GAP
- **Description**: FileItemFactory, upload caps, and repeated body stream reads are host-configured or unspecified.
- **Options**: Confirm factory/version direction, limits, and repeat-read contract.
- **Curator's recommendation**: Recommend retain caller-supplied factory, expose upload caps through configuration, and document the session stream as single-consumption unless buffering is explicit.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-010
- **Source**: _reversa_sdd/markdown-plugin/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 10
- **Type of ambiguity**: 🔴 GAP
- **Description**: Markdown input encoding and generated HTML trust/sanitization are unspecified.
- **Options**: Choose sanitization and raw HTML policy.
- **Curator's recommendation**: Recommend UTF-8 input and a documented safe-rendering mode; preserve raw HTML only when explicitly trusted/configured.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-011
- **Source**: _reversa_sdd/samples/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 11
- **Type of ambiguity**: 🔴 GAP
- **Description**: Escaping of reflected request values in sample HTML is unspecified.
- **Options**: Confirm sample policy.
- **Curator's recommendation**: Recommend HTML-escape reflected values so samples teach safe response construction.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-012
- **Source**: _reversa_sdd/relocation/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 12
- **Type of ambiguity**: 🔴 GAP
- **Description**: Support duration for legacy Maven relocation coordinates is unspecified.
- **Options**: Choose the support and deprecation window.
- **Curator's recommendation**: Recommend retain relocation artifacts through at least one announced major release cycle, then deprecate with a published horizon.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

### BR-HUMAN-013
- **Source**: _reversa_sdd/architecture.md § Technical debt and risks; `_reversa_sdd/questions.md` Question 13
- **Type of ambiguity**: 🔴 GAP
- **Description**: Deployment hardening and handler-level authentication guidance are absent from this library snapshot.
- **Options**: Confirm the documentation guidance and whether a cookbook is in scope.
- **Curator's recommendation**: Recommend keep authentication in host handlers and document secure deployment, TLS, limits, and exposure boundaries without adding core auth.
- **Status**: RESOLVED (approved recommendation; decider: Aman; 2026-10-24)
- **Decision**: Accept the Curator's recommendation as the migration default.

## Notes

These recommendations are proposals, not maintainer-approved contracts. The user delegated other migration judgments to the team, but security, compatibility, and policy gaps are retained for explicit review. No legacy behavior was discarded.
