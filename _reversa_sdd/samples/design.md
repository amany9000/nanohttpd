# Samples, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| HelloServer.main | (String[]) | void | 🟢 Starts HelloServer through ServerRunner. |
| HelloServer.serve | (IHTTPSession) | Response | 🟢 Returns greeting HTML. |
| DebugServer.serve | (IHTTPSession) | Response | 🟢 Renders request values and parsed body. |
| TempFilesServer.main | (String[]) | void | 🟢 Installs custom temp manager and starts server. |

## Main Flow
1. 🟢 Main method creates or asks ServerRunner to create server.
2. 🟢 NanoHTTPD starts listener on configured port.
3. 🟢 Sample serve method reads session values and builds response.
4. 🟢 TempFilesServer uses custom manager rooted at java.io.tmpdir.

## Alternative Flows
- 🟢 DebugServer catches body parse errors and prints stack trace.
- 🟢 Temp file deletion errors are ignored by example manager.

## Dependencies
- 🟢 Core HTTP APIs and ServerRunner.
- 🟢 DefaultTempFile implementation for temp-file sample.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Use simple executable subclasses for examples. | samples source files | 🟢 |
| 🟢 Demonstrate temp-file lifecycle by tracking ITempFile objects. | TempFilesServer.java:52-86 | 🟢 |

## Internal State
- 🟢 Example manager stores system temp directory and tracked temp files.

## Observability
- 🟢 Samples print request details and temp file events to console.

## Risks and Gaps
- 🔴 Reflected query/header values are written into HTML without an established escaping policy.

