# Project Inventory: nanohttpd

## Summary

- **Primary language:** Java (87 tracked `.java` files, excluding generated/build folders)
- **Build languages:** Gradle Groovy DSL (`build.gradle`, `settings.gradle`)
- **Build systems:** Maven and Gradle descriptors are both present. Maven is the parent/module structure in `pom.xml`; Gradle also configures the same main modules.
- **Project version:** `2.3.2-SNAPSHOT` (`pom.xml`, `build.gradle`)
- **Java target:** 1.7 (`pom.xml`, `build.gradle`)
- **Test framework:** JUnit 4.12; 36 tracked Java test classes by filename convention

## Repository structure

| Area | Purpose |
|---|---|
| `core/` | Embedded HTTP server, request/session handling, responses, sockets, temp files |
| `websocket/` | WebSocket protocol implementation and sample servers |
| `webserver/` | Static/local-directory web server and plugin support |
| `nanolets/` | URI routing and lightweight servlet-like handlers |
| `fileupload/` | Apache Commons FileUpload integration |
| `markdown-plugin/` | Pegdown-backed Markdown web server plugin |
| `samples/` | Example HTTP and temporary-file servers |
| `relocation/` | Alternate Maven artifacts and source layouts for relocated packages |
| `src/` | Root-level site and build support material; the main Java sources live in modules |

The seven modules listed in the root Maven aggregator are `core`, `samples`, `webserver`, `websocket`, `markdown-plugin`, `nanolets`, and `fileupload`. `relocation/` contains additional Maven POMs and repackaged source trees and is not listed in that root module block.

## Entry points and runtime shape

- `core/src/main/java/org/nanohttpd/protocols/http/NanoHTTPD.java` defines the base server and its `start()` lifecycle (`NanoHTTPD.start()` is located by the graph at line 579).
- `core/src/main/java/org/nanohttpd/util/ServerRunner.java` provides `run(Class)` and `executeInstance(NanoHTTPD)` helpers.
- `webserver/src/main/java/org/nanohttpd/webserver/SimpleWebServer.java` is the static/local-directory server entry class; Maven configures its executable main class as `fi.iki.elonen.SimpleWebServer`.
- Sample launchers include `samples/.../HelloServer.java`, `DebugServer.java`, `TempFilesServer.java`, and WebSocket sample classes.
- `nanolets/src/main/java/org/nanohttpd/router/RouterNanoHTTPD.java` contains the URI routing implementation.

## Configuration, delivery, and data

- Build/configuration files: root `pom.xml`, root and module `build.gradle` files, `settings.gradle`, and module POMs.
- CI: `.travis.yml` is present. No `.github/workflows/`, `Jenkinsfile`, or `.gitlab-ci.yml` was found in the inspected tree.
- Docker: no `Dockerfile` or `docker-compose.yml` found.
- Database: no database engine, schema, SQL migration, or ORM model artifacts found in the tracked source listing.
- Package managers: Maven and Gradle; no wrapper scripts were identified in the root listing.

## Graph coverage note

The AST graph contains 2,744 nodes and 6,292 edges. Graphify also indexed local `.agents/` and `.reversa/` tooling that is present in this working tree, so community counts and broad queries include non-product code. Treat graph communities as navigation hints and use the module folders and source manifests as the project boundary. Graphify reported partial parsing for eight Gradle files; their build descriptors were inspected directly.

## Organization suggestion

**Suggested specs organization: by module.** The root build defines clear top-level product modules, while routing is limited to the `nanolets` module rather than centralized across the project. The module structure is the strongest organizing signal.
