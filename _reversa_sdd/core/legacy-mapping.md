# Legacy Mapping: core

| Concern | Legacy files | Evidence |
|---|---|---|
| Server lifecycle and handler registration | `core/src/main/java/org/nanohttpd/protocols/http/NanoHTTPD.java` | `start()` L579, `stop()` L626, handler setup L374-L391 |
| Socket accept and per-client dispatch | `core/src/main/java/org/nanohttpd/protocols/http/ServerRunnable.java`, `ClientHandler.java` | Graph links from server runner and client handler |
| HTTP request parsing and body handling | `core/src/main/java/org/nanohttpd/protocols/http/HTTPSession.java` | `execute()` L338, `parseBody()` L602 |
| Public session contract | `core/src/main/java/org/nanohttpd/protocols/http/IHTTPSession.java` | Interface L48-L92 |
| Response formatting and streaming | `core/src/main/java/org/nanohttpd/protocols/http/response/Response.java`, `ChunkedOutputStream.java` | `send()` L228; body transfer helpers L296-L366 |
| Method and status vocabulary | `core/src/main/java/org/nanohttpd/protocols/http/request/Method.java`, `response/Status.java`, `response/IStatus.java` | Enum definitions |
| Cookies and content types | `core/src/main/java/org/nanohttpd/protocols/http/content/Cookie.java`, `CookieHandler.java`, `ContentType.java` | Core session and response dependencies |
| Temporary upload storage | `core/src/main/java/org/nanohttpd/protocols/http/tempfiles/` | `ITempFileManager`, `ITempFile`, default manager implementations |
| Threading and socket policies | `core/src/main/java/org/nanohttpd/protocols/http/threading/`, `sockets/` | Pluggable runner and socket factories |

Graph communities are heuristic; paths and source line locations are the module boundary evidence.
