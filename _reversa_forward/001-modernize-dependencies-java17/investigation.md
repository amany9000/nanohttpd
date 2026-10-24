# Investigation: Modernizar dependências para Java 17

> Pesquisa de fontes primárias consultadas em 2026-10-24. Versões são referências de planejamento, não pins finais; rever no coding.

## Estado do legado

`_reversa_sdd/dependencies.md` registra Commons FileUpload 1.3.1, Servlet API javax 2.5, Pegdown 1.4.1, JUnit 4.12, HttpComponents 4.2.5/4.4.1, Mockito `mockito-all` 1.9.5, Jetty WebSocket Client 9.3.0.M2, JaCoCo 0.7.4 e Maven plugins antigos. A configuração Maven contém `wagon-ssh` 2.7, plugin compiler 3.3 e source/target 1.7. O projeto tem também Gradle multi-project.

## Fontes e observações

| Família | Fato observado em fonte upstream | Implicação para a feature |
|---|---|---|
| Apache Commons FileUpload | [Release notes](https://commons.apache.org/proper/commons-fileupload/changes.html) apontam 1.6.0 como release 1.x de 2025-06-05 que requer Java 8; 2.0.0-M5 é milestone de 2026-02-08 e requer Java 11. [Guia de migração](https://commons.apache.org/proper/commons-fileupload/migration.html) descreve mudanças binárias, de pacote e imports em FileUpload 2. | Com Java 17, ambas podem funcionar, mas 1.6.0 reduz risco de API. Avaliar 2.x apenas se ganhos justificarem adaptar o wrapper `NanoFileUpload`. |
| Apache HttpComponents | [Notícias oficiais](https://hc.apache.org/news.html) reportam Client 5.6.5 GA em 2026-10-12. A linha 5.7 é alpha. | Preferir GA 5.x para testes quando as APIs forem migradas; evitar alpha para a release estável. Verificar diferenças no cliente/mime usados por testes. |
| Jetty | [Downloads e suporte](https://jetty.org/download.html) listam Jetty 12.1.14 como stable/supported e Java 17 mínimo; Jetty 9.4 está EOL. | O teste WebSocket está em Jetty 9.3.0.M2; planejar atualização para Jetty 12.1, conferindo a mudança de API de cliente. |
| Mockito | [Releases upstream](https://github.com/mockito/mockito/releases) listam 5.24.0; documentação do [projeto](https://github.com/mockito/mockito) informa que Mockito 5 requer Java 11 e a distribuição corrente é `mockito-core`, não `mockito-all`. | Java 17 é compatível; migrar coordenada e conferir configurações do mock maker/agent no build de testes. |
| JUnit | [Site oficial](https://junit.org/) identifica JUnit 6 como geração atual e Java 17 como mínimo; [guia de releases](https://junit.c-cpp.com/junit5/docs/current/release-notes/index.html) mostra 6.1.1. | JUnit 6 casa com Java 17, mas converter testes JUnit 4 é trabalho de API. Avaliar JUnit Vintage como ponte versus permanecer em JUnit 4.13.x no major inicial. |
| Maven Compiler e Surefire | [Índice oficial de plugins](https://maven.apache.org/plugins/index.html) lista Compiler 3.16.0 e Surefire 3.6.0; [guia Surefire](https://maven.apache.org/surefire/surefire/) descreve suporte JUnit Platform e motores. | Atualizar plugin versions e migrar `source/target` para `release` 17 onde adequado; conferir a compatibilidade do Maven mínimo exigido. |
| JaCoCo | [Histórico oficial](https://www.jacoco.org/jacoco/trunk/doc/changes.html) lista 0.8.15 como release estável de 2026-06-04; 0.8.16 no momento está em snapshot. | Usar release estável para cobertura de Java 17; não consumir snapshot em publicação normal. |
| Flexmark / Markdown | O [repositório oficial](https://github.com/vsch/flexmark-java/blob/master/VERSION.md) lista 0.64.8 como versão do projeto e histórico de mudanças. | Flexmark é candidato para substituir Pegdown; comparar opções e saída HTML existente, especialmente extensões e sanitização. Confirmar versão publicada e licença no momento da implementação. |
| Maven Wagon SSH | [Download oficial](https://maven.apache.org/wagon/download.cgi) lista Wagon 3.5.3 como estável; [introdução do Wagon](https://maven.apache.org/wagon/) informa que providers SSH/SCP serão removidos em 4.0. | O `wagon-ssh` legado 2.7 não deve ser apenas bump cego. Ação precisa identificar seu uso no profile/site e escolher uma publicação suportada ou remover a tarefa de site com justificativa. |

## Alternativas avaliadas

1. **Bump conservador dentro das APIs atuais**: menor custo, mas mantém dependências antigas e pode não oferecer suporte Java 17 ou manutenção.
2. **Upgrade de majors com bridges/adapters**: atende o Java 17 e dependências atuais; risco de mudanças de pacote e APIs em FileUpload, HttpComponents, Jetty e JUnit.
3. **Trocar dependências abandonadas por alternativas mantidas**: particularmente Pegdown → Flexmark; exige comparação de renderização HTML e política de raw HTML.
4. **Atualizar somente Maven**: rejeitado porque Gradle é um build suportado e criaria drift.

## Padrões aplicáveis

- Centralizar e auditar versões sem retirar o suporte a Maven/Gradle.
- Usar versões GA e registrar versões pré-lançamento apenas como alternativas rejeitadas.
- Tratar mudança major de dependência como adaptação de contrato, não como atualização mecânica.
- Fazer convergência de dependências e política de Java explícitas no build.
- Manter publicação do site e coordenadas de relocation apenas se forem parte real do release.

## Perguntas de investigação para coding

- Qual versão mínima de Maven/Gradle pode ser assumida para plugins Java 17 atuais?
- O workflow de publicação do site ainda precisa de SSH/SCP? A configuração atual aponta destinos, mas não comprova que são usados.
- Quais extensões Pegdown o projeto usa e qual perfil Flexmark reproduz sua renderização?
- As APIs de Jetty 12.1 e Commons FileUpload 2 são compatíveis com a adaptação atual sem quebra externa?
- Quais dependências do POM de relocation precisam de versões distintas da release principal?
