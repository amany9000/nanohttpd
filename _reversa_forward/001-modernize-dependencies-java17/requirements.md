# Requirements: Modernizar dependências para Java 17

> Identificador: `001-modernize-dependencies-java17`
> Data: 2026-10-24
> Pasta da extração reversa: `_reversa_sdd/`
> Confidência: 🟢 CONFIRMADO, 🟡 INFERIDO, 🔴 LACUNA / DÚVIDA

## 1. Resumo executivo

A entrega atualiza dependências, plugins de build e configuração dos módulos NanoHTTPD para uma linha de suporte Java 17. Mantém o projeto como biblioteca Java leve, o desenho dos módulos e as APIs públicas sempre que possível. Maven e Gradle continuam suportados e devem produzir resultados coerentes. A publicação é coordenada em uma versão major, com compatibilidade e comportamento avaliados antes do release estável.

## 2. Contexto a partir do legado

| Fonte | Trecho relevante | Confidência |
|-------|------------------|-------------|
| `_reversa_sdd/migration/migration_brief.md#Migration goal` | O mantenedor pediu para atualizar dependências para versões tão atuais quanto razoavelmente possível e delegou o restante do julgamento. | 🟢 |
| `_reversa_sdd/migration/migration_brief.md#Constraints` | Java 17 foi confirmado como mínimo para a migração; o snapshot legado usava Java 7 e há risco para consumidores existentes. | 🟢 |
| `_reversa_sdd/migration/handoff.md#Next steps for the coding agent` | Requer seleção de versões compatíveis com Java 17, alinhamento Maven/Gradle, preservação dos módulos e release major coordenado. | 🟢 |
| `_reversa_sdd/dependencies.md#Build systems` | O projeto mantém Maven e Gradle; o snapshot configura Java 7 e plugins antigos. | 🟢 |
| `_reversa_sdd/dependencies.md#Product dependencies` | Commons FileUpload 1.3.1, servlet-api 2.5 e Pegdown 1.4.1 aparecem como dependências de produto; módulos internos dependem de core. | 🟢 |
| `_reversa_sdd/dependencies.md#Test dependencies` | JUnit e clientes HTTP/WebSocket de teste têm versões antigas e algumas divergências por módulo. | 🟢 |
| `_reversa_sdd/architecture.md#Runtime architecture` | Core, WebSocket, Webserver, Nanolets, FileUpload, Markdown, Samples e Relocation têm limites descritos; as extensões são opcionais. | 🟢 |
| `_reversa_sdd/migration/parity_specs.md#Approved target exceptions` | O mantenedor aprovou políticas de limites finitos configuráveis, contenção de caminhos, escaping/sanitização e segurança de armazenamento. | 🟢 |

## 3. Personas e cenários de uso

| Persona | Objetivo | Cenário-chave |
|---------|----------|---------------|
| Mantenedor da biblioteca | Atualizar dependências sem perder suporte aos módulos ou builds publicados | Planeja um release major para Java 17 e precisa saber quais dependências podem ser atualizadas, substituídas ou removidas. |
| Consumidor Java downstream | Adotar o release com comportamento e requisitos de runtime conhecidos | Resolve artefatos Maven/Gradle e valida sua aplicação contra a compatibilidade Java 17 e as notas de migração. |
| Responsável por release/build | Produzir artefatos coerentes nos dois sistemas de build | Confere versões, licenças, dependências transitivas e coordenadas de relocation antes da publicação. |

## 4. Regras de negócio novas ou alteradas

1. **RN-01:** A linha-alvo compila e executa com Java 17 como versão mínima. 🟢
   - Origem no legado: `_reversa_sdd/migration/migration_brief.md#Constraints`
   - Tipo: alterada
2. **RN-02:** Dependências diretas, transitivas e plugins devem usar versões estáveis atuais que sejam compatíveis com Java 17, licenças aceitáveis e APIs públicas preservadas; exceções precisam de justificativa registrada. 🟢
   - Origem no legado: `_reversa_sdd/migration/migration_brief.md#Migration goal`
   - Tipo: nova
3. **RN-03:** Maven e Gradle permanecem suportados, com módulos, escopos e versões resolvidas coerentes. 🟢
   - Origem no legado: `_reversa_sdd/dependencies.md#Build systems`
   - Tipo: alterada
4. **RN-04:** O release é coordenado como uma versão major; a topologia e os nomes dos módulos legados são preservados. 🟢
   - Origem no legado: `_reversa_sdd/migration/migration_strategy.md#Decision for the user` e `_reversa_sdd/migration/topology_decision.md#User decision`
   - Tipo: alterada
5. **RN-05:** As regras confirmadas de protocolo e APIs públicas permanecem equivalentes, salvo exceções de segurança aprovadas e registradas. 🟢
   - Origem no legado: `_reversa_sdd/migration/target_business_rules.md#MIGRATE rules`
   - Tipo: alterada
6. **RN-06:** Artefatos e coordenadas `com.nanohttpd` continuam redirecionando para os artefatos `org.nanohttpd` por ao menos um ciclo major anunciado; a data final de sunset deve ser publicada. 🟢
   - Origem no legado: `_reversa_sdd/migration/target_business_rules.md#BR-HUMAN-012`
   - Tipo: alterada
7. **RN-07:** O build Gradle deve executar em Java 17 e usar repositórios/configurações de dependência suportados pela versão escolhida. 🟡
   - Origem no legado: `_reversa_sdd/dependencies.md#Build systems` e análise da configuração Gradle legada
   - Tipo: alterada

## 5. Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de aceite | Confidência |
|----|-----------|------------|--------------------|-------------|
| RF-01 | A linha alvo deve declarar Java 17 como versão mínima em todos os módulos e builds. | Must | Todos os módulos e descritores declaram a baseline acordada e não dependem de APIs indisponíveis nessa baseline. | 🟢 |
| RF-02 | Cada dependência e plugin direto ou transitivo deve ser atualizado para a versão estável mais recente compatível com Java 17, ou manter uma exceção justificada. | Must | Uma matriz de dependências registra versão atual/alvo, compatibilidade, licença, suporte e decisão de atualização/substituição/remoção. | 🟢 |
| RF-03 | Maven e Gradle devem continuar construindo e publicando os mesmos módulos e escopos funcionais. | Must | Resolução e artefatos dos dois builds são comparados; divergências são corrigidas ou justificadas. | 🟢 |
| RF-04 | O release deve preservar os limites atuais de módulo e a superfície pública, exceto mudanças major justificadas. | Must | Comparação de API e matriz de paridade não apresentam diferenças sem justificativa nas exceções aprovadas. | 🟢 |
| RF-05 | Dependências incompatíveis, sem manutenção, com licença inadequada ou sem suporte Java 17 devem ser substituídas ou removidas sem eliminar a capacidade correspondente. | Must | Cada caso tem decisão rastreável e a capacidade do módulo continua coberta pelos contratos de paridade aplicáveis. | 🟡 |
| RF-06 | Políticas de segurança aprovadas devem ser materializadas: limites configuráveis, contenção canônica de arquivos, escaping/sanitização, validação WebSocket e limpeza segura de uploads/temporários. | Must | Cada política possui configuração, comportamento de erro e cenários de paridade/segurança documentados. | 🟢 |
| RF-07 | Relocation e compatibilidade de coordenadas devem ser publicados junto ao release coordenado. | Should | Artefatos antigos resolvem para os correspondentes `org.nanohttpd` e a janela de suporte é informada. | 🟢 |
| RF-08 | O release deve oferecer uma trilha de adoção para consumidores Java 7 e Java 17. | Should | Notas de release documentam baseline, mudanças incompatíveis, dependências substituídas e alternativas de permanência na versão antiga. | 🟡 |
| RF-09 | O Gradle Wrapper/configuração deve ser atualizado para executar com Java 17, retirar repositórios encerrados e configurações de dependências removidas. | Must | Build Gradle funciona com Java 17 e todas as dependências resolvem por repositório ativo, sem configurações removidas. | 🟡 |

## 6. Requisitos Não Funcionais

| Tipo | Requisito | Evidência ou justificativa | Confidência |
|------|-----------|----------------------------|-------------|
| Compatibilidade | Manter o desenho framework-neutral e os módulos atuais. | `_reversa_sdd/migration/topology_decision.md#User decision` | 🟢 |
| Segurança | Aplicar limites de recursos finitos configuráveis, contenção de caminhos e regras de sanitização aprovadas. | `_reversa_sdd/migration/parity_specs.md#Approved target exceptions` | 🟢 |
| Build/release | Maven e Gradle devem produzir artefatos equivalentes para a release major coordenada. | `_reversa_sdd/migration/cutover_plan.md#Go / no-go criteria` | 🟢 |
| Manutenibilidade | Registrar versões, licenças, suporte upstream e decisões de substituição. | `_reversa_sdd/migration/risk_register.md#RISK-004` | 🟢 |
| Desempenho | Atualizações não devem introduzir regressão material nos fluxos críticos; os alvos numéricos serão definidos antes do release candidate. | `_reversa_sdd/migration/parity_specs.md#Validation types` | 🟡 |
| Observabilidade | N/A para telemetria de runtime; falhas de dependência/build devem ser visíveis no processo de release. | A biblioteca não é um serviço implantado. | 🟡 |

## 7. Critérios de Aceitação

```gherkin
Feature: Dependências e builds coerentes para Java 17

  Scenario: Módulos suportam a baseline Java 17
    Given os módulos do release major estão configurados
    When Maven e Gradle resolvem e constroem os módulos
    Then todos os artefatos declaram Java 17 como mínimo
    And os builds não dependem de APIs incompatíveis com Java 17

  Scenario: Atualização de dependência preserva contratos
    Given uma dependência foi atualizada ou substituída
    When os cenários de paridade e contratos públicos são avaliados
    Then os comportamentos confirmados permanecem equivalentes
    And qualquer mudança aprovada aparece nas exceções e notas de release

  Scenario: Os dois sistemas de build produzem os módulos acordados
    Given as configurações Maven e Gradle descrevem o release
    When cada build resolve as dependências e empacota os módulos
    Then os módulos, escopos e versões efetivas são coerentes
    And toda diferença restante possui justificativa documentada

  Scenario: Build Gradle resolve dependências em Java 17
    Given o Gradle Wrapper está na versão suportada definida para o release
    When o build é executado em JDK 17
    Then as dependências são resolvidas por repositórios ativos
    And nenhum configuration removido é usado

  Scenario: Coordenadas legadas continuam resolvendo durante a janela aprovada
    Given um consumidor referencia uma coordenada Maven antiga
    When o repositório resolve o artefato de relocation
    Then a coordenada aponta para o artefato org.nanohttpd correspondente
    And as notas de release informam a janela de suporte
```

## 8. Prioridade MoSCoW

| Item | MoSCoW | Justificativa |
|------|--------|---------------|
| RF-01 Baseline Java 17 | Must | Decisão explícita do mantenedor para o release alvo. |
| RF-02 Atualizar/inventariar dependências | Must | Objetivo principal da feature. |
| RF-03 Coerência Maven/Gradle | Must | Dois builds são suportados pelo projeto. |
| RF-04 Preservar APIs e topologia | Must | Escolhas aprovadas pelo mantenedor e risco de consumidores downstream. |
| RF-05 Substituir dependências sem suporte | Must | Necessário para manter a linha Java 17 atualizável. |
| RF-06 Aplicar políticas aprovadas | Must | Regras de segurança fazem parte do handoff aceito. |
| RF-07 Manter relocation | Should | Preserva consumidores durante transição major. |
| RF-08 Guia de adoção | Should | Reduz surpresa para consumidores Java 7 existentes. |
| RF-09 Gradle suportado em Java 17 | Must | A configuração legada usa Wrapper antigo e precisa acompanhar a baseline. |

## 9. Esclarecimentos

> Nenhuma sessão de dúvidas registrada ainda. Dúvidas serão mantidas como premissas no roadmap conforme o modo autônomo escolhido.

## 10. Lacunas

- 🔴 [DÚVIDA] A janela de observação e os limites numéricos de desempenho para o release candidate não foram fornecidos; o roadmap adotará validação de paridade funcional completa e comparação de desempenho sem inventar um SLA.

## 11. Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-10-24 | Versão inicial gerada por `/reversa-requirements` em execução autônoma | reversa |
| 2026-10-24 | Incluído suporte do Gradle Wrapper a Java 17 e repositórios ativos após inspeção do build | reversa |
