# File Upload Adapter

## Overview
🟢 Adapts NanoHTTPD sessions to Apache Commons FileUpload for multipart request parsing.

## Responsibilities
- 🟢 Expose session headers, content length, encoding, and body stream as UploadContext.
- 🟢 Detect multipart POST requests.
- 🟢 Delegate parsing and item iteration to Commons FileUpload.
- 🟢 Use a caller-supplied FileItemFactory.

## Business Rules
- 🟢 Multipart detection applies only to POST.
- 🟢 Missing/invalid content-length is represented as -1.
- 🟢 Adapter encoding is UTF-8.
- 🔴 Upload limits and disk/memory policy belong to external configuration.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Adapt IHTTPSession as UploadContext. | Must | Context returns headers and session input stream. |
| FR-02 | 🟢 Detect multipart POST. | Must | Commons multipart type on POST returns true; other methods false. |
| FR-03 | 🟢 Expose parseRequest, parseParameterMap, and iterator APIs. | Must | Calls delegate using adapted context and configured factory. |

## Acceptance Criteria
Given a POST multipart request, when detected, then isMultipartContent returns true. 🟢
Given missing or invalid content length, when context reads length, then it returns -1. 🟢
Given a session and FileItemFactory, when parsing is requested, then Commons FileUpload receives the adapted stream/context. 🟢
Given a non-POST method, when multipart detection runs, then false is returned. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| Session adaptation and multipart parsing | Must | 🟢 Main module purpose. |
| Streaming iterator | Should | 🟢 Alternative processing API for large uploads. |

## Code Traceability
| File | Coverage |
|---|---|
| fileupload/src/main/java/org/nanohttpd/fileupload/NanoFileUpload.java | 🟢 |
| fileupload/src/test/java/org/nanohttpd/junit/fileupload/TestNanoFileUpLoad.java | 🟢 |

