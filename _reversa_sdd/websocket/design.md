# WebSocket Module, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| NanoWSD.handleWebSocket | (IHTTPSession) | Response | 🟢 Validates upgrade and builds handshake. |
| WebSocket.openWebSocket | (IHTTPSession) | WebSocket | 🟢 Abstract host callback to create connection. |
| WebSocket.onMessage | (WebSocketFrame) | void | 🟢 Host callback for data messages. |
| WebSocketFrame.read | (InputStream) | WebSocketFrame | 🟢 Parses a frame. |

## Main Flow
1. 🟢 NanoWSD interceptor validates upgrade headers and version/key.
2. 🟢 Accept key is Base64(SHA-1(key + protocol GUID)).
3. 🟢 Response enters CONNECTING, writes 101, enters OPEN, and calls onOpen.
4. 🟢 Read loop decodes frames and dispatches messages, ping/pong, close, or protocol errors.
5. 🟢 Close path closes streams and calls onClose.

## Alternative Flows
- 🟢 Invalid handshake returns 400; unavailable SHA-1 returns 500.
- 🟢 Invalid payload encoding and WebSocketException trigger close behavior.
- 🟢 Fragment sequences are accumulated; invalid sequence raises protocol error.
- 🟡 The read loop is synchronous inside response send; actual resource usage depends on core runner.

## Dependencies
- 🟢 Core session, response, status, and handler APIs.
- 🟢 JDK stream, digest, and encoding APIs.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 WebSocket upgrade is implemented as an HTTP interceptor. | NanoWSD.java:121-141 | 🟢 |
| 🟢 Frame codec validates lengths and control-frame constraints. | WebSocketFrame.java:238-279 | 🟢 |

## Internal State
- 🟢 WebSocket state enum: UNCONNECTED, CONNECTING, OPEN, CLOSING, CLOSED.
- 🟢 Fragmented messages retain the initial opcode and a list of frames.

## Observability
- 🟢 Callback hooks report exceptions and optionally sent/received frames.
- 🔴 Metrics/tracing are absent.

## Risks and Gaps
- 🔴 Large frame input allocates a byte array without a configurable maximum.
- 🔴 Masking policy and maximum message size need maintainer confirmation.

