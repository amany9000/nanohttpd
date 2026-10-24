---
schemaVersion: 1
generatedAt: 2026-10-24T08:33:48Z
reversa:
  version: "1.3.6"
kind: ambiguity_log
producedBy: orchestrator
hash: "sha256:9a1ae1feeff54d5d8984d04519f6cbb44c4a33eef055c1d24d2e8ff7312f2099"
---

# Ambiguity Log

> Consolidation of pending decisions for the Migration Team.

## Summary
- Total items: 17
- PENDING: 0
- RESOLVED BY HUMAN DECISION: 13
- DEFERRED TO CODING: 4

## Items

### AMB-001
- **Description**: Request line, header, request body, and upload size limits are not a unified contract.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-001; _reversa_sdd/core/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 1
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend configurable finite defaults with explicit override points and consistent failure responses.

### AMB-002
- **Description**: Malformed percent-encoding behavior is unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-002; _reversa_sdd/core/design.md § URI decoding; `_reversa_sdd/questions.md` Question 2
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend reject malformed encodings with a client error while retaining valid legacy decoding behavior.

### AMB-003
- **Description**: Temporary storage location, permissions, cleanup guarantees, and memory-to-disk threshold are not fully specified as supported policy.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-003; _reversa_sdd/core/questions.md and `_reversa_sdd/fileupload/questions.md`; `_reversa_sdd/questions.md` Question 3
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend secure OS-managed temporary storage, restrictive permissions where supported, guaranteed cleanup on normal/error paths, and configurable threshold.

### AMB-004
- **Description**: Maximum WebSocket frame allocation and assembled-message size are unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-004; _reversa_sdd/websocket/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 4
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend configurable finite frame and assembled-message caps with protocol-appropriate closure on overflow.

### AMB-005
- **Description**: Incoming masking enforcement and callback-failure close/callback behavior are not fully specified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-005; _reversa_sdd/websocket/contracts.md; `_reversa_sdd/questions.md` Question 5
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend enforce client masking and close the connection predictably after callback failure while reporting the error hook once.

### AMB-006
- **Description**: Canonical path and symlink containment within configured roots are unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-006; _reversa_sdd/webserver/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 6
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend canonicalize and ensure resolved paths remain beneath an allowed root, including symlink resolution.

### AMB-007
- **Description**: Directory listing default, HTML escaping, and CORS expectations need maintainer validation.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-007; _reversa_sdd/webserver/questions.md; `_reversa_sdd/questions.md` Question 7
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend preserve listing only as an explicit configurable feature, escape all listing data, and keep CORS opt-in with explicit origins.

### AMB-008
- **Description**: Handler lifecycle, route priority, and unsupported method compatibility are not fully specified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-008; _reversa_sdd/nanolets/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 8
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend preserve current priority order and callback behavior; document responder instance lifecycle before changing it.

### AMB-009
- **Description**: FileItemFactory, upload caps, and repeated body stream reads are host-configured or unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-009; _reversa_sdd/fileupload/contracts.md; `_reversa_sdd/questions.md` Question 9
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend retain caller-supplied factory, expose upload caps through configuration, and document the session stream as single-consumption unless buffering is explicit.

### AMB-010
- **Description**: Markdown input encoding and generated HTML trust/sanitization are unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-010; _reversa_sdd/markdown-plugin/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 10
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend UTF-8 input and a documented safe-rendering mode; preserve raw HTML only when explicitly trusted/configured.

### AMB-011
- **Description**: Escaping of reflected request values in sample HTML is unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-011; _reversa_sdd/samples/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 11
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend HTML-escape reflected values so samples teach safe response construction.

### AMB-012
- **Description**: Support duration for legacy Maven relocation coordinates is unspecified.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-012; _reversa_sdd/relocation/requirements.md § Business Rules; `_reversa_sdd/questions.md` Question 12
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend retain relocation artifacts through at least one announced major release cycle, then deprecate with a published horizon.

### AMB-013
- **Description**: Deployment hardening and handler-level authentication guidance are absent from this library snapshot.
- **Detected by**: curator
- **Source**: `_reversa_sdd/migration/target_business_rules.md` § BR-HUMAN-013; _reversa_sdd/architecture.md § Technical debt and risks; `_reversa_sdd/questions.md` Question 13
- **Status**: RESOLVED BY HUMAN DECISION
- **Decision made**: Accept the Curator recommendation. Decider: Aman. Recorded: 2026-10-24 (following maintainer approval). Rationale: maintainer approved the recommendations as a set.
- **Recommendation**: Recommend keep authentication in host handlers and document secure deployment, TLS, limits, and exposure boundaries without adding core auth.

## Items deferred to coding

None.

## Notes

Maintainer decisions are required before these recommendations become contractual requirements. Other implementation choices may follow the conservative direction already selected.
