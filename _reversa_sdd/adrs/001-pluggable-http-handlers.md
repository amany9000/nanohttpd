# ADR 001: Delegate HTTP requests through pluggable handlers

- **Status:** Retrospective; decision inferred from source history
- **Date:** 2016-09-29
- **Evidence:** commit `f57064f` (“HTTP handling is now delegated to an IHandler”), plus `060d6d2` adding child protocol interceptors
- **Confidence:** 🟡 INFERRED

## Context

Earlier handling centered on `NanoHTTPD.serve()`. The change introduced a generic `IHandler<IHTTPSession, Response>`, a setter on the server, and an interceptor chain. The constructor retained a compatibility handler that delegates to the deprecated `serve()` method.

## Decision

Keep request parsing and socket lifecycle in the core server while allowing request/response behavior to be supplied through handler and interceptor interfaces.

## Consequences

- Protocol extensions can participate without replacing the full server class; `NanoWSD` uses an interceptor for WebSocket upgrades.
- Existing subclasses can continue using `serve()` through the compatibility path.
- Handler ordering and null/exception behavior become part of the framework contract and need explicit tests/documentation.

## Alternatives considered

The history does not record alternatives. Plausible alternatives are inferred: keep subclass-only `serve()` customization, or move protocol features into separate server subclasses.
