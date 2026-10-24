# C4: Containers / Runtime Units

The repository builds library artifacts that are loaded into one host JVM. The boxes below are logical runtime units, not independently deployed processes.

```mermaid
flowchart TB
    Host[Embedding Java application]
    Core[Core HTTP library\nNanoHTTPD, HTTPSession, Response]
    WS[WebSocket library\nNanoWSD, WebSocketFrame]
    Web[Webserver library\nSimpleWebServer]
    Router[Nanolets library\nRouterNanoHTTPD]
    Upload[File upload adapter\nNanoFileUpload]
    MD[Markdown plugin\nPegdown]
    FS[(Local filesystem)]
    Client[Remote HTTP client]

    Host --> Core
    Host --> WS
    Host --> Web
    Host --> Router
    Host --> Upload
    Web --> MD
    Web --> FS
    MD --> FS
    Client --> Host
    WS --> Core
    Web --> Core
    Router --> Core
    Upload --> Core
```

Build tooling includes Maven and Gradle. No database, queue, cache, container image, or separately deployed backend was found. 🟢 **CONFIRMED**.
