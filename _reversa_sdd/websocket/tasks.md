# WebSocket Module, Implementation Tasks

## Prerequisites
- [ ] 🟢 Implement core handler/session/response contracts.
- [ ] 🔴 Agree on maximum frame and assembled message size.

## Tasks
- [ ] T-01 Implement handshake validation and accept-key response.
  - Legacy source: websocket/src/main/java/org/nanohttpd/protocols/websockets/NanoWSD.java:142-197
  - Definition of done: 🟢 Valid upgrade returns 101; wrong version/key returns 400.
  - Confidence: 🟢
- [ ] T-02 Implement frame length parsing, masking, and opcode validation.
  - Legacy source: websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocketFrame.java:63-103,238-279
  - Definition of done: 🟢 Valid frame forms decode; invalid control and lengths raise protocol errors.
  - Confidence: 🟢
- [ ] T-03 Implement dispatch, fragmentation, ping/pong, and close callbacks.
  - Legacy source: websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocket.java:161-257
  - Definition of done: 🟢 Callback and state transitions match documented lifecycle.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Handshake acceptance/rejection scenarios.
- [ ] TT-02 🟢 Text, binary, masking, and fragmentation.
- [ ] TT-03 🟢 Ping/pong, close, and invalid frame cases.

## Suggested Order
1. 🟢 Frame codec.
2. 🟢 Handshake and connection state.
3. 🟢 Callbacks and host extension points.

## Pending Gaps (🔴)
- 🔴 Confirm frame/message size caps and server-side masking expectations.

