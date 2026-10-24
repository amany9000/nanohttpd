# Legacy Impact: Modernizar dependências para Java 17

> Data: 2026-10-24  
> Feature: `001-modernize-dependencies-java17`  
> Cenário: legado (`_reversa_sdd/architecture.md` + `_reversa_sdd/domain.md`)  
> Política no início da execução: `allowLegacyEdits: true`; `allowedPaths: []` (edição irrestrita).

## Arquivos afetados

| Arquivo afetado | Componente | Tipo | Severidade | Justificativa |
|---|---|---|---|---|
| `pom.xml`, `*/pom.xml` | Build Maven | regra-alterada | HIGH | Java 17, plugins e versões de release major foram atualizados; o provider SSH permanece na GA 3.5.3 pois o POM configura publicação de site via SCP. |
| `build.gradle`, `*/build.gradle` | Build Gradle | regra-alterada | HIGH | Java 17, Gradle 9.8.2, Maven Central e DSL atualizada; não há wrapper versionado. |
| `core/pom.xml`, `core/build.gradle` e dependências de teste dos módulos | Testes dos módulos | regra-alterada | MEDIUM | Clientes HTTP e bibliotecas de teste foram atualizados; HttpClient permanece em 4.5.x para limitar alterações de API legada. |
| `websocket/pom.xml`, `websocket/build.gradle`, `WebSocketResponseHandlerTest.java` | WebSocket / testes | regra-alterada | HIGH | Jetty 12.1 e Mockito 5 substituem versões antigas, incluindo adaptação do pacote do runner. |
| `fileupload/pom.xml`, `fileupload/build.gradle` | File upload | regra-alterada | MEDIUM | Commons FileUpload passa a 1.6.0; políticas de tamanho e armazenamento seguro ainda não foram implementadas. |
| `markdown-plugin/pom.xml`, `markdown-plugin/build.gradle`, `MarkdownWebServerPlugin.java` | Markdown plugin | componente-alterado | HIGH | Pegdown foi substituído por Flexmark 0.64.8. Contrato geral permanece, mas equivalência e sanitização não foram verificadas. |
| `webserver/src/main/java/org/nanohttpd/webserver/SimpleWebServer.java` | Webserver | regra-alterada | HIGH | Adiciona contenção após canonicalização, escaping de conteúdo de listagem e configuração de directory listing (habilitada por padrão para compatibilidade). |
| `websocket/src/main/java/org/nanohttpd/protocols/websockets/WebSocket.java` | WebSocket | regra-alterada | HIGH | Rejeita frames recebidos sem máscara e encaminha falhas de callback a `onException`, fechando a conexão com erro interno. |
| `relocation/**/pom.xml` | Relocation | delta-de-contrato-externo | MEDIUM | POMs de `com.nanohttpd` foram alinhados para `3.0.0-SNAPSHOT` e continuam relocando para `org.nanohttpd`. |

| `gradlew`, `gradlew.bat`, `gradle/wrapper/*` | Build Gradle | componente-novo | MEDIUM | Adiciona wrapper versionado para reproduzir Gradle 9.8.2. |
| `core/src/test/java/org/nanohttpd/junit/protocols/http/integration/IntegrationTestBase.java` | Testes core | regra-alterada | LOW | Configura o cliente HTTP de teste atualizado para preservar a interpretação legada de datas de cookie. |
| `websocket/src/test/java/org/nanohttpd/junit/protocols/websockets/SimpleEchoSocket.java` | Testes WebSocket | regra-alterada | MEDIUM | Migra endpoint de teste para anotações, envio assíncrono e fechamento Jetty 12. |
| `README.md` | Adoção / documentação | regra-nova | MEDIUM | Documenta baseline Java 17, módulos, mudanças de dependência, relocation e lacunas restantes. |

## Diff conceitual por componente

Os builds foram elevados à baseline Java 17 e ao major `3.0.0-SNAPSHOT`. Maven atualiza compiler, javadoc, Surefire, JaCoCo e relatórios selecionados; Gradle usa 9.8.2, Maven Central e configurações de dependência correntes. O site SCP continua configurado e o Wagon SSH foi atualizado para 3.5.3; a migração futura para Wagon 4 precisa substituir o provider se o site continuar sendo publicado.

As dependências de teste foram atualizadas mantendo HttpClient 4.5.14 na API 4.x. WebSocket usa Jetty 12.1.14 e Mockito 5.24.0. FileUpload usa Commons FileUpload 1.6.0. Markdown usa Flexmark 0.64.8, mas UTF-8 estrito e modo seguro de raw HTML permanecem sem adaptação.

Webserver agora verifica se o caminho canônico ainda fica dentro da raiz, escapa valores dinâmicos da listagem e oferece setter para desabilitar listagens. WebSocket exige máscara em frames recebidos e trata falhas runtime do callback como erro de conexão. Limites de tamanho de request/frame e configuração de temp files não foram implementados; T013 permanece falho. Maven tests/package e Gradle tests/assemble passaram no JDK 27, mas ainda não houve execução em JDK 17. O pacote Javadoc produz erros não fatais em tags `<p/>` legadas.

## Preservadas

- Regra confirmada 1: request line malformada ou método HTTP não suportado resulta em `400 Bad Request`.
- Regra confirmada 2: a política de conexão HTTP/1.1 permanece definida pelo cabeçalho `Connection` e pela resposta.
- Regra confirmada 3: armazenamento do corpo abaixo de 1.024 bytes em memória e a partir desse limiar em arquivo temporário não foi alterado.
- Regra confirmada 4: parsing de multipart, formulários URL-encoded, `postData` e conteúdo PUT não foi alterado.
- Regra confirmada 7: seleção e callbacks de rotas Nanolets não foram alterados.

## Modificadas

- Regra confirmada 5: handshake, ping/pong e fechamento de protocolo permanecem; agora frames de cliente sem máscara são rejeitados e exceções runtime do handler são encaminhadas para `onException` antes do fechamento.
- Regra confirmada 6: rejeição de `../`, redirecionamento e seleção de index permanecem; caminhos também são contidos após resolução canônica/symlink e diretórios podem ter listagem desligada. Nomes e caminhos no HTML de listagem são escapados.
- Regra confirmada 8: plugin continua anunciando `text/markdown` e retornando HTML, mas o renderer mudou para Flexmark. A equivalência detalhada permanece por validar.
