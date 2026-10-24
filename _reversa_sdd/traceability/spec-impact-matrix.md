# Spec Impact Matrix

| Change area | Directly affected modules | Related contracts / specs | Wider impact |
|---|---|---|---|
| HTTP request parsing, methods, headers, body limits | `core` | `IHTTPSession`, `HTTPSession`, `Method`, `Status` | `websocket`, `webserver`, `nanolets`, `fileupload`, `samples` |
| Handler/interceptor dispatch | `core` | `IHandler`, interceptors, handler lifecycle | `websocket` upgrade, application handlers, all server extensions |
| Response status, headers, streaming, gzip, keep-alive | `core` | `Response`, `IStatus`, `ChunkedOutputStream` | Every module that returns responses |
| WebSocket handshake, frame parsing, callbacks | `websocket` | `NanoWSD`, `WebSocket`, `WebSocketFrame`, `CloseCode` | Depends on core request/session and response behavior |
| Local path resolution, directory/index behavior, range requests, CORS | `webserver` | `SimpleWebServer`, file response rules | `markdown-plugin`; filesystem deployment policy |
| URI pattern matching, route priorities, method dispatch | `nanolets` | `UriResource`, `UriRouter`, `UriResponder` | Depends on core session and response contracts |
| Multipart upload parsing / storage behavior | `fileupload` | `NanoFileUpload`, `NanoHttpdContext`, Commons FileUpload configuration | Depends on core request stream; host-provided `FileItemFactory` |
| Markdown conversion and MIME registration | `markdown-plugin` | Plugin metadata and rendered HTML behavior | Depends on webserver plugin lifecycle and Pegdown |
| Sample behavior | `samples` | Examples and demonstration policy | Illustrative only; not a core runtime dependency |
| Maven coordinates and publication aliases | `relocation` | Relocation POMs and `relocated.txt` markers | Consumer dependency resolution; no runtime code impact |
| Dependency/build compatibility | root Maven and Gradle descriptors | Java 7 target, plugin/dependency versions | All compiled artifacts and tests |

**Reading the matrix:** changes to `core` request/session/response contracts have the broadest impact. Optional modules depend on core; Markdown additionally depends on the webserver plugin contract. These relationships are 🟢 **CONFIRMED** by imports and build declarations. Higher-level deployment and application policy impacts are 🟡 **INFERRED**.
