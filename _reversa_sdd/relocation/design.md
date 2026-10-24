# Maven Relocation, Technical Design

## Interface
| Symbol | Signature | Return | Note |
|---|---|---|---|
| Relocation POM | Maven coordinates | Artifact metadata | 🟢 Child POM sets target groupId org.nanohttpd. |

## Main Flow
1. 🟢 Maven reads the relocation parent and child POM.
2. 🟢 Legacy com.nanohttpd coordinates point to org.nanohttpd group.
3. 🟢 Child resources contain relocated.txt marker.

## Alternative Flows
- 🔴 No fallback or support-window policy is specified.

## Dependencies
- 🟢 Maven artifact metadata and Sonatype OSS parent configuration.

## Identified Design Decisions
| Decision | Evidence | Confidence |
|---|---|---|
| 🟢 Preserve old group coordinates by Maven relocation rather than Java forwarding code. | relocation POMs | 🟢 |

## Internal State
- 🟢 No runtime state; relocation is publication metadata.

## Observability
- 🔴 No runtime logs/metrics apply.

## Risks and Gaps
- 🔴 Support duration for old coordinates is unspecified.
- 🟢 No Java source exists under relocation/.

