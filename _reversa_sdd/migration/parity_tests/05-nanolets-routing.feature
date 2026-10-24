---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:0db121f736ab50932957b1cfd5c3a55c29ab0196f7c99408b4b3ca2bc308f7a8"
---

# language: en
# spec-id: PT-005
# traceability:
#   process_flows: _reversa_sdd/flowcharts/nanolets.md — route matching and method dispatch
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-03 / nanolets
#   paradigm: framework-neutral class-based Java; no change

Feature: Nanolets route dispatch
  URI routes preserve full-match and configured prioritizer behavior.

  @parity @critical
  Scenario: Named route parameter is extracted on full path match
    Given a route pattern contains the named segment ":id"
    When a request path fully matches the normalized route
    Then the responder receives the captured id value

  @parity
  Scenario: First matching route in prioritizer order handles the request
    Given multiple registered routes match a request path
    When the configured prioritizer orders those routes
    Then the first route in that order handles the request

  @parity
  Scenario: Responder failure maps to an internal server error
    Given a matching responder throws during construction or execution
    When Nanolets processes the request
    Then the route response has status 500
