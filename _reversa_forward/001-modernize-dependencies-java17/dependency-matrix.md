# Matriz de dependências — Java 17

Inventário estático dos descritores do repositório em 2026-10-24. As versões-alvo são candidatas a validar no momento da alteração; não são pins já aprovados pelo build.

| Área / módulo | Coordenada ou ferramenta | Maven atual | Gradle atual | Escopo atual | Candidata / decisão inicial | Confiança |
|---|---|---:|---:|---|---|---|
| Build raiz | Compiler plugin | 3.3 | Gradle 4.4.1; source/target 1.7 | build | Atualizar para plugin compatível com release 17 | 🟢 |
| Build raiz | Surefire | 2.18.1 | n/a | build | Atualizar para versão estável compatível com JUnit selecionado | 🟢 |
| Build raiz | JaCoCo | 0.7.4.201502262128 | n/a | build | 0.8.15 GA; confirmar plugin e regras | 🟢 |
| Build raiz | JUnit | 4.12 | 4.12 | test | Avaliar permanecer em 4.13.x versus migração JUnit 6 + Vintage | 🟡 |
| core | HttpClient + HttpMime | 4.2.5 | 4.2.5 | test | Avaliar HttpComponents 5.x GA; adaptação de APIs de teste | 🟢 |
| websocket | Mockito | mockito-all 1.9.5 | mockito-all 1.9.5 | test | `mockito-core` 5.x GA; adaptar import/configuração | 🟢 |
| websocket | Jetty websocket-client | 9.3.0.M2 | 9.3.0.M2 | test | Jetty 12.1.x GA, Java 17; API de cliente muda | 🟢 |
| webserver | HttpClient | 4.4.1 | 4.4.1 | test | Avaliar HttpComponents 5.x GA | 🟢 |
| nanolets | HttpClient | 4.4.1 | 4.4.1 | test | Avaliar HttpComponents 5.x GA | 🟢 |
| fileupload | Commons FileUpload | 1.3.1 | 1.3.1 | runtime | 1.6.0 GA conservador; 2.0.0-M5 não é GA | 🟢 |
| fileupload | Servlet API | javax 2.5 | javax 2.5 | provided / compileOnly + test | Manter javax para API pública; avaliar Jakarta somente em mudança major separada | 🟡 |
| fileupload | HttpClient + HttpMime | 4.4.1 | 4.4.1 | test | Avaliar HttpComponents 5.x GA | 🟢 |
| markdown-plugin | Pegdown | 1.4.1 | 1.4.1 | runtime | Flexmark 0.64.8 candidato; confirmar extensões e saída | 🟢 |
| parent build | Maven plugins diversos | compiler 3.3; javadoc 2.10.1; release 2.5.1; site 3.4; license 1.7; JaCoCo 0.7.4; PMD 3.2; checkstyle 2.15; assembly 2.2-beta-5 | n/a | build/reporting | Atualizar seletivamente para versões GA Java 17; revisar plugins abandonados | 🟡 |
| publicação | Maven Wagon SSH | 2.7 | n/a | extensão/site | Remover provider deprecated se não houver publicação SSH ativa; confirmar fluxo | 🟢 |
| todos os módulos | Repositório Gradle | n/a | JCenter | resolução | Substituir por Maven Central | 🟢 |
| todos os módulos | DSL Gradle | n/a | compile / testCompile | dependências | Migrar para api/implementation/compileOnly/testImplementation | 🟢 |
| módulos relocados | POMs de relocation | sem versões de dependências diretas relevantes vistas | n/a | publicação | Conferir coordenadas e módulos publicados sem alterar topologia | 🟡 |

## Candidatos GA consultados

| Componente | Candidato verificado | Fonte upstream |
|---|---|---|
| Commons FileUpload | 1.6.0 | https://commons.apache.org/proper/commons-fileupload/changes.html |
| HttpComponents Client | 5.6.5 GA | https://hc.apache.org/news.html |
| Jetty | 12.1.14 stable; Java 17 mínimo | https://jetty.org/download.html |
| flexmark-java | 0.64.8 | https://github.com/vsch/flexmark-java/blob/master/VERSION.md |
| Maven Compiler Plugin | 3.16.0 | https://maven.apache.org/plugins/maven-compiler-plugin/ |
| Maven Surefire Plugin | 3.6.0 | https://maven.apache.org/surefire/maven-surefire-plugin/ |
| JaCoCo | 0.8.15 estável | https://www.jacoco.org/jacoco/trunk/doc/changes.html |
| Gradle | 9.8.2; Java 17 é baseline de runtime | https://docs.gradle.org/current/userguide/compatibility.html |

As versões GA são candidatos para adaptação, não confirmação de compatibilidade dos imports e testes existentes. Dependências Maven/plugins adicionais (site, release, assembly, license, formatting, checkstyle, reporting) ainda precisam de decisão individual; não se deve presumir que cada plugin antigo tenha substituto direto.

## Divergências e observações

- Maven e Gradle repetem dependências de teste e versões inconsistentes entre core (HttpClient 4.2.5) e módulos restantes (4.4.1).
- Scripts Gradle individuais repetem Wrapper 4.4.1; não há `gradlew`, `mvnw` nem propriedades de wrapper versionadas no inventário.
- O projeto atual não centraliza versões em BOM ou catálogo Gradle.
- Fonte: `investigation.md`, `pom.xml` e descritores por módulo. Compatibilidade final exige adaptação e validação de build.


## Resolved graph / build comparison

- Maven dependency trees and Gradle subproject dependency reports completed successfully for all seven current modules.
- The test dependency versions/scope for JUnit 4.13.2 and HttpClient 4.5.14 align across builds. WebSocket test dependencies align at Jetty 12.1.14 and Mockito 5.24.0. FileUpload aligns at Commons FileUpload 1.6.0; Markdown aligns at Flexmark 0.64.8.
- Maven test + package and Gradle test + assemble succeeded. The environment ran JDK 27; compiler outputs target Java 17, but runtime execution under JDK 17 was not available.
- Maven reports a missing explicit `maven-jar-plugin` version in `websocket/pom.xml`; dependency graph comparison also reported legacy plugin/Javadoc warnings. These remain follow-up build maintenance items.
