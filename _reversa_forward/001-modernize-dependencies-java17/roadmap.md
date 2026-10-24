# Roadmap: Modernizar dependências para Java 17

> Identificador: `001-modernize-dependencies-java17`
> Data: 2026-10-24
> Requirements: `_reversa_forward/001-modernize-dependencies-java17/requirements.md`
> Confidência: 🟢 CONFIRMADO, 🟡 INFERIDO, 🔴 LACUNA

## 1. Resumo da abordagem

Atualizar o release coordenado do NanoHTTPD para Java 17, mantendo a topologia de módulos legada e os contratos públicos sempre que possível. Inventariar dependências de runtime, teste, build e publicação; avaliar versão estável, suporte Java, licença, manutenção e impacto de API para cada item. Atualizar Maven e Gradle para expressarem a mesma política e a mesma seleção de versões. Substituir componentes abandonados ou incompatíveis somente com adaptação explícita e paridade preservada. A publicação é uma major release; coordenadas antigas permanecem durante a janela aprovada.

## 2. Princípios aplicados

`.reversa/principles.md` não existe; nenhum princípio local adicional está configurado.

| Princípio | Como a feature se relaciona | Status |
|-----------|------------------------------|--------|
| Preservar contratos públicos | Atualizações não removem APIs sem justificar e documentar a quebra major. | respeita |
| Manter builds suportados | Maven e Gradle continuam ativos e comparáveis. | respeita |
| Segurança e dependências confiáveis | Preferir releases estáveis suportados; evitar snapshots/milestones em produção. | respeita |

## 3. Decisões técnicas

| ID | Decisão | Justificativa | Alternativas descartadas | Confidência |
|----|---------|----------------|--------------------------|-------------|
| D-01 | Java 17 é a baseline mínima do release. | Decisão explícita do mantenedor em `_reversa_sdd/migration/migration_brief.md#Constraints`. | Continuar emitindo bytecode Java 7 como baseline. | 🟢 |
| D-02 | Preferir releases GA estáveis mais recentes compatíveis com Java 17; não selecionar milestone/snapshot quando existir GA adequada. | O objetivo pede versões atuais “razoavelmente possíveis”; upstreams distinguem releases GA e pré-lançamentos. | Usar sempre o número maior, mesmo sendo milestone ou exigindo quebra não justificada. | 🟡 |
| D-03 | Manter os módulos e coordenadas atuais durante esta mudança, exceto major version e relocation definida. | Topologia preservada pelo mantenedor em `_reversa_sdd/migration/topology_decision.md#User decision`. | Reorganizar ou renomear módulos. | 🟢 |
| D-04 | Alinhar versões e escopos entre Maven e Gradle; registrar exceções quando a estrutura dos builds impedir igualdade literal. | Dois builds estão em uso no legado; divergências já foram identificadas. | Atualizar somente `pom.xml` ou somente Gradle. | 🟢 |
| D-05 | Tratar FileUpload 1.x→2.x e HttpComponents 4→5 como migrações de API, não como simples bumps. | Documentação upstream identifica mudanças de pacotes/API; impacto no wrapper e testes deve ser medido. | Trocar majors sem adaptação nem parity. | 🟢 |
| D-06 | Remover ou substituir o caminho de publicação SSH/SCP baseado em `wagon-ssh` se o plugin for deprecated/sem suporte; manter funcionalidade de publicação documentada. | O POM legado inclui `wagon-ssh` e o upstream marca o provider como deprecated para remoção em Wagon 4. | Apenas aumentar versão e ignorar a depreciação. | 🟢 |
| D-07 | Usar paridade funcional e compatibilidade de API como gates; performance não terá SLA numérico inventado. | A dúvida de desempenho não recebeu alvo quantitativo. | Definir uma porcentagem de regressão sem evidência do mantenedor. | 🟡 |
| D-08 | Atualizar Gradle Wrapper e DSL para uma linha suportada em Java 17; retirar JCenter e configurações `compile`/`testCompile` obsoletas. | Inspeção dos arquivos Gradle mostra Wrapper 4.4.1, JCenter e configurações antigas. | Manter Gradle 4.4.1 ou atualizar apenas dependências Maven. | 🟢 |

## 4. Premissas

| Premissa | Origem (`requirements.md` seção) | Risco se errada |
|----------|----------------------------------|-----------------|
| Sem meta quantitativa fornecida, a release candidate deve passar 100% dos cenários de paridade confirmados e registrar comparação de desempenho contra o baseline, sem uma tolerância numérica pré-fixada. | Seção 10, lacuna de desempenho | Uma regressão pequena, mas importante para consumidores específicos, pode passar sem um SLA acordado. |
| Onde existir versão Java 17 compatível estável, uma versão mais nova não estável não será considerada “razoável” para a release major. | RN-02 | Pode deixar de fora recurso de segurança/compatibilidade disponível apenas em pré-lançamento; requer justificativa explícita se necessário. |

## 5. Delta arquitetural

| Componente | Arquivo de origem no legado | Tipo de mudança | Resumo |
|------------|------------------------------|-----------------|--------|
| Build Maven | `_reversa_sdd/dependencies.md#Build systems` | regra-alterada | Java 17 e versões atuais dos plugins/dependências; convergência verificada. |
| Build Gradle | `_reversa_sdd/dependencies.md#Build systems` | regra-alterada | Atualizar Wrapper/DSL, retirar JCenter e configurações obsoletas, alinhar baseline e versões. |
| `core` | `_reversa_sdd/architecture.md#Runtime architecture` | regra-alterada | Sem dependência runtime adicional; atualizar ferramentas de teste e plugins de compilação/cobertura. |
| `websocket` | `_reversa_sdd/architecture.md#Runtime architecture` | regra-alterada | Atualizar cliente Jetty/Mockito de teste e manter comportamento do protocolo. |
| `fileupload` | `_reversa_sdd/architecture.md#Runtime architecture` | contrato-alterado | Atualizar FileUpload; manter adaptador de sessão ou adicionar bridge se a API major mudar. |
| `markdown-plugin` | `_reversa_sdd/architecture.md#Runtime architecture` | componente-alterado | Substituir Pegdown por renderer mantido, preservando plugin e saída HTML aprovada. |
| `webserver`, `nanolets`, `samples`, `relocation` | `_reversa_sdd/inventory.md#Repository structure` | regra-alterada | Atualizar builds/transitivos necessários e manter módulo/artefatos durante release. |

## 6. Delta no modelo de dados

- Resumo das mudanças: Não há banco nem dados de negócio. Atualizações alteram metadados de build, grafo de dependências e, se necessário, o armazenamento temporário do FileUpload.
- Detalhe completo em: `_reversa_forward/001-modernize-dependencies-java17/data-delta.md`

## 7. Delta de contratos externos

| Contrato | Tipo | Arquivo de detalhe |
|----------|------|--------------------|
| API pública Java e artefatos Maven/Gradle | Biblioteca / binário | `_reversa_forward/001-modernize-dependencies-java17/interfaces/java-public-api.md` |

## 8. Plano de migração

1. Inventariar as versões efetivas em todos os POMs e Gradle scripts, incluindo plugins, profiles, relocation POMs e transitivos relevantes.
2. Criar matriz por coordenada com versão atual, versão candidata, requisito Java, licença, manutenção, mudança de API, módulo e decisão.
3. Atualizar Maven e Gradle para compilar/executar com Java 17; retirar JCenter e configurações Gradle removidas; habilitar validação de versões, dependency convergence e impressão dos grafos resolvidos.
4. Atualizar dependências de teste e build; migrar APIs quando majors forem necessários. Atualizar Commons FileUpload e renderer Markdown com atenção às mudanças de API.
5. Substituir o provider SSH/SCP deprecated por fluxo de publicação suportado, ou documentar sua remoção se a publicação do site não fizer mais parte da entrega.
6. Atualizar dependências runtime dos módulos; manter Maven/Gradle e módulos consistentes.
7. Executar os cenários em `parity_specs.md`, comparar APIs públicas e artefatos dos dois builds; esta etapa fica para a execução de coding.
8. Publicar candidate coordenado, verificar relocation e notas de migração, resolver divergências antes de liberar a major version.

## 9. Riscos e mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|-------|---------|---------------|-----------|
| Java 17 exclui usuários ainda presos ao bytecode Java 7 | alto | médio | Publicar a baseline e considerar uma branch legada apenas se houver demanda confirmada. |
| FileUpload 2.x e HttpComponents 5 alteram APIs e pacotes | alto | alto | Medir impacto por módulo, manter wrappers e migrar por contrato/paridade. |
| Maven e Gradle divergem em versões/escopos | alto | médio | Comparar árvores efetivas e artefatos produzidos por ambos. |
| `wagon-ssh` está deprecated para remoção em Wagon 4 | médio | alto | Identificar uso real em site/release; escolher mecanismo suportado antes de atualizar plugin. |
| Dependências antigas são vulneráveis ou não têm suporte | alto | médio | Avaliar advisories, releases, licenças e transitivos antes da seleção final. |

## 10. Critério de pronto

- [ ] Java 17 configurado e documentado como mínimo em todos os módulos.
- [ ] Matriz de dependências registra decisões de update/replace/remove e versões compatíveis estáveis.
- [ ] Maven e Gradle resolvem módulos/escopos coerentes e produzem os artefatos previstos.
- [ ] API pública e cenários de paridade passam, exceto mudanças deliberadas listadas nas exceções.
- [ ] Publicação SSH/site e relocation têm decisão suportada e documentada.
- [ ] Guia major version informa mudanças para consumidores Java 7 e migração das APIs.

## 11. Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-10-24 | Versão inicial gerada por `/reversa-plan`; uma dúvida mantida como premissa. | reversa |
