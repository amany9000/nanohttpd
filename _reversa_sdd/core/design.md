# Core HTTP Server, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| NanoHTTPD.start | (int timeout, boolean daemon) | void, throws IOException | 🟢 Starts listener and waits for bind result. |
| IHandler.handle | (IHTTPSession) | Response | 🟢 Request-response extension point. |
| IHTTPSession.execute | () | void, throws IOException | 🟢 Parses one request. |
| IHTTPSession.parseBody | (Map<String,String>) | void | 🟢 Parses supported body forms. |
| Response.send | (OutputStream) | void | 🟢 Writes response. |

## Main Flow
1. 🟢 NanoHTTPD.start creates socket and listener thread (NanoHTTPD.java:579-625).
2. 🟢 Accepted clients are delegated through ClientHandler and a session.
3. 🟢 HTTPSession.execute parses request bytes and invokes handler (HTTPSession.java:338-425).
4. 🟢 Cookies, request method, gzip acceptance, and keep-alive are applied to the response.
5. 🟢 Response.send writes headers/body; session finally clears temporary resources.

## Alternative Flows
- 🟢 Parse errors become responses using ResponseException status.
- 🟢 Socket/timeouts terminate a connection; SSL/generic I/O attempts 500.
- 🟢 Multipart, URL-encoded, raw POST, and PUT bodies use distinct branches.
- 🟢 HEAD suppresses body; chunking and gzip follow request/response settings.

## Dependencies
- 🟢 websocket, webserver, nanolets, fileupload, markdown-plugin, and samples use core APIs.
- 🟢 Core uses JDK sockets, streams, charset, and file APIs; no production database or remote client found.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Handler/interceptor interfaces separate request behavior from socket handling. | NanoHTTPD.java:374-405; IHandler.java | 🟢 |
| 🟢 Async runner, socket factory, and temp-file factory are replaceable. | NanoHTTPD.java:416-432,496-528,559-578 | 🟢 |
| 🟢 Response supports fixed-length, chunked, and gzip paths. | Response.java:228-366 | 🟢 |

## Internal State
- 🟢 NanoHTTPD holds socket/thread, handlers, port/hostname, runner, and temp-file factory.
- 🟢 HTTPSession holds request fields, streams, cookies, and protocol version.
- 🟢 Response holds status, body, headers/cookies, transfer mode, keep-alive, and gzip policy.

## Observability
- 🟢 Java logging reports server/protocol errors; samples may print request details.
- 🔴 No metrics/tracing integration was found.

## Risks and Gaps
- 🔴 Request/body size limits are unspecified.
- 🔴 Malformed percent-encoding policy needs maintainer validation.
- 🟡 Temp-file lifecycle depends on configured implementation.

