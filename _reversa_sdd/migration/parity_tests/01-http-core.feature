---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:57c6c6cf70bced973fcf17474358e636d01c894d435b66625fc1a53318b0da4e"
---

# language: en
# spec-id: PT-001
# traceability:
#   process_flows: _reversa_sdd/flowcharts/core.md — request parsing and response serialization
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-01 / core
#   paradigm: framework-neutral class-based Java; no change

Feature: HTTP request and response lifecycle
  The new release preserves the documented core protocol behavior.

  @parity @critical
  Scenario: Valid HTTP request reaches the host handler and serializes its response
    Given the server is started with a host handler
    And a client sends a syntactically valid request
    When the server parses the request and invokes the handler
    Then the handler receives the method, URI, headers, and parameters
    And the returned status, headers, and body are serialized according to response settings

  @parity
  Scenario: Unknown method returns a client error
    Given the server is running
    When a request uses an unsupported method token
    Then the server responds with HTTP 400
    And the connection closes according to the documented parser behavior

  @parity
  Scenario: HTTP/1.1 connection remains open unless closed
    Given a valid HTTP/1.1 request without a Connection close directive
    When the handler returns a response that does not close the connection
    Then the server keeps the connection open for the next request
