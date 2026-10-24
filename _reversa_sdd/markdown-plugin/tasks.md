# Markdown Plugin, Implementation Tasks

## Prerequisites
- [ ] 🟢 Implement WebServerPlugin interface.
- [ ] 🟢 Provide Pegdown or compatible Markdown renderer.
- [ ] 🔴 Decide HTML sanitization policy.

## Tasks
- [ ] T-01 Register MIME type and index file.
  - Legacy source: markdown-plugin/src/main/java/org/nanohttpd/markdown/MarkdownWebServerPluginInfo.java
  - Definition of done: 🟢 Registry exposes text/markdown and index.md.
  - Confidence: 🟢
- [ ] T-02 Read Markdown source and render HTML.
  - Legacy source: markdown-plugin/src/main/java/org/nanohttpd/markdown/MarkdownWebServerPlugin.java:79-EOF
  - Definition of done: 🟢 Readable source yields UTF-8 text/html response.
  - Confidence: 🟢
- [ ] T-03 Preserve webserver fallback on read failure.
  - Legacy source: MarkdownWebServerPlugin.java:79-EOF
  - Definition of done: 🟢 Failed source read returns null and is handled by caller.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Cover index/MIME registration and basic rendering.
- [ ] TT-02 🟢 Cover read failure and encoding fallback.
- [ ] TT-03 🔴 Validate sanitization behavior against maintainer policy.

## Suggested Order
1. 🟢 Plugin metadata.
2. 🟢 Source decoding and rendering.
3. 🔴 Add sanitization after policy decision.

## Pending Gaps (🔴)
- 🔴 Confirm trusted-content and sanitization requirements.

