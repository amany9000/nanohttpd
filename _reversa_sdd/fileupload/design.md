# File Upload Adapter, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| NanoHttpdContext.contentLength | () | long | 🟢 Parses content-length or returns -1. |
| NanoHttpdContext.getInputStream | () | InputStream | 🟢 Returns session stream. |
| NanoFileUpload.parseRequest | (IHTTPSession) | List<FileItem> | 🟢 Delegates to parent API. |
| NanoFileUpload.getItemIterator | (IHTTPSession) | FileItemIterator | 🟢 Streaming parser API. |

## Main Flow
1. 🟢 Construct adapter with caller-supplied FileItemFactory.
2. 🟢 Wrap session in NanoHttpdContext.
3. 🟢 Commons reads content type, length, UTF-8 encoding, and input stream.
4. 🟢 Adapter delegates list, map, or iterator parsing to superclass.

## Alternative Flows
- 🟢 Invalid content length becomes -1.
- 🟢 Multipart check returns false unless method is POST and Commons recognizes multipart content.
- 🔴 Parse errors are surfaced as FileUploadException/IOException; adapter adds no policy.

## Dependencies
- 🟢 Core IHTTPSession and Method.
- 🟢 commons-fileupload 1.3.1.
- 🟢 FileItemFactory controls item construction/storage.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Reuse Commons FileUpload parser by implementing UploadContext. | NanoFileUpload.java:56-EOF | 🟢 |
| 🟢 Expose both materialized and streaming parse APIs. | NanoFileUpload.java:106-EOF | 🟢 |

## Internal State
- 🟢 NanoHttpdContext holds the IHTTPSession for the duration of delegated parsing.

## Observability
- 🔴 No logging or metrics are emitted by this adapter.

## Risks and Gaps
- 🔴 No upload maximum, temp directory, memory threshold, or cleanup policy is set here.
- 🟡 Calling core parseBody first may consume the same stream; code does not rewind or coordinate.

