# Samples, Implementation Tasks

## Prerequisites
- [ ] 🟢 Implement core server and response APIs.

## Tasks
- [ ] T-01 Implement HelloServer example.
  - Legacy source: samples/src/main/java/org/nanohttpd/samples/http/HelloServer.java
  - Definition of done: 🟢 Example starts on port 8080 and returns greeting response.
  - Confidence: 🟢
- [ ] T-02 Implement DebugServer inspection response.
  - Legacy source: samples/src/main/java/org/nanohttpd/samples/http/DebugServer.java
  - Definition of done: 🟢 URI, method, headers, parameters, and body can be displayed.
  - Confidence: 🟢
- [ ] T-03 Implement tracked temp-file example.
  - Legacy source: samples/src/main/java/org/nanohttpd/samples/tempfiles/TempFilesServer.java
  - Definition of done: 🟢 Manager tracks created files and deletes them on clear.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Cover each launcher and basic response.
- [ ] TT-02 🟢 Cover temp-file manager cleanup.
- [ ] TT-03 🔴 Validate HTML escaping if samples are exposed beyond local demonstration.

## Suggested Order
1. 🟢 Basic server example.
2. 🟢 Request inspection.
3. 🟢 Temp-file manager example.

## Pending Gaps (🔴)
- 🔴 Confirm whether sample HTML should demonstrate safe escaping.

