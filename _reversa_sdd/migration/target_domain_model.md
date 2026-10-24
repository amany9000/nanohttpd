---
schemaVersion: 1
generatedAt: 2026-10-24T08:28:08Z
reversa:
  version: "1.3.6"
kind: target_domain_model
producedBy: designer
hash: "sha256:85b68956a3d2d6ba4104a0a7a8256dd43958a67cea47f6413942836bb63f6025"
---

# Target Domain Model

> The system is a protocol library rather than a business-domain application. This model describes runtime concepts and maps migration rules without inventing business aggregates.

## Aggregates

None. The discovery artifacts identify no persistent business entities, aggregate roots, or transactional database. HTTP sessions and WebSocket connections are runtime lifecycle objects, not DDD aggregates.

## Entities / runtime concepts

| Concept | Owner / lifecycle | Main data | Legacy origin |
|---|---|---|---|
| Server | `core`; configured and started by host | bind address, port, timeout, handlers | `_reversa_sdd/domain.md` § Glossary (`Server`); core requirements FR-01 |
| HTTP Session | `core`; one parsed request and streams | method, URI, headers, parameters, body access, peer address | `_reversa_sdd/domain.md` § Glossary (`Session`) |
| Handler / Interceptor | Host-owned implementation called by `core` | request-to-response behavior | `_reversa_sdd/domain.md` § Glossary and `_reversa_sdd/core/requirements.md` |
| Response | `core`; serialized per request | status, headers, cookies, body stream | `_reversa_sdd/domain.md` § Glossary (`Response`) |
| WebSocket Connection | `websocket`; upgraded session until close | frame state, callbacks, connection lifecycle | `_reversa_sdd/domain.md` § Glossary (`WebSocket`) |
| Route / Nanolet responder | `nanolets`; registered route and host callback | normalized path pattern, priority, method handler | `_reversa_sdd/nanolets/requirements.md` § Business Rules |
| Resource Plugin | `webserver`; MIME/index extension | MIME types, index names, response hook | `_reversa_sdd/webserver/requirements.md` and Markdown spec |
| Upload item | FileUpload implementation / host factory | parsed multipart field and backing storage | `_reversa_sdd/fileupload/requirements.md` |

## Value objects

| Value object | Attributes | Validations / behavior | Origin |
|---|---|---|---|
| HTTP Method | method token | Known and unknown method handling follows the accepted parser contract | `_reversa_sdd/domain.md` § Confirmed rules |
| Response Status | code and reason | Serialized with response metadata | `_reversa_sdd/core/requirements.md` FR-04 |
| Header collection | names and values | Request/response metadata; encoding edge policies are set by approved Curator decisions | `_reversa_sdd/core/requirements.md` |
| WebSocket Frame | opcode, flags, payload | Control-frame size/finality and ping/pong rules; size caps follow approved recommendation | `_reversa_sdd/websocket/requirements.md` |
| URI route match | normalized path and named parameters | Full match and prioritizer order | `_reversa_sdd/nanolets/requirements.md` |
| Temporary body storage reference | memory/file strategy and cleanup owner | 1,024-byte legacy threshold retained unless explicit compatibility change | `_reversa_sdd/core/requirements.md` |

## Domain events

None. The selected paradigm is synchronous, class-based library behavior with direct callbacks; no event bus or asynchronous domain process is required by the legacy specs.

## Domain rules

| Rule ID | Location in target model | Source |
|---|---|---|
| BR-MIGRATE-001 | HTTP parser / response error mapping | `target_business_rules.md` BR-MIGRATE-001 |
| BR-MIGRATE-002 | Server and HTTP Session connection lifecycle | `target_business_rules.md` BR-MIGRATE-002 |
| BR-MIGRATE-003 | HTTP Session request-body storage | `target_business_rules.md` BR-MIGRATE-003 |
| BR-MIGRATE-004 | HTTP Session body parsing | `target_business_rules.md` BR-MIGRATE-004 |
| BR-MIGRATE-005 | WebSocket Connection and Frame lifecycle | `target_business_rules.md` BR-MIGRATE-005 |
| BR-MIGRATE-006 | Resource Resolution context | `target_business_rules.md` BR-MIGRATE-006 |
| BR-MIGRATE-007 | Resource response validators and ranges | `target_business_rules.md` BR-MIGRATE-007 |
| BR-MIGRATE-008 | Route matching and prioritization | `target_business_rules.md` BR-MIGRATE-008 |
| BR-MIGRATE-009 | Nanolet method dispatch and error mapping | `target_business_rules.md` BR-MIGRATE-009 |
| BR-MIGRATE-010 | Multipart adapter boundary | `target_business_rules.md` BR-MIGRATE-010 |
| BR-MIGRATE-011 | Markdown resource rendering plugin | `target_business_rules.md` BR-MIGRATE-011 |
| BR-MIGRATE-012 | Examples and temporary-file example | `target_business_rules.md` BR-MIGRATE-012 |
| BR-MIGRATE-013 | Relocation compatibility packaging | `target_business_rules.md` BR-MIGRATE-013 |
| BR-MIGRATE-014 | Embeddable library boundary | `target_business_rules.md` BR-MIGRATE-014 |

## Traceability to legacy

| Target element | Legacy origin | Mapping type |
|---|---|---|
| Connection and Protocol Lifecycle context | `_reversa_sdd/core/requirements.md` + `_reversa_sdd/websocket/requirements.md` | merged context across two modules; public module boundaries preserved |
| Resource Resolution and Rendering context | `_reversa_sdd/webserver/requirements.md` + `_reversa_sdd/markdown-plugin/requirements.md` | merged context; plugin remains separately packaged |
| Host Request Extensions context | `_reversa_sdd/nanolets/requirements.md` + `_reversa_sdd/fileupload/requirements.md` | grouped context over shared session contract; modules remain separate due independent dependencies |
| Runtime concepts above | `_reversa_sdd/domain.md` and per-module requirements | mapped from documented protocol/library concepts; no new business entity introduced |
| Example applications | `_reversa_sdd/samples/requirements.md` | preserved support module |
| Relocation metadata | `_reversa_sdd/relocation/requirements.md` | preserved packaging artifact |

## Notes

Recommendations approved by the maintainer become defaults, but numeric limits and detailed edge acceptance cases should be made explicit in implementation specs. This migration does not introduce an application business domain, user accounts, persistence, or domain events.
