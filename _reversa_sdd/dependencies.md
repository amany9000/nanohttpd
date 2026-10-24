# Dependencies and Build Configuration

## Build systems

- Maven parent/aggregator: root `pom.xml`, project version `2.3.2-SNAPSHOT`.
- Gradle multi-project setup: root `build.gradle` and `settings.gradle`, also version `2.3.2-SNAPSHOT`.
- Both build descriptors target Java 1.7. Maven compiler plugin is 3.3; Surefire is 2.18.1; JaCoCo is 0.7.4.201502262128.
- JUnit 4.12 is the shared test dependency in the root Maven POM and Gradle configuration.

## Product dependencies

| Dependency | Version | Scope / module |
|---|---:|---|
| `commons-fileupload` | 1.3.1 | `fileupload`; product dependency |
| `javax.servlet:servlet-api` | 2.5 | `fileupload`; provided/compile-only integration API |
| `org.pegdown:pegdown` | 1.4.1 | `markdown-plugin`; product dependency |
| `org.nanohttpd:nanohttpd` | `2.3.2-SNAPSHOT` | Internal dependency of `webserver`, `websocket`, `nanolets`, and sample/plugin modules |

## Test dependencies

| Dependency | Version | Scope / module |
|---|---:|---|
| `junit:junit` | 4.12 | Shared test framework |
| `org.apache.httpcomponents:httpclient` | 4.2.5 | `core` tests |
| `org.apache.httpcomponents:httpmime` | 4.2.5 | `core` tests |
| `org.apache.httpcomponents:httpclient` | 4.4.1 | `webserver`, `nanolets`, and `fileupload` tests |
| `org.apache.httpcomponents:httpmime` | 4.4.1 | `fileupload` tests |
| `org.mockito:mockito-all` | 1.9.5 | `websocket` tests |
| `org.eclipse.jetty.websocket:websocket-client` | 9.3.0.M2 | `websocket` tests |

## Build plugins and publishing

The parent POM configures compiler, Javadoc, release, site, license, Surefire, JaCoCo, Checkstyle, formatter, PMD, FindBugs, and reporting plugins. Release artifacts use the `release-sign-artifacts` profile. Distribution management points to Sonatype staging/snapshot repositories, and site publishing uses an SCP URL. These are configured destinations only; no publish command was run.

## Observations

- The repository maintains Maven and Gradle dependency declarations in parallel.
- Apache HttpComponents versions differ by module (4.2.5 in core, 4.4.1 in several integration tests).
- The root Maven module list does not include the additional `relocation/` POM trees.
