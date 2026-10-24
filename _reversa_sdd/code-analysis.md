# Code Analysis

## Core: embedded HTTP server

**Purpose.** `core` implements the embedded HTTP/1.x server, connection lifecycle, request and body parsing, response serialization, socket/thread strategies, cookie handling, and temporary-file abstractions. 🟢 **CONFIRMED** (`NanoHTTPD.java`, `HTTPSession.java`, `Response.java`, `IHTTPSession.java`).

### Request lifecycle

1. `NanoHTTPD` construction stores the optional hostname and port, installs the default temporary-file factory and async runner, and wires a compatibility handler to the deprecated `serve()` method. The base `serve()` returns a fixed-length 404 response. Applications can register an `IHandler<IHTTPSession, Response>` and interceptors. 🟢 `NanoHTTPD.java:350-391,548-558`.
2. `start(timeout, daemon)` creates a server socket, enables address reuse, constructs a `ServerRunnable`, and starts a named listener thread. It waits in 10 ms intervals for bind completion or a bind exception, then propagates the bind exception. 🟢 `NanoHTTPD.java:579-625`.
3. The listener accepts connections and delegates client work through the configurable async runner. `createServerRunnable()` and `createClientHandler()` are protected extension points. 🟢 Structure confirmed by graph relations; implementation details in `ServerRunnable.java` and `ClientHandler.java`.
4. `HTTPSession.execute()` reads up to an 8 KiB request buffer, locating the CRLF header boundary while allowing multiple reads. It parses the request line, URL-decodes the path, separates query parameters, lowercases header names, and maps the method token through `Method.lookup()`. Unsupported or malformed input raises `ResponseException` with an HTTP status. 🟢 `HTTPSession.java:133-190,338-425`.
5. The configured handler receives the `IHTTPSession`. A null response is treated as an internal server error. The session unloads queued cookies, sets the request method, disables gzip when the client has not accepted it, and applies HTTP/1.1 keep-alive rules before sending. 🟢 `HTTPSession.java:404-425`.
6. `Response.send()` writes the status line, content type, date, headers, cookies, connection policy, and transfer metadata. It streams content in 16 KiB chunks, supports chunked transfer and gzip, and suppresses the response body for HEAD. 🟢 `Response.java:228-275,296-366`.
7. Socket and socket-timeout exceptions propagate to terminate the connection. SSL and other I/O exceptions are converted to 500 responses; `ResponseException` uses its embedded status. In all cases the response is closed and the request temporary-file manager is cleared. 🟢 `HTTPSession.java:426-465`.

### Body parsing and storage

`parseBody()` reads the declared body size in 512-byte chunks. Bodies smaller than the 1,024-byte in-memory threshold use a byte array; larger bodies use a temporary random-access file. For POST, multipart form data is parsed using the boundary parameter; URL-encoded forms are decoded into the parameter map; other non-empty POST bodies are exposed under `postData`. PUT content is saved through the temp-file manager under the `content` key. 🟢 `HTTPSession.java:602-692`.

The temp-file manager is a per-request abstraction with `createTempFile()` and `clear()` lifecycle methods. Exact cleanup behavior depends on the configured implementation. 🟢 Interface contract: `ITempFileManager.java:44-50`; 🟡 implementation behavior should be confirmed in module-level analysis.

### Core contracts and structures

- `IHTTPSession` exposes method, URI, headers, cookies, query parameters, body parsing, input stream, and remote IP address. 🟢 `IHTTPSession.java:48-92`.
- `Method` is an enum of HTTP/WebDAV/subscription method tokens. `lookup()` uses exact enum-name matching and returns `null` for unknown or null values; the caller turns this into a 400. 🟢 `Method.java`.
- `Status` maps supported numeric HTTP codes to descriptions; `lookup(int)` scans the enum and returns `null` if no match. 🟢 `Status.java:39-109`.
- `Response` owns status, MIME type, body stream, headers, cookies, request method, keep-alive, chunking, and gzip settings. It has factory methods for fixed-length and chunked responses. 🟢 Graph structure and `Response.java`.
- Data is request/response and filesystem-oriented. No database entities or persistence layer were found. 🟢 Repository inventory.

### Extension and configuration points

`NanoHTTPD` supports custom handlers, interceptors, async runners, temp-file factories, socket factories, and overridable client/server runnable factories. The port and hostname are constructor inputs; the socket read timeout is passed at start. 🟢 `NanoHTTPD.java:350-432,492-528,559-625`.

### Confidence and gaps

- 🟢 **CONFIRMED:** the lifecycle, request parsing contract, method/status handling, response serialization branches, and body storage threshold described above are directly visible in the code.
- 🟡 **INFERRED:** listener, client-handler, socket-factory, and temp-file-manager implementations are separate collaborators; full behavior is distributed among those classes and requires deeper per-class extraction.
- 🔴 **GAP:** intended limits and security expectations for request size, header size, upload size, URL decoding failures, and malformed chunking are not specified by the implementation documentation reviewed here.
- 🔴 **GAP:** a registered handler's application-specific behavior is outside this library's core implementation.

## WebSocket: protocol upgrade and frame lifecycle

**Purpose.** `websocket` extends the core HTTP server with a WebSocket upgrade handler, frame codec, close codes, and callback-based connection API. 🟢 **CONFIRMED** (`NanoWSD.java`, `WebSocket.java`, `WebSocketFrame.java`).

### Handshake and message flow

- `NanoWSD` installs an HTTP interceptor. It accepts a request when `Upgrade` is `websocket` and `Connection` contains `Upgrade` (case-insensitive). It requires version `13` and a `Sec-WebSocket-Key`; otherwise it returns 400. 🟢 `NanoWSD.java:121-141,142-156,159-197`.
- The accept header is Base64(SHA-1(key + the WebSocket GUID)). If the SHA-1 algorithm is unavailable, the handler returns 500. A requested subprotocol is reduced to the first comma-separated token. 🟢 `NanoWSD.java:88-120,171-190`.
- `WebSocket` owns handshake input/output streams, state, fragment accumulation, and abstract callbacks: `onOpen`, `onClose`, `onMessage`, `onPong`, and `onException`. Sending a handshake changes state to OPEN, invokes `onOpen`, then reads frames synchronously. 🟢 `WebSocket.java:48-105`.
- Frame dispatch handles close, ping (automatic pong with the same payload), pong callback, data messages, and fragmented messages. Invalid reserved bits/opcodes, fragmented control frames, invalid fragment sequences, and oversized control frames raise protocol errors. 🟢 `WebSocket.java:161-223`, `WebSocketFrame.java:63-103,238-279`.
- Close moves through CLOSING to CLOSED, closes streams, and calls `onClose`; the callback receives code, reason, and whether the remote peer initiated closure. 🟢 `WebSocket.java:119-152,161-175`.

### Structures and confidence

- A frame carries opcode, FIN flag, optional 4-byte masking key, and byte payload. Length encodings use inline 7-bit, 16-bit, or 64-bit forms; payload lengths beyond `Integer.MAX_VALUE` are rejected. 🟢 `WebSocketFrame.java:45-48,238-279`.
- Control frame payloads are limited to 125 bytes, and close frames with exactly one payload byte are rejected. 🟢 `WebSocketFrame.java:263-275`.
- `CloseCode` includes normal closure, protocol/data errors, policy/size errors, internal error, and TLS handshake codes. Unknown close codes resolve to `null`. 🟢 `CloseCode.java:36-65`.
- 🔴 **GAP:** compatibility and resource limits for unusually large data frames are not configurable in the reviewed code path; the parser allocates a byte array of the decoded payload length.
- 🟡 **INFERRED:** `readWebsocket()` is a synchronous read loop inside handshake response sending, so callback work may occupy the connection's serving thread. The exact execution model also depends on the core async runner.

## Webserver: local file serving and plugins

**Purpose.** `webserver` serves configured local roots over HTTP, renders directory listings, supports conditional/range responses, and delegates selected MIME types to plugins. 🟢 **CONFIRMED** (`SimpleWebServer.java`, plugin interfaces).

- `serve()` validates that each configured root is a directory, then routes OPTIONS requests through the CORS preflight response when CORS is enabled. Other requests go through `defaultRespond()`. 🟢 `SimpleWebServer.java:363-472`.
- URI handling trims whitespace, normalizes platform separators, strips query text, and rejects paths containing `../`. It checks configured roots in order; a path is serviceable if a file exists or a MIME-matched plugin claims it. 🟢 `SimpleWebServer.java:225-239,378-408`.
- Directory requests without a trailing slash redirect. A directory with a recognized index file serves that file; otherwise a readable directory gets an HTML listing and an unreadable directory gets 403. 🟢 `SimpleWebServer.java:261-269,409-438`.
- For regular files, a plugin can return a response or `InternalRewrite`; rewrites are routed again through the response pipeline. Otherwise `serveFile()` streams a file, supports byte ranges and ETags, and responds with 206, 304, 416, or 200 according to the request headers. 🟢 `SimpleWebServer.java:440-572`.
- When CORS is configured, responses include allowed origin, request headers, credentials, methods, and max age. 🟢 `SimpleWebServer.java:580-590`.
- 🟡 **INFERRED:** directory listing links and filenames are assembled into HTML directly; expected escaping behavior should be validated against product security requirements.
- 🔴 **GAP:** no configured default root, plugin set, or CORS policy is established by the inspected library code; these are deployment/application inputs.

## Nanolets: URI-based handler routing

**Purpose.** `nanolets` adds a lightweight router and handler abstractions on top of the core server. Routes map URI patterns to handler classes, named path parameters are extracted, and HTTP methods dispatch to corresponding responder methods. 🟢 **CONFIRMED** (`RouterNanoHTTPD.java`).

- `RouterNanoHTTPD.serve()` delegates each session to `UriRouter.process()`. The router normalizes leading/trailing slashes, iterates the configured route-prioritizer collection, and selects the first full regex match. If none matches, it invokes the configured not-found resource. 🟢 `RouterNanoHTTPD.java:306-319,566-599,669-EOF`.
- A path segment written as `:name` becomes a capture group and is returned in a map keyed by `name`. Routes are represented by `UriResource`, which stores URI pattern, handler class, priority, and initialization arguments. 🟢 `RouterNanoHTTPD.java:320-360,361-410,419-450`.
- The default route prioritizer is a priority queue. Route priority is augmented by registration order; parameterized routes receive an added priority based on parameter count. Other prioritizers support explicit priorities or insertion order. 🟢 `RouterNanoHTTPD.java:340-344,471-565`.
- Matching handler classes are instantiated with a no-argument reflective constructor. `UriResponder` dispatches GET, POST, PUT, DELETE to separate methods and sends all other verbs to `other()`. Exceptions become a 500 text response. 🟢 `RouterNanoHTTPD.java:360-410`.
- Built-in handler types include stream responses (chunked), fixed text responses, static pages rooted at a configured `File`, index handling, 404 handling, and 501 handling. 🟢 `RouterNanoHTTPD.java:88-305`.
- 🔴 **GAP:** route handler construction requires a usable no-argument constructor; no dependency injection or per-route lifecycle management is provided by this code path.
- 🟡 **INFERRED:** default priority semantics may surprise users because order is produced by the combination of registration index and parameter count; the intended relative ordering is documented in source comments but needs compatibility confirmation for existing consumers.

## File upload: Commons FileUpload adapter

**Purpose.** `fileupload` adapts a NanoHTTPD `IHTTPSession` to Apache Commons FileUpload's `UploadContext`, then exposes Commons request parsing and streaming iterator APIs. 🟢 **CONFIRMED** (`NanoFileUpload.java`).

- `NanoHttpdContext` reads `content-length` and `content-type` from session headers, exposes UTF-8 as the character encoding, and returns the session input stream. A missing or invalid content length resolves to `-1`. 🟢 `NanoFileUpload.java:56-100`.
- `isMultipartContent()` returns true only for POST requests that Commons FileUpload identifies as multipart. 🟢 `NanoFileUpload.java:101-105`.
- The adapter takes a caller-supplied `FileItemFactory`; `parseRequest()`, `parseParameterMap()`, and `getItemIterator()` delegate to the parent library with the adapted context. 🟢 `NanoFileUpload.java:102-EOF`.
- 🔴 **GAP:** upload size limits, temporary storage location, memory thresholds, and cleanup policy are defined by the supplied Commons FileUpload factory/configuration and are not set by this adapter.
- 🟡 **INFERRED:** callers should avoid invoking core session body parsing first because both paths read from the request input stream; the code does not coordinate or rewind the stream.

## Markdown plugin: render Markdown from files

**Purpose.** `markdown-plugin` plugs into `webserver` for `text/markdown`, advertises `index.md`, reads a selected file, converts it to HTML with Pegdown, and returns a fixed-length HTML response. 🟢 **CONFIRMED** (`MarkdownWebServerPlugin.java`, `MarkdownWebServerPluginInfo.java`).

- `canServeUri()` checks whether the path exists under the selected root. `initialize()` is empty. 🟢 `MarkdownWebServerPlugin.java:69-78`.
- `readSource()` reads the file line-by-line with the platform-default `FileReader` charset, appending newline characters. It logs and returns null after a read failure. 🟢 `MarkdownWebServerPlugin.java:79-111`.
- `serveFile()` converts the source with a `PegDownProcessor`, encodes output as UTF-8, and returns a `text/html` response. If UTF-8 is unavailable, it returns an empty body. 🟢 `MarkdownWebServerPlugin.java:112-EOF`.
- `MarkdownWebServerPluginInfo` registers `index.md` and MIME type `text/markdown`, and creates a new plugin instance. 🟢 `MarkdownWebServerPluginInfo.java`.
- 🟡 **INFERRED:** input file decoding can vary by host because `FileReader` uses the platform default charset while output is fixed to UTF-8.
- 🔴 **GAP:** Markdown rendering options, sanitization policy, and whether generated HTML is trusted are not configured or specified here.

## Samples: executable examples

**Purpose.** The `samples` module demonstrates embedding NanoHTTPD, inspecting incoming requests, and replacing the temporary-file policy. 🟢 **CONFIRMED** (`HelloServer.java`, `DebugServer.java`, `TempFilesServer.java`).

- `HelloServer` runs on port 8080 through `ServerRunner` and returns a simple HTML greeting; when the `username` parameter is present it is interpolated into the response. 🟢 `HelloServer.java:48-EOF`.
- `DebugServer` returns URI, method, headers, single- and multi-valued parameters, and parsed body entries as HTML. It catches body-parse errors and prints their stack trace. 🟢 `DebugServer.java:45-EOF`.
- `TempFilesServer` subclasses `DebugServer`, installs a custom `ITempFileManager` backed by the system temporary directory, tracks created `DefaultTempFile` instances, and deletes them on `clear()`. 🟢 `TempFilesServer.java:50-EOF`.
- 🟡 **INFERRED:** the sample implementations are instructional fixtures rather than production-ready endpoints; the source does not establish production security or error-handling requirements.
- 🔴 **GAP:** expected HTML escaping for untrusted request values in the demo responses is unspecified.

## Relocation: Maven coordinate compatibility

**Purpose.** `relocation/` supplies Maven relocation POMs for five `com.nanohttpd` artifacts, pointing consumers to the `org.nanohttpd` group. The parent is version `2.2.0`; the source project is at `2.3.2-SNAPSHOT`. 🟢 **CONFIRMED** (`relocation/pom.xml` and child POMs).

- The relocation aggregator includes core, WebSocket, webserver, Markdown plugin, and samples. Each child POM sets Maven distribution relocation to groupId `org.nanohttpd`. 🟢 Direct POM evidence.
- Each relocated artifact has a `src/main/resources/relocated.txt` marker; there are no Java source files in this tree. 🟢 `find relocation -type f`.
- 🔴 **GAP:** the inspected metadata does not state how long the old coordinates are intended to remain available or the deprecation/support policy.
