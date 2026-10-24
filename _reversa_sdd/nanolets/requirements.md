# Nanolets Router

## Overview
🟢 Nanolets maps normalized URI patterns to responder classes and dispatches HTTP methods to handler callbacks.

## Responsibilities
- 🟢 Register/remove prioritized routes.
- 🟢 Capture named URI path parameters.
- 🟢 Instantiate responders and dispatch GET/POST/PUT/DELETE/other methods.
- 🟢 Provide static, stream, and fallback handler types.

## Business Rules
- 🟢 Route regex must fully match normalized path.
- 🟢 Colon-prefixed path segments are named parameters.
- 🟢 First matching route in prioritizer order handles the request.
- 🟢 Handler exceptions become 500 text responses.
- 🔴 Dependency injection and handler lifecycle are not defined.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Match normalized URI against registered routes. | Must | Matching route receives extracted parameters. |
| FR-02 | 🟢 Dispatch by method to responder callback. | Must | GET/POST/PUT/DELETE use dedicated methods; others use other(). |
| FR-03 | 🟢 Support configurable route priority strategy. | Should | Default and alternate prioritizers determine iteration order. |
| FR-04 | 🟢 Provide default not-found and not-implemented handlers. | Should | No match or unsupported method uses configured handler. |

## Acceptance Criteria
Given a route /users/:id and request /users/42, when matched, then parameter id equals 42. 🟢
Given no route matches, when a request arrives, then configured not-found handler runs. 🟢
Given a matching responder receives POST, when dispatched, then its post callback runs. 🟢
Given responder construction or execution throws, when route is processed, then response status is 500. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| URI match and handler dispatch | Must | 🟢 Main purpose. |
| Method callbacks and route parameters | Must | 🟢 Required routing contract. |
| Alternate prioritizers | Could | 🟢 Optional selection strategy. |

## Code Traceability
| File | Coverage |
|---|---|
| nanolets/src/main/java/org/nanohttpd/router/RouterNanoHTTPD.java | 🟢 |
| nanolets/src/test/java/org/nanohttpd/junit/router/TestNanolets.java | 🟢 |

