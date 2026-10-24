# Permissions and Authorization

## Scope finding

The inspected repository provides an HTTP server library and request handlers. It does not define user accounts, roles, ACLs, authorization policies, or access-control middleware. The `UNAUTHORIZED` response status is a protocol value; its presence does not establish an authorization system. 🟢 **CONFIRMED** from the source inventory and graph query.

## Permission matrix

| Actor / layer | HTTP requests | Local files | WebSocket actions | Authorization policy |
|---|---|---|---|---|
| NanoHTTPD core | Parses requests and invokes configured handler | None | None | No policy in core |
| Webserver module | Serves configured root directories | Applies URI/path checks and filesystem read checks | None | Filesystem/path checks only; no user roles |
| Nanolets responder | Receives matched method and route parameters | Static handler can read configured files | None | Application-defined in responder code |
| WebSocket handler | None after upgrade | None | Receives messages and close/ping events | Application-defined in callbacks |
| Embedding application | Supplies handlers and configuration | Chooses roots and deployment permissions | Supplies WebSocket handlers | Responsible for authentication/authorization |

No role-to-permission matrix can be derived from this codebase. 🔴 **GAP:** application-level identity and access-control requirements must be supplied by each embedding application.
