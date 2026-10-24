# ADR 003: Avoid reverse DNS lookup for session hostnames

- **Status:** Retrospective; decision explicitly stated in commit message
- **Date:** 2019-07-02
- **Evidence:** commit `cd37235` (“removed remoteHostName from HTTPSession: it can take too long time to figure out via DNS”)
- **Confidence:** 🟢 CONFIRMED

## Context

`HTTPSession` previously exposed a remote hostname obtained from the peer `InetAddress`, which can trigger a DNS lookup.

## Decision

Remove `remoteHostName` and `getRemoteHostName()` from the session contract; retain the numeric remote IP address.

## Consequences

- Request handling avoids potentially slow reverse DNS resolution.
- Applications needing hostnames must resolve them outside the request path.
- Removing the method is an API change for callers that used it.

## Alternatives considered

The commit does not record alternatives. Lazy or asynchronous resolution is not evidenced in the repository.
