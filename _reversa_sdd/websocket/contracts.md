# WebSocket Contract

## Handshake
- 🟢 Upgrade header must equal websocket; Connection must contain Upgrade.
- 🟢 Version 13 and a Sec-WebSocket-Key are required.
- 🟢 Response contains Sec-WebSocket-Accept derived using SHA-1 and Base64.
- 🟢 First requested subprotocol token is echoed when present.

## Frames
- 🟢 Control frames must be final and no larger than 125 bytes.
- 🟢 16-bit and 64-bit extended lengths must use minimal encoding.
- 🟢 Close payload length of one byte is rejected.
- 🟢 Text/binary messages and valid fragments reach onMessage.
- 🟢 Ping receives Pong; Pong reaches onPong.
- 🔴 Maximum data frame size is unspecified and decoded payload is allocated in memory.

