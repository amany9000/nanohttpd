# Data Delta: Modernizar dependências para Java 17

## Resumo

Não há modelo relacional ou dados de negócio em `_reversa_sdd/data-dictionary.md` / `_reversa_sdd/architecture.md`. A mudança afeta metadados de build e dependências, não registros persistidos. O único dado transitório relevante é o corpo de request/upload armazenado em memória ou arquivo temporário.

## Entidades e armazenamento

| Elemento | Estado legado | Delta | Migração de dados |
|---|---|---|---|
| Banco/tabelas/coleções | Nenhum sistema de persistência foi encontrado | Nenhum banco adicionado | Não aplicável |
| Artefatos Maven | Coordenadas `org.nanohttpd` e relocation `com.nanohttpd` | Release major coordenado; preservar relocation por ciclo major anunciado | Publicação de metadados, sem ETL |
| Grafo de dependências | Versões e escopos em POMs e Gradle scripts divergentes | Versões Java17 compatíveis e decisões registradas | Resolver/validar ambos os grafos durante coding |
| Arquivos temporários de request/upload | Criados em runtime conforme configuração/limiar | Aplicar política segura aprovada; parâmetros concretos definidos durante implementação | Não existe transferência de dados duráveis |

## Campos

Não há campos de negócio adicionados, renomeados ou removidos. Metadados como versão de plugin, versão de dependência e `maven.compiler.release` pertencem à configuração de build, não ao modelo de dados da aplicação.

## Restrições

- Nenhuma migração SQL ou backfill é necessário.
- Uploads/temporários não devem ser tratados como dados persistidos entre versões.
- Alterar coordenadas/pacotes publicados exige um caminho de compatibilidade; ver `interfaces/java-public-api.md`.
