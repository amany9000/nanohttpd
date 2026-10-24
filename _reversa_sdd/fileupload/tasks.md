# File Upload Adapter, Implementation Tasks

## Prerequisites
- [ ] 🟢 Provide core IHTTPSession and Apache Commons FileUpload.
- [ ] 🔴 Select FileItemFactory storage and limit configuration.

## Tasks
- [ ] T-01 Adapt session metadata and stream to UploadContext.
  - Legacy source: fileupload/src/main/java/org/nanohttpd/fileupload/NanoFileUpload.java:56-100
  - Definition of done: 🟢 Headers, UTF-8, content length fallback, and stream are exposed.
  - Confidence: 🟢
- [ ] T-02 Implement multipart POST detection.
  - Legacy source: NanoFileUpload.java:101-105
  - Definition of done: 🟢 Method and multipart conditions match the adapter contract.
  - Confidence: 🟢
- [ ] T-03 Expose list, parameter map, and streaming iterator parse methods.
  - Legacy source: NanoFileUpload.java:106-EOF
  - Definition of done: 🟢 Each entry point delegates and surfaces parse errors.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Cover multipart and non-multipart methods.
- [ ] TT-02 🟢 Cover valid, absent, and invalid content-length headers.
- [ ] TT-03 🔴 Validate configured size limits and temp-file cleanup.

## Suggested Order
1. 🟢 Implement context adapter.
2. 🟢 Add parse APIs.
3. 🔴 Apply host-selected factory and resource limits.

## Pending Gaps (🔴)
- 🔴 Confirm upload limit, storage threshold, and cleanup expectations.

