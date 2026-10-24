# Webserver Module

## Overview
🟢 Serves local files and directories over HTTP and supports MIME-specific plugins.

## Responsibilities
- 🟢 Resolve requests against configured roots.
- 🟢 Reject traversal strings and select directory index/listing behavior.
- 🟢 Stream files with basic range and ETag handling.
- 🟢 Apply optional CORS headers and dispatch plugins.

## Business Rules
- 🟢 URI containing ../ is forbidden.
- 🟢 Directory URI gains trailing slash; index file is served if present, otherwise readable directories are listed.
- 🟢 Byte ranges and ETags can produce 206, 304, or 416.
- 🔴 HTML escaping expectations for directory listings are unspecified.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Resolve a URI under configured root directories. | Must | Existing file is served; unmatched path is 404. |
| FR-02 | 🟢 Serve directories with redirect/index/listing behavior. | Must | Directory behavior follows slash and index rules. |
| FR-03 | 🟢 Support conditional and range responses. | Should | Matching validators/range yield 304/206/416 as implemented. |
| FR-04 | 🟢 Delegate eligible MIME types to plugins and add CORS headers when configured. | Should | Plugin response/rewrite and CORS response are applied. |

## Acceptance Criteria
Given a URI containing ../, when requested, then a 403 response is returned. 🟢
Given a directory without trailing slash, when requested, then it redirects to the slash form. 🟢
Given a readable directory with no index, when requested, then an HTML listing is returned. 🟢
Given a matching file plugin, when the URI is served, then plugin output or internal rewrite is used. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| Root resolution and file response | Must | 🟢 Main purpose. |
| Directory index and listing | Must | 🟢 Primary static server behavior. |
| Plugin/CORS support | Should | 🟢 Optional extension behavior. |

## Code Traceability
| File | Coverage |
|---|---|
| webserver/src/main/java/org/nanohttpd/webserver/SimpleWebServer.java | 🟢 |
| webserver/src/main/java/org/nanohttpd/webserver/WebServerPlugin.java | 🟢 |
| webserver/src/main/java/org/nanohttpd/webserver/InternalRewrite.java | 🟢 |

