# Data Dictionary

No relational database schema or ORM entities were found. The structures below are in-memory protocol and request data.

## HTTP session

| Field / value | Type | Required | Meaning |
|---|---|---:|---|
| `method` | `Method` enum | Yes after parse | Parsed HTTP method; unsupported values produce a 400 response |
| `uri` | `String` | Yes after parse | URL-decoded path, without the query string |
| `headers` | `Map<String,String>` | Yes | Header names normalized to lowercase; may include remote address entries |
| `parms` | `Map<String,List<String>>` | Yes after parse | Query and form parameters; supports multiple values for one name |
| `queryParameterString` | `String` | Optional | Raw query string exposed by the session API |
| `cookies` | `CookieHandler` | Yes after parse | Parsed request cookies and queued response cookies |
| `remoteIp` | `String` | Optional | Peer address when supplied by the session constructor |
| `protocolVersion` | `String` | Defaults to HTTP/1.1 | Request protocol token; absent version is treated as HTTP/1.1 |
| body file map | `Map<String,String>` | Caller supplied | Parsed upload paths or raw body under `postData`; PUT uses `content` |

Evidence: `IHTTPSession.java:48-92`, `HTTPSession.java:74-132,404-425,602-692`.

## Response

| Field | Type | Required | Default / notes |
|---|---|---:|---|
| `status` | `IStatus` / `Status` | Yes before send | `send()` throws an error if unset |
| `mimeType` | `String` | No | Adds Content-Type when present |
| `data` | `InputStream` | No | Body stream; response factories set this according to response kind |
| `header` | `Map<String,String>` | Yes | User and protocol headers |
| `cookieHeaders` | `List<String>` | Yes | Serialized Set-Cookie header values |
| `requestMethod` | `Method` | Optional | HEAD suppresses body output |
| `keepAlive` | `boolean` | Yes | Controls Connection header; set from request protocol/headers |
| `chunkedTransfer` | `boolean` | Yes | Selects chunked body framing |
| `useGzip` | `GzipUsage` | Yes | `DEFAULT`, `ALWAYS`, or `NEVER`; gzip also depends on request acceptance |

Evidence: `Response.java:66-146,228-275,390-442`.

## Enumerations

- `Method`: GET, PUT, POST, DELETE, HEAD, OPTIONS, TRACE, CONNECT, PATCH, and WebDAV/subscription methods. 🟢 `Method.java`.
- `Status`: supported informational, success, redirect, client-error, and server-error status values, each with numeric code and description. 🟢 `Status.java`.

## WebSocket frame and connection

| Field / value | Type | Required | Meaning |
|---|---|---:|---|
| `opCode` | `OpCode` | Yes | Text, binary, continuation, close, ping, or pong frame kind |
| `fin` | `boolean` | Yes | Indicates final frame in a message |
| `maskingKey` | `byte[4]` or null | No | XOR mask applied to payload when present |
| `payload` | `byte[]` | Yes | Encoded frame body |
| `state` | `State` | Yes | Connection state, including UNCONNECTED, CONNECTING, OPEN, CLOSING, CLOSED |
| `continuousOpCode` | `OpCode` or null | Optional | Original opcode while fragmented message is being assembled |
| `continuousFrames` | `List<WebSocketFrame>` | Yes | Accumulated fragments |
| close code / reason | `CloseCode`, `String` | Optional | Close frame status and decoded reason |

Evidence: `WebSocket.java:48-105`, `WebSocketFrame.java:45-48,105-157`, `CloseFrame.java:38-75`.

## Web server request and plugin values

| Value | Type | Meaning |
|---|---|---|
| root directories | `List<File>` | Search roots, evaluated in configured order |
| MIME plugin registry | `Map<String,WebServerPlugin>` | Maps MIME type to a plugin |
| range request | `Range` header string | Supports a `bytes=start-end` form in the implementation |
| ETag | `String` | Hex hash derived from file path, modification time, and length |
| plugin rewrite | `InternalRewrite` | Response subtype carrying headers and a URI to resolve again |
| CORS setting | `String` | Configured allowed origin; enables OPTIONS response and CORS headers |

Evidence: `SimpleWebServer.java:225-239,363-472,473-590`, `InternalRewrite.java:46-EOF`.

## Nanolets route

| Field | Type | Required | Meaning |
|---|---|---:|---|
| `uri` | `String` | Yes | Normalized route expression; `:name` segments represent captured parameters |
| `uriPattern` | `Pattern` | Yes | Compiled regular expression used for full URI matching |
| `uriParams` | `List<String>` | Yes | Capture names in route order |
| `priority` | `int` | Yes | Ordering value used by the prioritizer |
| `handler` | `Class<?>` | Yes for executable route | Handler type instantiated when route matches |
| `initParameter` | `Object[]` | Optional | Values made available to handler code through `initParameter()` |

Evidence: `RouterNanoHTTPD.java:320-360,423-469`.

## Upload context

| Field / method | Type | Meaning |
|---|---|---|
| session | `IHTTPSession` | Source of request method, headers, and input stream |
| content length | `long` | Parsed from `content-length`; `-1` when absent or invalid |
| character encoding | `String` | Always `UTF-8` in this adapter |
| content type | `String` | Read from the lowercase `content-type` request header |
| file item factory | `FileItemFactory` | Caller-supplied policy for Commons FileUpload item creation/storage |

Evidence: `NanoFileUpload.java:56-EOF`.

## Markdown plugin metadata

| Value | Type | Meaning |
|---|---|---|
| index file | `String[]` | `index.md` |
| handled MIME type | `String[]` | `text/markdown` |
| rendered content type | `String` | `text/html` |
| source encoding | platform default | `FileReader` input behavior |
| output encoding | `UTF-8` | Encoded HTML response body |

Evidence: `MarkdownWebServerPluginInfo.java`, `MarkdownWebServerPlugin.java:79-EOF`.

## Sample temp-file manager

| Field | Type | Meaning |
|---|---|---|
| `tmpdir` | `File` | System property `java.io.tmpdir` |
| `tempFiles` | `List<ITempFile>` | Files created by this manager and deleted during `clear()` |

Evidence: `samples/src/main/java/org/nanohttpd/samples/tempfiles/TempFilesServer.java:52-86`.
