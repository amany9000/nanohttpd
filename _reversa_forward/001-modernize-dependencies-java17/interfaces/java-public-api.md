# Contrato: API pública Java e artefatos

## Consumidor

Aplicações Java que dependem dos módulos `org.nanohttpd` via Maven ou Gradle; consumidores antigos podem usar coordenadas relocadas `com.nanohttpd`.

## Contratos afetados

- Baseline mínima de runtime/bytecode: Java 17 no novo major.
- Módulos/artefatos: `core`, `websocket`, `webserver`, `nanolets`, `fileupload`, `markdown-plugin`, `samples` e `relocation`, preservando limites/namespaces acordados.
- API pública: interfaces e tipos exportados permanecem compatíveis quando possível; alterações exigidas por major dependencies devem ser envolvidas por adapters ou declaradas como mudanças do major release.
- Builds: Maven e Gradle permanecem suportados.
- Relocation: coordenadas antigas continuam apontando aos novos artefatos por ao menos um ciclo major anunciado.

## Mudanças intencionais e erros

Atualizações de dependência não devem alterar comportamento de protocolo. Mudanças de segurança aprovadas na `parity_specs.md#Approved target exceptions` são intencionais e precisam ser descritas nas notas de migração. Falhas de resolução/build devem identificar módulo e coordenada, sem publicar artefatos parciais.

## Compatibilidade e versionamento

- Publicar como versão major por causa da baseline Java17 e possíveis APIs de dependências.
- Não mudar package names nem remover coordenadas sem mapear replacement e relocation.
- Documentar a permanência na última versão compatível com Java7; eventual branch de suporte depende de demanda do mantenedor.
- Antes de release, comparar API pública, dependency graphs e artefatos produzidos por Maven/Gradle.

## Rastreabilidade

- `_reversa_sdd/migration/handoff.md#Next steps for the coding agent`
- `_reversa_sdd/migration/parity_specs.md#Acceptance criteria for parity`
- `_reversa_sdd/migration/topology_decision.md#User decision`
