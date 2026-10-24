# ADR 005: Expand the accepted HTTP method vocabulary

- **Status:** Retrospective; decision inferred from source history
- **Date:** 2018-01-31
- **Evidence:** commit `6af572b` (“Support more HTTP verbs”) adds `NOTIFY` and `SUBSCRIBE` to `Method`
- **Confidence:** 🟢 CONFIRMED for the change; 🟡 INFERRED for its intended client ecosystem

## Context

The method enum previously ended with WebDAV methods and returned null for unrecognized tokens, causing the HTTP session parser to reject them.

## Decision

Add additional known method tokens to the accepted method enum rather than accepting arbitrary extension strings.

## Consequences

- Requests using the newly listed verbs can reach application handlers.
- Other unknown method tokens still result in a bad-request response.
- Method support and route responder behavior remain separate: Nanolets sends non-GET/POST/PUT/DELETE methods to `other()`.

## Alternatives considered

No alternatives are recorded in the commit.
