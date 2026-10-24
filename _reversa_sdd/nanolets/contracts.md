# Nanolets Routing Contract

- 🟢 Routes are patterns with optional colon-named path segments.
- 🟢 URI matching is against the entire normalized path.
- 🟢 The matched route receives a map of captured values.
- 🟢 GET, POST, PUT, DELETE have dedicated callbacks; remaining methods use other().
- 🟢 Responder class is instantiated when a route matches.
- 🔴 No DI scope, instance reuse, or constructor injection contract is defined.

