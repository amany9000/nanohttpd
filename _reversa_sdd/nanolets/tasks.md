# Nanolets Router, Implementation Tasks

## Prerequisites
- [ ] 🟢 Core session and response interfaces.
- [ ] 🔴 Choose responder lifecycle and construction policy.

## Tasks
- [ ] T-01 Compile URI patterns and extract named parameters.
  - Legacy source: nanolets/src/main/java/org/nanohttpd/router/RouterNanoHTTPD.java:320-410
  - Definition of done: 🟢 Full path match and parameter mapping are deterministic.
  - Confidence: 🟢
- [ ] T-02 Implement route prioritization and add/remove behavior.
  - Legacy source: RouterNanoHTTPD.java:471-565
  - Definition of done: 🟢 Default, explicit-priority, and insertion-order strategies follow configured order.
  - Confidence: 🟢
- [ ] T-03 Instantiate responder and dispatch method callbacks.
  - Legacy source: RouterNanoHTTPD.java:360-410
  - Definition of done: 🟢 Supported verbs and other() behavior are covered; exceptions yield 500.
  - Confidence: 🟢
- [ ] T-04 Implement configurable fallback handlers.
  - Legacy source: RouterNanoHTTPD.java:251-305,608-664
  - Definition of done: 🟢 Missing route and unsupported-method cases use configured fallbacks.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Cover literal and parameterized routes and route priority.
- [ ] TT-02 🟢 Cover each method callback, other(), and fallback behavior.
- [ ] TT-03 🟢 Cover handler instantiation and exceptions.

## Suggested Order
1. 🟢 Route matcher.
2. 🟢 Prioritizer and router.
3. 🟢 Responder implementation and fallbacks.

## Pending Gaps (🔴)
- 🔴 Confirm handler construction/lifecycle contract.

