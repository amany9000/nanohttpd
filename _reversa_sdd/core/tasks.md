# Core HTTP Server, Implementation Tasks

## Prerequisites
- [ ] 🟢 Provide compatible Java socket, stream, and file APIs.
- [ ] 🟢 Define handler/interceptor and response contracts.
- [ ] 🔴 Decide request and upload limits before implementation.

## Tasks
- [ ] T-01 Implement listener lifecycle.
  - Legacy source: core/src/main/java/org/nanohttpd/protocols/http/NanoHTTPD.java:579-637
  - Definition of done: 🟢 Bind reports failure; stop closes listener and runner resources.
  - Confidence: 🟢
- [ ] T-02 Parse request line, headers, URI, method, and query parameters.
  - Legacy source: core/src/main/java/org/nanohttpd/protocols/http/HTTPSession.java:133-190,338-404
  - Definition of done: 🟢 Fields match session contract; malformed requests produce protocol errors.
  - Confidence: 🟢
- [ ] T-03 Implement body parsing and temporary storage.
  - Legacy source: core/src/main/java/org/nanohttpd/protocols/http/HTTPSession.java:602-692
  - Definition of done: 🟢 Multipart, URL-encoded, raw POST, and PUT paths match keys and cleanup.
  - Confidence: 🟢
- [ ] T-04 Serialize response metadata and body encodings.
  - Legacy source: core/src/main/java/org/nanohttpd/protocols/http/response/Response.java:228-366
  - Definition of done: 🟢 Fixed-length, chunked, gzip, keep-alive, and HEAD have acceptance coverage.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Cover valid dispatch and response serialization.
- [ ] TT-02 🟢 Cover malformed request, unsupported method, close, and timeout.
- [ ] TT-03 🟢 Cover body threshold, multipart errors, and temp cleanup.

## Suggested Order
1. 🟢 Implement session and response contracts before optional modules.
2. 🟢 Implement socket lifecycle and dispatch around those contracts.
3. 🔴 Resolve resource limits before claiming upload hardening.

## Pending Gaps (🔴)
- 🔴 Confirm request/header/body limits and malformed URI handling.

