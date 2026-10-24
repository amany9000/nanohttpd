# Samples

## Overview
🟢 Sample applications demonstrate server embedding, request inspection, and custom temp-file management.

## Responsibilities
- 🟢 Show a fixed HTML response and query parameter use.
- 🟢 Display session request data and parsed body.
- 🟢 Demonstrate custom temp-file cleanup.

## Business Rules
- 🟢 HelloServer and DebugServer use port 8080.
- 🟢 TempFilesServer tracks temporary files and deletes them in clear().
- 🔴 HTML escaping expectations for reflected request data are unspecified.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Provide runnable HTTP examples. | Should | Each example starts through ServerRunner. |
| FR-02 | 🟢 Demonstrate request and body inspection. | Could | Debug output includes URI, method, headers, parameters, and parsed files. |
| FR-03 | 🟢 Demonstrate replaceable temp manager. | Could | Tracked files are deleted when clear runs. |

## Acceptance Criteria
Given the HelloServer sample starts, when a request arrives, then it returns a greeting page. 🟢
Given the debug sample receives a request, when body parsing succeeds, then request fields are shown. 🟢
Given TempFilesServer finishes a request, when manager clear runs, then tracked temporary files are deleted. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| Example launchers | Should | 🟢 Useful to consumers, not core runtime. |
| Temp-file demonstration | Could | 🟢 Specialized integration example. |

## Code Traceability
| File | Coverage |
|---|---|
| samples/src/main/java/org/nanohttpd/samples/http/HelloServer.java | 🟢 |
| samples/src/main/java/org/nanohttpd/samples/http/DebugServer.java | 🟢 |
| samples/src/main/java/org/nanohttpd/samples/tempfiles/TempFilesServer.java | 🟢 |

