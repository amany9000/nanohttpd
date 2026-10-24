---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:390de3cd8f4d75b8498126121a0a9a5bb2f8f618ee9495ed5a54fef905053d26"
---

# language: en
# spec-id: PT-007
# traceability:
#   process_flows: _reversa_sdd/flowcharts/markdown-plugin.md — resource read and rendering
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-02 / markdown-plugin
#   paradigm: framework-neutral class-based Java; no change

Feature: Markdown resource rendering
  The optional plugin converts Markdown resources to UTF-8 HTML under the approved safe-rendering policy.

  @parity
  Scenario: Readable Markdown file becomes an HTML response
    Given a readable Markdown file is selected by the plugin
    When the file is decoded as UTF-8 and rendered
    Then the response has content type text/html with UTF-8 encoding
    And generated output follows the approved sanitization policy

  @parity
  Scenario: Source read failure allows the webserver fallback
    Given the plugin cannot read a selected Markdown source
    When the plugin handles the resource
    Then it returns the documented fallback result
