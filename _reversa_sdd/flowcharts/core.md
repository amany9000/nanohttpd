# Core HTTP Server Flow

```mermaid
flowchart TD
    A[Application constructs NanoHTTPD subclass] --> B[start]
    B --> C[Create server socket and listener thread]
    C --> D[ServerRunnable binds and accepts sockets]
    D --> E[ClientHandler creates request session]
    E --> F[HTTPSession.execute reads and splits headers]
    F --> G[Decode method URI query and headers]
    G --> H[NanoHTTPD.handle invokes handler and interceptors]
    H --> I[Configure cookies keep-alive and gzip]
    I --> J[Response.send writes headers and body]
    J --> K{Keep-alive?}
    K -- yes --> F
    K -- no --> L[Close connection and clear request temp files]
    M[stop] --> N[Close server socket and async runner]
```

The request loop is owned by the connection handler; `HTTPSession.execute()` handles one request and the runner can continue for persistent connections. Socket and timeout exceptions propagate to close the connection. Other I/O and protocol parse errors are converted to an error response and the stream is closed. Evidence: `NanoHTTPD.java:579-637`, `HTTPSession.java:338-465`.
