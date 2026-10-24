# Nanolets Router, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| RouterNanoHTTPD.addRoute | (String, Class, Object...) | void | 🟢 Adds handler mapping. |
| UriResource.match | (String) | Map<String,String> or null | 🟢 Full-pattern match and parameter extraction. |
| UriResource.process | (Map, IHTTPSession) | Response | 🟢 Creates responder and dispatches method. |
| UriResponder | get/put/post/delete/other | Response | 🟢 Host callback contract. |

## Main Flow
1. 🟢 Normalize URI by removing leading/trailing slash.
2. 🟢 Iterate configured prioritized route collection.
3. 🟢 Match full regex; map captured groups to parameter names.
4. 🟢 Reflectively instantiate route handler and dispatch method.
5. 🟢 Use not-found handler when no mapping matches.

## Alternative Flows
- 🟢 Unknown methods go to other().
- 🟢 Non-responder handler returns a text representation of its object.
- 🟢 Handler errors produce 500 response.

## Dependencies
- 🟢 Core session and response APIs.
- 🟢 Java regex and reflection.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Routes are class-based and instantiated per match. | RouterNanoHTTPD.java:360-410 | 🟢 |
| 🟢 Default prioritizer is a priority queue; insertion-order alternative exists. | RouterNanoHTTPD.java:471-565 | 🟢 |

## Internal State
- 🟢 UriResource stores route, compiled pattern, priority, handler class, constructor arguments, and capture names.
- 🟢 UriRouter stores route prioritizer and not-found resource.

## Observability
- 🟢 Handler construction/dispatch exceptions are logged.
- 🔴 Metrics/tracing were not found.

## Risks and Gaps
- 🔴 Handler construction requires an accessible no-argument constructor.
- 🟡 Priority combines registration order and parameter count; intended ordering needs compatibility confirmation.

