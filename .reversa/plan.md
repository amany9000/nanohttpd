# Exploration Plan: nanohttpd

> Created by Reversa on 2026-10-24
> Mark each task with ✅ when done.
> You can edit this plan before starting: add, remove or reorder tasks as needed.

---

## Phase 1: Reconnaissance 🔍

- [x] **Scout**: Folder structure and technology mapping
- [x] **Scout**: Dependency and package manager analysis
- [x] **Scout**: Entry points, CI/CD and configuration

## Specs organization decision 🗂️

> Between the Scout and the Archaeologist, Reversa asks how you want to organize the specs (by module, use case, endpoint, hybrid, by features or custom). The choice is persisted in `.reversa/config.toml` under the `[specs]` section and is not asked again in future runs. To show the menu again, remove the section manually.

## Phase 2: Excavation 🏗️

> Reversa fills this section with the real modules once the Scout finishes reconnaissance.

- [x] **Archaeologist**: Analysis of module `core`
- [x] **Archaeologist**: Analysis of module `websocket`
- [x] **Archaeologist**: Analysis of module `webserver`
- [x] **Archaeologist**: Analysis of module `nanolets`
- [x] **Archaeologist**: Analysis of module `fileupload`
- [x] **Archaeologist**: Analysis of module `markdown-plugin`
- [x] **Archaeologist**: Analysis of module `samples`
- [x] **Archaeologist**: Analysis of the `relocation` packaging tree

## Phase 3: Interpretation 🧠

- [x] **Detective**: Git archaeology and retroactive ADRs
- [x] **Detective**: Implicit business rules and state machines
- [x] **Detective**: Permission matrix (RBAC/ACL)
- [x] **Architect**: C4 diagrams (Context, Containers, Components)
- [x] **Architect**: Full ERD and external integrations
- [x] **Architect**: Spec Impact Matrix

## Phase 4: Generation 📝

- [x] **Writer**: SDD specs per component
- [x] **Writer**: OpenAPI (not applicable; routes belong to embedding applications)
- [x] **Writer**: User Stories (not applicable to this infrastructure library)
- [x] **Writer**: Code/Spec Matrix

## Phase 5: Review ✅

- [x] **Reviewer**: Cross-review of specs
- [x] **Reviewer**: Gap disposition confirmed; 13 questions retained as open gaps in `_reversa_sdd/questions.md`
- [x] **Reviewer**: Final confidence report

---

## Independent Agents

> Run these agents when the resources are available; they can run in any phase.

- [ ] **Visor**: Interface analysis from screenshots
- [ ] **Data Master**: Full database analysis
- [ ] **Design System**: Design token extraction
- [ ] **Tracer**: Dynamic analysis (requires an accessible system)

---

## Next step

Once the Discovery Team finishes and `_reversa_sdd/` is populated, you can trigger one of the following flows:

- `/reversa-migrate`: orchestrator of the **Migration Team** (Paradigm Advisor → Curator → Strategist → Designer → Screen Translator → Inspector). Generates the specs of the new system. Output in `_reversa_sdd/migration/` and `_reversa_sdd/screens/`.
- `/reversa-reconstructor`: generates a bottom-up plan to reimplement the software from the legacy specs (one task per session).
