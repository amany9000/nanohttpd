# Legacy Mapping: websocket

| Concern | Legacy files | Evidence |
|---|---|---|
| HTTP upgrade handling and handshake response | `websocket/src/main/java/org/nanohttpd/protocols/websockets/NanoWSD.java` | `handleWebSocket()` L159-EOF |
| Connection lifecycle, callback contract and frame dispatch | `websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocket.java` | `WebSocket` L48-76, frame handlers L161-257 |
| Frame parsing, payload masks and serialization | `websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocketFrame.java` | `read()` L63-86, payload methods L217-279, `write()` L326-EOF |
| Close payload and reason codes | `CloseFrame.java`, `CloseCode.java` | `websocket/src/main/java/org/nanohttpd/protocols/websockets/` |
| Opcode vocabulary and protocol errors | `OpCode.java`, `WebSocketException.java` | Protocol frame validation dependencies |
| Examples and tests | `websocket/src/main/java/.../samples/`, `websocket/src/test/java/.../websockets/` | Echo and response handler coverage |
