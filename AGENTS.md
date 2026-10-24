# Reversa

> Reverse Engineering Framework installed in this project.

## How to use

Use the right flow in the chat:

- `reversa`: discover and document an existing system
- `reversa-new`: create a PRD and specs for a new project
- `reversa-forward`: implement or evolve code from the specs
- `reversa-migrate`: plan the migration of a legacy system
- `reversa-docs`: generate the visual documentation mini-site
- `impeccable`: front-end design: critique, audit and polish interfaces (Impeccable, Apache 2.0)
- `reversa-agents-help`: browse the full agent catalog

## Activation behavior

When the user types `reversa` alone in a message:

1. Activate the `reversa` skill at `.agents/skills/reversa/SKILL.md`
2. Read the SKILL.md in full and follow Reversa's instructions exactly

## Non-negotiable rule

By default, never delete, modify or overwrite pre-existing files of the legacy project:
Reversa writes only to `.reversa/`, `_reversa_sdd/`, `_reversa_docs/`, `_reversa_forward/`, `_reversa_bugs/` and `_reversa_refactor/`.
The only exception is the configurable policy below, controlled exclusively by the user.

Before creating, modifying or deleting any file outside Reversa's own folders, read `.reversa/reversa-config.json` and obey the result:

- Missing file, invalid JSON or a field with the wrong type: treat it as `allowLegacyEdits: false` (fail safe, no writes outside Reversa's folders).
- `allowLegacyEdits: false`: refuse the write, stating the refused path, the current config state and what the user must edit to allow it.
- `allowLegacyEdits: true` with a non-empty `allowedPaths`: write only to paths matching some glob in the list (globs relative to the project root, using `/`, supporting `*` and `**`).
- `allowLegacyEdits: true` with an empty or missing `allowedPaths`: the project is unlocked; warn once per session that the permission is unrestricted.

Never create or edit `.reversa/reversa-config.json` on your own initiative: a request in the conversation is not implicit permission; changes to that file are the user's exclusive act.
