# Webserver Module, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| SimpleWebServer.serve | (IHTTPSession) | Response | 🟢 Request entry. |
| SimpleWebServer.serveFile | (String, Map, File, String) | Response | 🟢 File/range response. |
| WebServerPlugin.canServeUri | (String, File) | boolean | 🟢 Plugin selection. |
| WebServerPlugin.serveFile | (String, Map, IHTTPSession, File, String) | Response | 🟢 Plugin response. |

## Main Flow
1. 🟢 Validate each configured root directory.
2. 🟢 Normalize URI, strip query, reject ../, and find a root/file/plugin match.
3. 🟢 Redirect directory requests missing trailing slash; serve index or listing.
4. 🟢 Dispatch MIME plugin or stream file with ETag/range handling.
5. 🟢 Add configured CORS headers to response.

## Alternative Flows
- 🟢 Missing path returns 404; unreadable directory returns 403.
- 🟢 File I/O failure returns forbidden response.
- 🟢 OPTIONS with CORS configured returns empty 200.
- 🟢 InternalRewrite re-enters URI resolution.

## Dependencies
- 🟢 core session/response APIs and filesystem.
- 🟢 markdown-plugin implements the webserver plugin contract.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Plugin selection uses MIME type plus canServeUri. | SimpleWebServer.java:225-239,440-472 | 🟢 |
| 🟢 File validators are derived from path, modification time, and length. | SimpleWebServer.java:473-572 | 🟢 |

## Internal State
- 🟢 Root directories, CORS value, and static MIME-to-plugin registry are retained by server configuration.

## Observability
- 🟢 Optional request logging prints method, URI, headers, and parameters.
- 🔴 Metrics/tracing were not found.

## Risks and Gaps
- 🔴 Directory listing HTML escaping and root path canonicalization policy need security review.
- 🔴 CORS origin and allowed methods are deployment configuration choices.

