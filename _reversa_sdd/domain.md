# Domain Model and Implicit Rules

## Scope

NanoHTTPD is an embeddable Java HTTP server library. Its domain is protocol handling and optional server capabilities (WebSocket, static file serving, URI routing, multipart integration, and Markdown rendering), not an end-user business domain. 🟢 **CONFIRMED** from the modules and public contracts.

## Glossary

| Term | Meaning | Confidence |
|---|---|---|
| Server | A `NanoHTTPD` instance bound to a configured hostname/port and serving socket connections | 🟢 CONFIRMED |
| Session | One parsed HTTP request and the associated streams, headers, parameters, cookies, and peer address | 🟢 CONFIRMED |
| Handler | Application-supplied logic that turns an `IHTTPSession` into a `Response` | 🟢 CONFIRMED |
| Interceptor | A handler-like layer that can inspect or handle a session before the main handler | 🟢 CONFIRMED |
| Response | Status, headers, cookies, and optional streamed body serialized to the client | 🟢 CONFIRMED |
| Nanolet | A URI route mapped to a responder class with method-specific callbacks | 🟢 CONFIRMED |
| WebSocket | A connection upgraded from HTTP and then processed as frames until closure | 🟢 CONFIRMED |
| Web server root | A configured local directory used as a base for file serving | 🟢 CONFIRMED |
| Plugin | An optional MIME-aware extension that can render or otherwise serve a resource | 🟢 CONFIRMED |
| Temp-file manager | Per-request strategy used to create and clean up temporary request-body files | 🟢 CONFIRMED |

## Confirmed rules

1. A malformed request line or unsupported HTTP method produces a `400 Bad Request` protocol response. 🟢 **CONFIRMED** (`HTTPSession.decodeHeader()` and `Method.lookup()`).
2. HTTP/1.1 requests remain open unless the `Connection` header contains `close`; response connection policy follows that decision unless explicitly closed by the response. 🟢 **CONFIRMED** (`HTTPSession.execute()`).
3. Request body storage uses memory below 1,024 bytes and a temporary file at or above that threshold. 🟢 **CONFIRMED** (`HTTPSession.parseBody()`).
4. POST multipart parsing requires a boundary; URL-encoded POST fields are decoded, other raw POST text is exposed as `postData`, and PUT data is exposed as `content`. 🟢 **CONFIRMED** (`HTTPSession.parseBody()`).
5. A WebSocket handshake requires an Upgrade request, WebSocket version 13, and a key. Ping frames receive a pong with the same payload; protocol-invalid frames cause a protocol close. 🟢 **CONFIRMED** (`NanoWSD`, `WebSocket`, `WebSocketFrame`).
6. The local web server refuses URIs containing `../`, redirects directories lacking a final slash, and serves an index file or a directory listing. 🟢 **CONFIRMED** (`SimpleWebServer`).
7. A Nanolets route is selected by full URI-pattern match; method-specific responder callbacks exist for GET, POST, PUT, and DELETE. 🟢 **CONFIRMED** (`RouterNanoHTTPD`).
8. A Markdown plugin advertises `text/markdown`, uses `index.md`, and returns rendered HTML. 🟢 **CONFIRMED** (`MarkdownWebServerPluginInfo`).

## Inferred domain rules

- The primary design goal is embedding a small server in other Java applications, with protocol and storage strategies replaceable by the host application. 🟡 **INFERRED** from library description, interfaces, and extension points.
- The library intentionally leaves account authentication, authorization, and business validation to the application using it. 🟡 **INFERRED** from the absence of identity/role/domain entities and the handler boundary.
- The `relocation/` artifacts exist to maintain compatibility for consumers of the former `com.nanohttpd` Maven coordinates. 🟡 **INFERRED** from the relocation POMs and marker resources.

## Gaps requiring product or maintainer context

- 🔴 **GAP:** supported request, header, upload, and WebSocket frame size limits are not specified as a consistent policy.
- 🔴 **GAP:** expected authentication/authorization integration patterns are not specified by the core library.
- 🔴 **GAP:** the security policy for directory listings and generated Markdown HTML is not documented in this repository snapshot.
- 🔴 **GAP:** the maintenance/deprecation horizon for relocated Maven coordinates is not documented.

## History notes

Git history is available through HEAD `efb2ebf` dated 2019-07-03. It shows iterative extraction of modules, handler pluggability, added HTTP verbs, exception-path adjustments, a second build system, and removal of a reverse-DNS hostname lookup. These are captured as retrospective ADRs under `adrs/`; inferred rationale is labeled as such.
