# Legacy Mapping: webserver

| Concern | Legacy files | Evidence |
|---|---|---|
| CLI/static server setup, root directories and plugin registration | `webserver/src/main/java/org/nanohttpd/webserver/SimpleWebServer.java` | `main()` L103-203; constructor L204-224 |
| Request selection, directory handling, plugin dispatch | `SimpleWebServer.java` | `respond()` L363-377; `defaultRespond()` L378-439 |
| File streaming, ranges, ETags and CORS | `SimpleWebServer.java` | `serveFile()` L473-589 |
| Plugin contract and discovery metadata | `WebServerPlugin.java`, `WebServerPluginInfo.java` | Interface declarations |
| Internal plugin rewrite | `InternalRewrite.java` | Response subtype with replacement URI and headers |
| Tests | `webserver/src/test/java/org/nanohttpd/junit/webserver/` | HTTP serving and CORS test classes |
