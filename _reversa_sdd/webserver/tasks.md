# Webserver Module, Implementation Tasks

## Prerequisites
- [ ] 🟢 Implement core request and response contracts.
- [ ] 🟢 Define configured document roots and MIME registry.
- [ ] 🔴 Decide listing/HTML sanitization policy.

## Tasks
- [ ] T-01 Implement root selection and URI traversal handling.
  - Legacy source: webserver/src/main/java/org/nanohttpd/webserver/SimpleWebServer.java:378-408
  - Definition of done: 🟢 Requests resolve only under configured roots and traversal cases are rejected.
  - Confidence: 🟢
- [ ] T-02 Implement redirects, index resolution, and directory listing.
  - Legacy source: SimpleWebServer.java:261-269,409-438
  - Definition of done: 🟢 Slash, index, readable, and unreadable directory cases match acceptance criteria.
  - Confidence: 🟢
- [ ] T-03 Implement file streaming, validators, and range behavior.
  - Legacy source: SimpleWebServer.java:473-579
  - Definition of done: 🟢 Full, partial, stale, and unsatisfiable requests produce expected responses.
  - Confidence: 🟢
- [ ] T-04 Implement plugin and CORS hooks.
  - Legacy source: SimpleWebServer.java:363-377,440-472,580-590
  - Definition of done: 🟢 Plugin response/rewrite and configured CORS headers are covered.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Cover path rejection, missing paths, directory and index behavior.
- [ ] TT-02 🟢 Cover ETag, conditional requests, and byte ranges.
- [ ] TT-03 🔴 Add security coverage for generated listing output.

## Suggested Order
1. 🟢 Root and path handling.
2. 🟢 Directory and file response behavior.
3. 🟢 Plugins and CORS.

## Pending Gaps (🔴)
- 🔴 Confirm canonical path and HTML escaping expectations.

