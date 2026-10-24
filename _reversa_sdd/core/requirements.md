# Core HTTP Server

## Overview
🟢 NanoHTTPD core embeds an HTTP listener, parses requests into sessions, delegates behavior to handlers, and serializes responses. 🟢 The host application supplies business logic.

## Responsibilities
- 🟢 Bind sockets and dispatch clients through configurable runners.
- 🟢 Parse request lines, methods, headers, query parameters, and bodies.
- 🟢 Expose session, handler, and interceptor contracts.
- 🟢 Serialize status, headers, cookies, and response bodies.
- 🟢 Manage keep-alive and per-request temporary-file cleanup.

## Business Rules
- 🟢 Unknown methods and malformed requests produce 400.
- 🟢 HTTP/1.1 connections stay alive unless Connection contains close.
- 🟢 Bodies below 1,024 bytes use memory; larger bodies use temporary storage.
- 🟢 Multipart POST requires a boundary; raw POST uses postData; PUT uses content.
- 🔴 Request and upload size policy is unspecified.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Start and stop listener with configured port and timeout. | Must | Bind or report failure; stop closes listener resources. |
| FR-02 | 🟢 Parse request and invoke configured handler. | Must | Handler receives method, URI, headers, and parameters. |
| FR-03 | 🟢 Return protocol errors for malformed or unknown methods. | Must | Invalid syntax/method receives 400. |
| FR-04 | 🟢 Serialize response metadata and body according to transfer settings. | Must | Fixed-length, chunked, gzip, keep-alive, and HEAD paths follow settings. |
| FR-05 | 🟢 Parse supported POST/PUT bodies and clear temporary resources. | Should | Body values and cleanup match documented behavior. |

## Non-Functional Requirements
| Type | Requirement | Evidence | Confidence |
|---|---|---|---|
| Performance | 🟢 Socket read timeout is configurable at start. | NanoHTTPD.java:579-625 | 🟢 |
| Security | 🔴 Unified request/body limits are unspecified. | HTTPSession.java:602-669 | 🔴 |

## Acceptance Criteria
Given a valid request and handler, when the listener parses it, then the handler receives the session and its response is serialized. 🟢
Given a malformed request or unknown method, when parsed, then a 400 response is written and the connection closes. 🟢
Given HTTP/1.1 without Connection: close, when a response is sent, then keep-alive remains unless response closes it. 🟢
Given a body crossing the 1,024-byte threshold, when parsed, then larger data uses temporary storage and cleanup runs. 🟢

## Priority (MoSCoW)
| Requirement | Priority | Justification |
|---|---|---|
| Socket lifecycle and dispatch | Must | 🟢 Critical path for every request. |
| Parsing and response serialization | Must | 🟢 Required protocol behavior. |
| Body parsing and temp storage | Should | 🟢 Important, with replaceable strategy. |
| Reverse DNS hostname lookup | Won't | 🟢 Removed by commit cd37235 to avoid request delay. |

## Code Traceability
| File | Function / class | Coverage |
|---|---|---|
| core/src/main/java/org/nanohttpd/protocols/http/NanoHTTPD.java | start, stop, handlers | 🟢 |
| core/src/main/java/org/nanohttpd/protocols/http/HTTPSession.java | execute, parseBody | 🟢 |
| core/src/main/java/org/nanohttpd/protocols/http/response/Response.java | send | 🟢 |
| core/src/main/java/org/nanohttpd/protocols/http/IHTTPSession.java | session contract | 🟢 |

