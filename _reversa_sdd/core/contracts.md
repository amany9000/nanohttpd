# Core HTTP Contract

## Request contract
- 🟢 One IHTTPSession represents a parsed request presented to a handler.
- 🟢 Header names are normalized to lowercase.
- 🟢 Parameters may have multiple values; deprecated getParms returns only the first.
- 🟢 Unknown methods are rejected as 400 rather than passed as arbitrary strings.
- 🔴 Request size limits are unspecified.

## Response contract
- 🟢 A response includes status and may include MIME type, headers, cookies, and streamed body.
- 🟢 Writer supports fixed-length/chunked transfer, optional gzip, and HEAD body suppression.
- 🟢 A null handler result becomes an internal server error.
- 🟢 Persistence follows HTTP/1.1 and Connection header rules unless explicitly closed.

## Public extension points
| Contract | Evidence |
|---|---|
| IHandler<IHTTPSession,Response> | core/src/main/java/org/nanohttpd/util/IHandler.java 🟢 |
| HTTP interceptors | NanoHTTPD.addHTTPInterceptor() 🟢 |
| IAsyncRunner and socket factory | core/src/main/java/org/nanohttpd/protocols/http/threading/ and sockets/ 🟢 |
| ITempFileManager | core/src/main/java/org/nanohttpd/protocols/http/tempfiles/ITempFileManager.java 🟢 |

## Errors
- 🟢 Parse errors map to ResponseException status.
- 🟢 Socket/timeouts end the connection.
- 🟢 SSL and generic I/O failures attempt 500 and close output.
- 🔴 Behavior after a partial socket write is not guaranteed.

