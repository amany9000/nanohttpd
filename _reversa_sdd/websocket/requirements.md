# WebSocket Module

## Overview
🟢 Adds HTTP upgrade handling and WebSocket frame processing over NanoHTTPD core.

## Responsibilities
- 🟢 Validate upgrade headers/version/key and return a 101 handshake.
- 🟢 Decode/encode WebSocket frames and dispatch callbacks.
- 🟢 Handle ping/pong, fragmented messages, and close lifecycle.

## Business Rules
- 🟢 Handshake requires Upgrade: websocket, Connection containing Upgrade, version 13, and Sec-WebSocket-Key.
- 🟢 Control frames are final and limited to 125 bytes.
- 🟢 Ping receives a Pong with the same payload.
- 🔴 Maximum data-frame allocation is not configured.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Upgrade valid HTTP requests to WebSocket. | Must | Valid version/key returns 101 and accept header. |
| FR-02 | 🟢 Reject invalid handshakes. | Must | Missing key or wrong version returns 400. |
| FR-03 | 🟢 Dispatch text/binary and fragmented messages to callbacks. | Must | Final fragment produces one assembled message. |
| FR-04 | 🟢 Answer ping and process close/error events. | Should | Ping gets Pong; close invokes callback and closes streams. |

## Acceptance Criteria
Given valid upgrade headers, when handshake is handled, then the response is 101 with Sec-WebSocket-Accept. 🟢
Given version mismatch or missing key, when upgrade is requested, then response is 400. 🟢
Given a ping frame, when received, then a pong frame carries the same payload. 🟢
Given an invalid fragmented control frame, when decoded, then protocol error handling closes the connection. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| Handshake and frame dispatch | Must | 🟢 Core module behavior. |
| Fragmentation and close handling | Must | 🟢 Required protocol lifecycle. |
| Debug hooks | Could | 🟢 Optional no-op extension points. |

## Code Traceability
| File | Coverage |
|---|---|
| websocket/src/main/java/org/nanohttpd/protocols/websockets/NanoWSD.java | 🟢 |
| websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocket.java | 🟢 |
| websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocketFrame.java | 🟢 |

