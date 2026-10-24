# Legacy Mapping: relocation

| Concern | Legacy paths | Evidence |
|---|---|---|
| Relocation parent | `relocation/pom.xml` | Maven coordinates `com.nanohttpd:nanohttpd-project:2.2.0`; aggregates five artifact markers |
| Core artifact marker | `relocation/nanohttpd/pom.xml`, `src/main/resources/relocated.txt` | Maven relocation targets group `org.nanohttpd` |
| WebSocket artifact marker | `relocation/nanohttpd-websocket/pom.xml`, `src/main/resources/relocated.txt` | Artifact relocation POM |
| Webserver artifact marker | `relocation/nanohttpd-webserver/pom.xml`, `src/main/resources/relocated.txt` | Artifact relocation POM |
| Markdown plugin artifact marker | `relocation/nanohttpd-webserver-markdown-plugin/pom.xml`, `src/main/resources/relocated.txt` | Artifact relocation POM |
| Samples artifact marker | `relocation/nanohttpd-samples/pom.xml`, `src/main/resources/relocated.txt` | Artifact relocation POM |

No Java implementation source exists under `relocation/`; this tree is publication/compatibility metadata.
