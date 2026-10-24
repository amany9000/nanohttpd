# Maven Relocation, Implementation Tasks

## Prerequisites
- [ ] 🟢 Publish target org.nanohttpd artifacts.
- [ ] 🟢 Configure Maven relocation metadata.

## Tasks
- [ ] T-01 Maintain parent aggregator and child relocation POMs.
  - Legacy source: relocation/pom.xml and relocation/*/pom.xml
  - Definition of done: 🟢 Each declared child points to org.nanohttpd group.
  - Confidence: 🟢
- [ ] T-02 Preserve marker resources for relocated modules.
  - Legacy source: relocation/*/src/main/resources/relocated.txt
  - Definition of done: 🟢 Marker is packaged for each declared artifact.
  - Confidence: 🟢

## Test Tasks
- [ ] TT-01 🟢 Validate relocation metadata for all five legacy artifacts.
- [ ] TT-02 🟢 Validate marker resource packaging.
- [ ] TT-03 🔴 Confirm support/deprecation window with maintainers.

## Suggested Order
1. 🟢 Publish target coordinates.
2. 🟢 Maintain relocation POMs and markers.

## Pending Gaps (🔴)
- 🔴 Confirm how long old coordinates remain supported.

