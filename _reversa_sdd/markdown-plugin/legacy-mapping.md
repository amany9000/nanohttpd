# Legacy Mapping: markdown-plugin

| Concern | Legacy files | Evidence |
|---|---|---|
| Markdown file selection, reading and rendering | `markdown-plugin/src/main/java/org/nanohttpd/markdown/MarkdownWebServerPlugin.java` | `canServeUri()` L69-74, `readSource()` L79-111, `serveFile()` L112-EOF |
| Plugin MIME and index registration | `markdown-plugin/src/main/java/org/nanohttpd/markdown/MarkdownWebServerPluginInfo.java` | `index.md`, `text/markdown`, plugin factory |
| Rendering library | `markdown-plugin/pom.xml` | Pegdown 1.4.1 |
