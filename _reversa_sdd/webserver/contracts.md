# Webserver Contract

## Request behavior
- 🟢 Uses configured root directories in order.
- 🟢 Refuses URI strings containing ../.
- 🟢 Directory requests redirect to trailing slash and then use index or listing behavior.
- 🟢 Plugin dispatch is MIME-based and may return InternalRewrite.
- 🟢 Range and conditional headers affect status and Content-Range/ETag response headers.

## Configuration contract
- 🟢 Caller supplies root directories, CORS configuration, and plugin registrations.
- 🔴 No default production root or CORS policy is established by the library.
- 🔴 Canonicalization and generated HTML escaping policy need maintainer confirmation.

