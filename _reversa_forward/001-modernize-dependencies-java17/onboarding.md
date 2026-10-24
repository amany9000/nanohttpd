# Onboarding: Modernizar dependências para Java 17

Este documento descreve a preparação para revisar a feature; não executa builds nem altera código.

## Pré-requisitos

- JDK 17 instalado e selecionado.
- Maven e Gradle disponíveis, nas versões mínimas que forem aprovadas na investigação.
- A política `.reversa/reversa-config.json` atual permite apenas artefatos Reversa. Antes de qualquer fase `/reversa-coding`, o mantenedor deve editar essa configuração e incluir os globs necessários. O Reversa não altera esse arquivo.
- Acesso às fontes oficiais upstream para verificar releases, licenças e changelogs.

## Passos de validação planejados

1. Consultar a matriz em `investigation.md` e registrar versões atuais e candidatas para todos os POMs, Gradle scripts, plugins e profiles.
2. Conferir a compatibilidade Java 17 e licença da árvore direta/transitiva de cada módulo.
3. Identificar se `wagon-ssh` ainda é necessário no perfil/site configurado.
4. Revisar os contratos Java públicos em `interfaces/java-public-api.md` antes de atualizar majors.
5. Na fase de coding, executar builds e cenários de paridade apenas conforme as ações autorizadas e a política do projeto.
6. Comparar os artefatos Maven e Gradle e revisar as notas da major release.

## Resultado esperado

A feature só poderá avançar para coding depois que o usuário atualizar a política de edição. Esta execução autônoma foi solicitada até o estágio to-do; portanto nenhum build ou teste será executado neste estágio.
