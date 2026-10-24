# Markdown Plugin, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| canServeUri | (String uri, File rootDir) | boolean | 🟢 Checks file existence. |
| serveFile | (String, Map, IHTTPSession, File, String) | Response or null | 🟢 Reads, converts, and returns HTML. |
| getIndexFilesForMimeType | (String mime) | String[] | 🟢 Returns index.md. |
| getMimeTypes | () | String[] | 🟢 Returns text/markdown. |

## Main Flow
1. 🟢 Webserver selects plugin for text/markdown.
2. 🟢 Plugin reads source line-by-line with FileReader.
3. 🟢 PegDown converts Markdown to HTML.
4. 🟢 Output bytes are encoded as UTF-8 and returned as text/html.

## Alternative Flows
- 🟢 Source read failure logs and returns null.
- 🟢 Unsupported UTF-8 encoding logs and returns an empty byte body.

## Dependencies
- 🟢 Webserver plugin interfaces and core response types.
- 🟢 Pegdown 1.4.1.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Plugin uses default index.md for markdown MIME. | MarkdownWebServerPluginInfo.java | 🟢 |
| 🟢 Input uses platform-default FileReader while output is UTF-8. | MarkdownWebServerPlugin.java:79-EOF | 🟢 |

## Internal State
- 🟢 One PegDownProcessor is stored per plugin instance.

## Observability
- 🟢 Read and encoding failures use Java logging.
- 🔴 Metrics/tracing were not found.

## Risks and Gaps
- 🔴 HTML sanitization/trust policy is unspecified.
- 🟡 Input character decoding may differ by host platform.

