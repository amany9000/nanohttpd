---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:a4056d2246884eda2b7f5e43cb94c13189061a559643355a72206740264f0e1c"
---

# language: en
# spec-id: PT-004
# traceability:
#   process_flows: _reversa_sdd/flowcharts/webserver.md — root resolution, directory response, ranges
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-02 / webserver
#   paradigm: framework-neutral class-based Java; no change

Feature: Static resource serving
  The webserver serves only resources contained by configured roots.

  @parity @critical
  Scenario: Path traversal and symlink escape remain outside the allowed root
    Given a static web root is configured
    And a requested path traverses above the root or resolves through a symlink outside it
    When the resource is resolved
    Then the server returns a forbidden response
    And no file outside the canonical root is read

  @parity
  Scenario: Directory without an index follows slash and listing policy
    Given a readable directory without an index file is requested
    When the server resolves the directory request
    Then it redirects to a slash-terminated URI when needed
    And any enabled directory listing escapes rendered names and values

  @parity
  Scenario: Byte range and entity tag requests preserve response semantics
    Given a resource has a known entity tag and byte length
    When a matching conditional request or valid byte range is received
    Then the response is 304 for an unchanged validator or 206 for the requested range
