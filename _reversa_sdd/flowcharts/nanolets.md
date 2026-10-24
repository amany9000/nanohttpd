# Nanolets Router Flow

```mermaid
flowchart TD
    A[HTTP handler receives session] --> B[Normalize URI]
    B --> C[Iterate prioritized UriResource mappings]
    C --> D{Regex match?}
    D -- no --> C
    D -- yes --> E[Capture named path parameters]
    E --> F[Instantiate handler class]
    F --> G{UriResponder?}
    G -- no --> H[Return object string]
    G -- yes --> I{HTTP method}
    I -- GET/POST/PUT/DELETE --> J[Call matching method]
    I -- other --> K[Call other(method,...)]
    C -- no match --> L[Configured not-found handler]
```

Evidence: `RouterNanoHTTPD.java:320-410,566-599,669-EOF`.
