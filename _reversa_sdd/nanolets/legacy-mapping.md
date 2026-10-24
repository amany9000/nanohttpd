# Legacy Mapping: nanolets

| Concern | Legacy files | Evidence |
|---|---|---|
| Route registration, URI matching, route priorities | `nanolets/src/main/java/org/nanohttpd/router/RouterNanoHTTPD.java` | `UriResource` L320-463; prioritizers L471-565 |
| Method-specific request responder API | `RouterNanoHTTPD.java` | `UriResponder` L71-87; dispatch in `UriResource.process()` L360-410 |
| Router orchestration and defaults | `RouterNanoHTTPD.java` | `UriRouter` L566-623; public server API L624-EOF |
| Static pages and basic handler types | `RouterNanoHTTPD.java` | `DefaultStreamHandler`, `DefaultHandler`, `StaticPageHandler` L88-250 |
| Not-found / not-implemented handlers | `RouterNanoHTTPD.java` | Handler types L251-305 |
| Tests and route examples | `nanolets/src/test/java/org/nanohttpd/junit/router/` | `TestNanolets.java`, `AppNanolets.java` |
