# C4: System Context

```mermaid
flowchart LR
    Developer[Embedding application developer]
    Client[HTTP / WebSocket client]
    System[NanoHTTPD library embedded in host JVM]
    Host[Embedding Java application]
    FS[(Local filesystem)]
    Commons[Apache Commons FileUpload]
    Pegdown[Pegdown Markdown processor]

    Developer -->|configures handlers and modules| Host
    Client -->|HTTP/1.x or WebSocket| Host
    Host -->|embeds| System
    System -->|optional file serving| FS
    System -->|multipart adapter| Commons
    System -->|optional Markdown plugin| Pegdown
```

**System purpose:** provide an embeddable HTTP server and optional protocol/server extensions. The Java host supplies routes, response logic, and application authorization. External libraries are in-process dependencies, not remote services. 🟢 **CONFIRMED** for code/build relationships; host responsibilities are 🟡 **INFERRED** from the handler API.
