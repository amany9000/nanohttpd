# Regression Watch: Modernizar dependências para Java 17

> Feature: `001-modernize-dependencies-java17`

## Regras confirmadas a vigiar

| ID | Origem (arquivo, seção) | Regra esperada após mudança | Tipo de verificação | Sinal de violação |
|---|---|---|---|---|
| W001 | `_reversa_sdd/domain.md`, Confirmed rules #8 | O plugin Markdown continua anunciando `text/markdown`, usando `index.md` e retornando HTML renderizado por meio do contrato de plugin. Diferenças de saída introduzidas por Flexmark precisam ser identificadas e documentadas. | contrato + comparação de renderização | MIME, seleção de index ou corpo HTML deixam de funcionar, ou alterações não explicadas na saída Markdown aparecem. |

| W002 | `_reversa_sdd/domain.md`, Confirmed rules #6 | O webserver mantém as regras de diretório e restringe todo caminho canônico à raiz configurada; listagem continua compatível por padrão, é configurável e escapa nomes/links antes de gerar HTML. | contrato + teste de filesystem/HTML | Caminho por symlink sai da raiz, nomes aparecem sem escaping, ou o modo padrão deixa de listar diretórios. |
| W003 | `_reversa_sdd/domain.md`, Confirmed rules #5 | Handshake e fluxo de frames válidos continuam funcionando; frames recebidos de cliente sem máscara são rejeitados, e falhas runtime de callback são reportadas e fecham a conexão. | contrato de protocolo + teste de callback | Frame sem máscara é aceito ou falha de callback deixa conexão aberta/não observada. |

## Observações sem peso de regressão

- 🟡 A baseline alvo Java 17 e a coerência Maven/Gradle derivam de decisões de migração, não de regras confirmadas do legado.
- 🔴 Limites de request/upload, política de arquivo temporário, caps WebSocket e sanitização HTML continuam lacunas em `_reversa_sdd/questions.md`; não são critérios confirmados neste watch.
- A validação do novo conjunto de dependências e dos builds Maven/Gradle permanece pendente; `mvn test -q`, `mvn package -q`, `./gradlew test` e `./gradlew assemble` passaram em JDK 27. Os builds miram Java 17, mas não havia JDK 17 instalado para runtime validation. T013 (limites e regras de armazenamento temporário) continua falho e sem validação. A validação completa continua bloqueada por T013 (limites e regras de armazenamento temporário).

## Histórico de re-extrações

Ainda vazio. Será atualizado após uma futura execução de `/reversa`.

## Arquivadas

Ainda vazio.
