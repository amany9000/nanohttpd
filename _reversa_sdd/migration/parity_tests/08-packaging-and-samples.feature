---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:627061bd92b02f7a306d651cb82ccdaf19340efafefee9dd5d88b07431371694"
---

# language: en
# spec-id: PT-008
# traceability:
#   process_flows: _reversa_sdd/flowcharts/samples.md and _reversa_sdd/relocation/requirements.md — example response and coordinate resolution
#   target_architecture: _reversa_sdd/migration/target_architecture.md — samples and relocation components
#   paradigm: framework-neutral class-based Java; no change

Feature: Example safety and legacy coordinate compatibility
  The coordinated release preserves support artifacts while documenting the new baseline.

  @parity
  Scenario: Sample escapes reflected request values
    Given a sample handler displays a request value in HTML
    When the value contains markup characters
    Then the generated page escapes those characters as text

  @parity @critical
  Scenario: Legacy Maven coordinates resolve to the new group
    Given a consumer requests an old com.nanohttpd Maven coordinate
    When the repository metadata is resolved
    Then relocation metadata identifies the corresponding org.nanohttpd artifact
    And the relocation support window follows the published policy
