# Legacy Mapping: samples

| Sample | Legacy file | Behavior |
|---|---|---|
| Hello server | `samples/src/main/java/org/nanohttpd/samples/http/HelloServer.java` | Starts on port 8080; echoes the `username` query parameter in a fixed HTML response |
| Debug server | `samples/src/main/java/org/nanohttpd/samples/http/DebugServer.java` | Prints request URI, method, headers, parameters, and parsed body values |
| Temporary-file server | `samples/src/main/java/org/nanohttpd/samples/tempfiles/TempFilesServer.java` | Installs an example per-request temp-file manager and runs the debug server |
| WebSocket samples | `websocket/src/main/java/org/nanohttpd/samples/websockets/` | Debug and echo WebSocket endpoints are packaged with the WebSocket module |

These are demonstration launchers, not additional product-domain services.
