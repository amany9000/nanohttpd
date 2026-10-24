---
schemaVersion: 1
generatedAt: 2026-10-24T08:32:59Z
reversa:
  version: "1.3.6"
kind: parity_test
producedBy: inspector
hash: "sha256:15e2261e64cacbbefbb97caf15f75d74218c304ce2296e9e9157e71f0b4b8a63"
---

# language: en
# spec-id: PT-003
# traceability:
#   process_flows: _reversa_sdd/flowcharts/websocket.md — handshake, frame dispatch, close
#   target_architecture: _reversa_sdd/migration/target_architecture.md — BC-01 / websocket
#   paradigm: framework-neutral class-based Java; no change

Feature: WebSocket upgrade and frame lifecycle
  The optional WebSocket module preserves protocol behavior and applies approved safeguards.

  @parity @critical
  Scenario: Valid WebSocket handshake upgrades the HTTP connection
    Given an HTTP upgrade request contains the required WebSocket headers and version 13
    When the WebSocket handshake is processed
    Then the server responds with status 101
    And the response includes the computed Sec-WebSocket-Accept value

  @parity
  Scenario: Ping frame receives a matching pong
    Given an upgraded connection receives a valid ping frame with a payload
    When the frame is processed
    Then a pong frame is sent with the same payload

  @parity
  Scenario: Invalid client frame is rejected and the connection closes
    Given an upgraded connection receives an unmasked client frame or an oversized frame
    When the frame is validated
    Then the server rejects it according to the approved protocol close policy
    And no oversized payload is delivered to the application callback
