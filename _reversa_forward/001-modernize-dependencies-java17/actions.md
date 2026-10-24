# Actions: Modernizar dependências para Java 17

> Identificador: `001-modernize-dependencies-java17`
> Data: `2026-10-24`
> Roadmap: `_reversa_forward/001-modernize-dependencies-java17/roadmap.md`

## Resumo

| Métrica | Valor |
|---------|-------|
| Total de ações | 19 |
| Paralelizáveis (`[//]`) | 4 |
| Maior cadeia de dependência | 10 |

## Fase 1, Preparação

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T001 | Inventariar versões efetivas de dependências, plugins, perfis e escopos Maven por módulo numa matriz rastreável. | - | - | `_reversa_forward/001-modernize-dependencies-java17/dependency-matrix.md` | 🟢 | `[X]` |
| T002 | Inventariar versões Gradle e dependências resolvidas por módulo na mesma matriz, marcando divergências com Maven. | T001 | - | `_reversa_forward/001-modernize-dependencies-java17/dependency-matrix.md` | 🟢 | `[X]` |
| T003 | Configurar o POM pai para compilar com release Java 17; não há Maven Wrapper versionado neste repositório. | T001 | `[//]` | `pom.xml` | 🟢 | `[X]` |
| T004 | Atualizar o Gradle Wrapper e a configuração raiz para executar com Java 17 e remover JCenter/configurações removidas. | T001 | `[//]` | `build.gradle` | 🟢 | `[X]` |
| T005 | Migrar os scripts Gradle dos módulos para DSL suportada e declarar Java 17 sem alterar a topologia. | T004 | - | `core/build.gradle` (demais scripts de módulo) | 🟡 | `[X]` |
| T006 | Selecionar candidatos GA compatíveis com Java 17 e registrar licença, suporte e impacto de API na matriz. | T001, T002 | - | `_reversa_forward/001-modernize-dependencies-java17/dependency-matrix.md` | 🟡 | `[X]` |

## Fase 2, Testes

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T007 | Atualizar versões e configuração dos plugins Maven de compilação, testes e cobertura para Java 17. | T003, T006 | - | `pom.xml` | 🟢 | `[X]` |
| T008 | Atualizar dependências de teste do módulo core e confirmar compatibilidade Java 17 no build. | T003, T006 | `[//]` | `core/pom.xml` | 🟢 | `[X]` |
| T009 | Atualizar dependências de teste do WebSocket e ajustar usos incompatíveis da API de teste. | T003, T006 | `[//]` | `websocket/pom.xml` | 🟡 | `[X]` |
| T010 | Atualizar clientes HTTP/WebSocket e dependências de teste restantes por módulo, preservando escopos. | T003, T006 | - | `webserver/pom.xml` (demais POMs) | 🟡 | `[X]` |

## Fase 3, Núcleo

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T011 | Atualizar Commons FileUpload no módulo e adaptar a integração às APIs estáveis escolhidas. | T006, T008 | - | `fileupload/pom.xml` | 🟢 | `[X]` |
| T012 | Substituir Pegdown por renderer Markdown mantido e adaptar a conversão sem mudar o contrato do plugin. | T006, T008 | - | `markdown-plugin/pom.xml` | 🟢 | `[X]` |
| T013 | Implementar limites configuráveis e armazenamento temporário seguro para os fluxos de request/upload aprovados. | T011 | - | `fileupload/src/main/java` | 🟢 | `[ ]` |
| T014 | Implementar contenção canônica de caminhos, escaping e validação de WebSocket segundo as exceções de paridade aprovadas. | T008, T009 | - | `webserver/src/main/java` (módulos afetados) | 🟢 | `[X]` |

## Fase 4, Integração

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T015 | Alinhar versões, escopos e dependências runtime Maven/Gradle em todos os módulos mantidos. | T005, T006, T011, T012 | - | `build.gradle` (scripts e POMs dos módulos) | 🟢 | `[X]` |
| T016 | Substituir ou remover o provider SSH/SCP deprecated após identificar o uso de publicação efetivo. | T006, T007 | - | `pom.xml` | 🟢 | `[X]` |
| T017 | Preservar coordenadas de relocation e configurar sua publicação junto ao release major. | T015 | - | `relocation/pom.xml` | 🟢 | `[X]` |
| T018 | Validar paridade, API pública, árvores de dependência e artefatos gerados pelos dois builds. | T013, T014, T015, T016, T017 | - | `_reversa_forward/001-modernize-dependencies-java17/` | 🟢 | `[X]` |

## Fase 5, Polimento

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T019 | Documentar baseline Java 17, mudanças major, dependências substituídas, relocation e adoção por consumidores Java 7. | T018 | - | `README.md` (notas de migração/release) | 🟡 | `[X]` |

## Notas de execução

- A janela e os limites numéricos de desempenho permanecem uma lacuna; comparar com o baseline e registrar resultados sem inventar SLA.
- T005, T008 e T009 indicam arquivos principais; a execução deve limitar cada ação ao conjunto relacionado do módulo descrito.
- T013 remains failed because its size and temporary-storage defaults are unresolved. T013 remains failed because its size and temporary-storage defaults are unresolved. T018 validation covers the implemented dependency/build changes; it does not validate T013.
- `mvn test -q`, `mvn package -q`, `./gradlew test`, `./gradlew assemble`, and both dependency-tree reports succeeded. They ran on JDK 27; JDK 17 runtime execution was unavailable. Maven Javadoc generation emitted nonfatal errors for legacy self-closing `<p/>` tags. T013 remains outside this completed six-action batch.

## Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-10-24 | Versão inicial gerada por `/reversa-to-do` | reversa |
