---
schemaVersion: 1
generatedAt: 2026-10-24T08:28:08Z
reversa:
  version: "1.3.6"
kind: target_data_model
producedBy: designer
hash: "sha256:e7db85d8eb2ba8b87509dae8f1074a6c6d1b9a1626139ab8a7816b2aafc9bd14"
---

# Target Data Model

> This library has no application database or persistent business data model. No database is introduced by the migration.

## Overview
The runtime uses in-memory request/session objects and temporary request-body storage. The webserver reads consumer-selected files; it does not own or migrate those files. Build and relocation metadata are packaged artifacts, not runtime records.

## Data entities

None. There are no tables, collections, aggregates, or persistent records in the inspected system specs. Temporary files are transient implementation resources, not a database schema.

## Schema

Not applicable. No SQL DDL or database schema is proposed.

## Relationships

No persisted entity relationships exist. Runtime references follow the component boundaries in `target_architecture.md`: a session is dispatched to a host handler; optional modules adapt the session or serve configured files.

## Constraints

- **Uniqueness**: Not applicable to a persistent data store.
- **Referential integrity**: Not applicable; no database is present.
- **Partitioning / sharding**: Not applicable.
- **Indexes**: Not applicable.
- **Temporary storage**: Preserve the request-body memory/file strategy as a runtime concern; apply the maintainer-approved secure storage recommendation and make cleanup behavior explicit.

## Paradigm-specific considerations

No event store, outbox, queue, or immutable persistence layer is needed. The target remains a synchronous, class-based library.

## Origin in legacy

| New data store / record | Legacy origin | Transformation |
|---|---|---|
| None | `_reversa_sdd/architecture.md` § Integrations and boundaries; `_reversa_sdd/domain.md` § Scope | No persistent database was found; no data schema is migrated. |
| Temporary request-body files | `_reversa_sdd/core/requirements.md` § Business Rules | Runtime temporary storage remains; policy is clarified per approved Curator recommendation, without treating files as durable records. |
| Static content files | `_reversa_sdd/webserver/requirements.md` | Remain owned and managed by embedding consumers; no file corpus migration is in scope. |

## Notes

Do not infer an application database from server request data. The host application owns any business persistence and migration outside this library project.
