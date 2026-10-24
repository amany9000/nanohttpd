---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:c2c85a1e80f34069b32c0d773ac7a50152c9dff05f82d903ef23f5478053960f"
---

# language: en
# spec-id: PT-006
# traceability:
#   process_flows: _reversa_sdd/flowcharts/fileupload.md — multipart adaptation and parsing
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-03 / fileupload
#   paradigm: framework-neutral class-based Java; no change

Feature: Multipart upload adapter
  The adapter exposes the core session stream to the host-configured multipart parser.

  @parity @critical
  Scenario: Multipart POST is recognized and parsed by the supplied factory
    Given a POST request has a multipart content type and boundary
    And the host supplies a FileItemFactory
    When the adapter parses the request
    Then the supplied factory receives the adapted session context
    And the parsed items are available through the adapter API

  @parity
  Scenario: Non-POST request is not classified as multipart
    Given a request uses a method other than POST
    When multipart detection runs
    Then the adapter reports that the request is not multipart

  @parity
  Scenario: Upload over configured limit is rejected
    Given an upload limit is configured
    When the multipart request exceeds the limit
    Then parsing fails with the documented size-limit response
    And temporary upload resources are cleaned up
