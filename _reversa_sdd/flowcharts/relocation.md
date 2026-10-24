# Relocation Artifact Flow

```mermaid
flowchart LR
    A[Legacy com.nanohttpd artifact coordinate] --> B[Relocation POM metadata]
    B --> C[org.nanohttpd groupId]
    D[relocated.txt marker] --> E[Artifact's source module]
```

The relocation tree contains Maven POM metadata and marker resources; no Java source is present in these directories. Evidence: `relocation/pom.xml` and the five child POM/resource pairs.
