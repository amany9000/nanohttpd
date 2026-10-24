# Markdown Plugin

## Overview
🟢 Implements the webserver plugin interface to render Markdown files as HTML.

## Responsibilities
- 🟢 Advertise text/markdown and index.md.
- 🟢 Read Markdown source and convert it with Pegdown.
- 🟢 Return UTF-8 HTML as a fixed-length response.

## Business Rules
- 🟢 Existing files are eligible for plugin serving.
- 🟢 Read failures return null to allow the webserver fallback path.
- 🟢 Rendered output uses text/html and UTF-8 bytes.
- 🔴 Sanitization and trust policy for generated HTML are unspecified.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Register text/markdown and index.md. | Must | Plugin metadata exposes expected MIME and index names. |
| FR-02 | 🟢 Convert readable Markdown files to HTML. | Must | Response body contains Pegdown output and text/html type. |
| FR-03 | 🟢 Return fallback on source read failure. | Should | Failed read yields null plugin response. |

## Acceptance Criteria
Given a readable Markdown file, when served, then it is rendered as UTF-8 HTML. 🟢
Given a source read failure, when plugin runs, then it returns null for fallback. 🟢
Given a directory request with no other index, when plugin metadata is used, then index.md is selected. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| MIME registration and rendering | Must | 🟢 Main module purpose. |
| Read failure fallback | Should | 🟢 Allows webserver fallback behavior. |

## Code Traceability
| File | Coverage |
|---|---|
| markdown-plugin/src/main/java/org/nanohttpd/markdown/MarkdownWebServerPlugin.java | 🟢 |
| markdown-plugin/src/main/java/org/nanohttpd/markdown/MarkdownWebServerPluginInfo.java | 🟢 |

