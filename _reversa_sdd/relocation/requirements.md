# Maven Relocation Artifacts

## Overview
🟢 The relocation tree publishes metadata for legacy com.nanohttpd Maven coordinates and points to org.nanohttpd artifacts.

## Responsibilities
- 🟢 Aggregate five legacy artifacts under relocation/pom.xml.
- 🟢 Declare target groupId org.nanohttpd in child artifact POMs.
- 🟢 Include relocated.txt marker resources.

## Business Rules
- 🟢 Parent relocation project version is 2.2.0.
- 🟢 Five artifact POMs declare group relocation to org.nanohttpd.
- 🔴 Availability and deprecation period are unspecified.

## Functional Requirements
| ID | Requirement | Priority | Acceptance Criterion |
|---|---|---|---|
| FR-01 | 🟢 Keep legacy artifact coordinates resolvable through Maven relocation metadata. | Should | Maven metadata identifies org.nanohttpd target group. |
| FR-02 | 🟢 Include relocation markers for child artifacts. | Could | Marker exists in each relocated source resource tree. |

## Acceptance Criteria
Given a consumer requests a legacy coordinate, when Maven reads relocation metadata, then target groupId is org.nanohttpd. 🟢
Given one of five relocated modules is published, when artifact contents are inspected, then its relocation marker is present. 🟢

## Priority
| Requirement | MoSCoW | Justification |
|---|---|---|
| Maven relocation metadata | Should | 🟢 Maintains dependency-coordinate compatibility. |
| Marker resources | Could | 🟢 Support relocation packaging metadata. |

## Code Traceability
| File | Coverage |
|---|---|
| relocation/pom.xml | 🟢 |
| relocation/nanohttpd*/pom.xml | 🟢 |
| relocation/*/src/main/resources/relocated.txt | 🟢 |

