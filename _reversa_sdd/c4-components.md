# C4: Core Components

```mermaid
flowchart LR
    Socket[ServerRunnable / socket factory] --> ClientHandler[ClientHandler]
    ClientHandler --> Session[HTTPSession]
    Session --> Parser[Header, URI and body parsing]
    Session --> Handler[HTTP handler and interceptors]
    Handler --> App[Embedding application]
    Handler --> Response[Response]
    Response --> Writer[Fixed length / chunked / gzip writer]
    Session --> Temp[Temp-file manager]
    Session --> Cookie[CookieHandler]
    WS[NanoWSD interceptor] --> Handler
    WS --> Connection[WebSocket]
    Connection --> Frame[WebSocketFrame codec]
    Web[SimpleWebServer] --> Plugin[MIME plugins]
    Web --> LocalFiles[Local file roots]
    Router[RouterNanoHTTPD] --> Handler
```

Responsibilities are drawn from the module and class contracts. The AST graph identifies `NanoHTTPD`, `IHTTPSession`, `Response`, and `WebSocketFrame` as highly connected abstractions, but graph centrality is treated as a navigation signal because the graph also includes local tooling.
