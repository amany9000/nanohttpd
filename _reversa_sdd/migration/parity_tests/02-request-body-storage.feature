---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:ad1e99676828c7c264b47c32a06be8de18cafcc898f7f7e6c0b13c8ca44da086"
---

# language: en
# spec-id: PT-002
# traceability:
#   process_flows: _reversa_sdd/flowcharts/core.md — body parsing and temporary storage
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-01 / core
#   paradigm: framework-neutral class-based Java; no change

Feature: Request body parsing and cleanup
  Body parsing keeps its documented access semantics while enforcing approved limits.

  @parity @critical
  Scenario: Small request body is parsed through the memory path
    Given a request body is smaller than the configured memory-to-file threshold
    When the request body is parsed
    Then the body fields are available through the documented session accessors
    And temporary storage is not required

  @parity @critical
  Scenario: Large request body uses temporary storage and is cleaned up
    Given a request body is at or above the configured memory-to-file threshold
    When the request completes or parsing fails
    Then temporary storage uses the approved secure storage policy
    And temporary resources are cleaned up

  @parity
  Scenario: Request exceeding a configured size limit is rejected
    Given a finite request body limit is configured
    When the client sends a request body larger than that limit
    Then the server rejects the request using the documented client-error behavior
