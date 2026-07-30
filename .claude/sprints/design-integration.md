# Sprint: design-integration

**Status:** one-shot · started 2026-07-30 · 5/6 steps — built + machine-verified (aa980ee); human checkpoint open
**Next up:** Stephen plays with it (any project: "make X feel calmer", ask for an asset); the real field test + seeding Jumbo's `.claude/design.md` happen in the Jumbo migration session.

## Goal
Design craft integrated into the vibeflow pack as a reference layer (not a sixth skill): generic design references at the pack root, per-project design state in `.claude/design.md`, and small wiring edits so design fires at four moments in the existing loop — with Stephen's personal tooling (Flora/Weavy) stripped to generic craft.

## Context
Stephen's beef: vibeflow rarely brings design into the work, and as a non-designer he lacks the vocabulary to direct visual work well. He built a barebones design system with Opus 5 (`~/Downloads/design system/` — 5 files) whose core move — translate evaluative words ("calm") into observable ones ("low contrast, 300ms+ transitions, large radius") — is exactly the prosthetic he needs. But nothing in it compounds yet (empty prompt log, no per-project home for design decisions), and it isn't connected to the vibeflow loop. He explicitly does NOT want a sixth skill — design should load only after intent, matching vibeflow's tuning heuristic (nothing slow before the user has expressed intent).

## Approach
Three layers, matching vibeflow's own architecture (pack = craft, `.claude/` = project state, wrap = the compounding habit):

1. **Pack-root `design/` reference dir** — adapted from the Downloads folder. No SKILL.md frontmatter, so `setup:14` (which only symlinks dirs containing SKILL.md) skips it automatically; it's reachable at `~/.claude/skills/vibeflow/design/` the same way CORE.md is.
2. **Per-project `.claude/design.md`** (new template) — feel parameters, copy register, style templates, prompt log. Created lazily on first design work, NOT by bootstrap (not every project is visual).
3. **Wiring at four moments** (line-level edits, not rewrites): sprint planning (/start), UI build steps (/build), ad-hoc asset asks (CORE routing line), and harvest (/wrap).

The design-partner stance is the inversion that matters: **never require design vocabulary from the user — ask for feelings/references, translate to observables yourself, play them back for a yes/no.**

## Ground truth
- `setup:13-14` — installer loops `"$SRC"/*/` and requires `[ -f "$dir/SKILL.md" ]`; a design/ dir without SKILL.md is never symlinked as a skill.
- `CORE.md:45-56` — Shared `.claude/` state tree listing; `design.md` gets added here. `CORE.md:37-43` Communication section is where the partner stance fits.
- `start/SKILL.md` §1 Gather — "For user-facing work, walk the experience before any tech" bullet is the planning hook point.
- `start/references/sprint-md-shape.md:39-53` — Plan section; Design block goes as a new optional section above Plan.
- `build/SKILL.md:31-39` — Guardrails list; the UI-states + translate-feedback guardrail joins it. `build/SKILL.md:16` Freebuild entry loads context on demand.
- `wrap/SKILL.md:30-40` — Harvest routing table; design rows join it.
- Source files (all read in full): `~/Downloads/design system/{SKILL,ui-design,vocabulary,image-prompting,prompt-log}.md`. Personal tooling to strip: "Node canvas patterns (Flora, Weavy)" section (`image-prompting.md:110-137`), named tools in headers (`image-prompting.md:3`, SKILL.md frontmatter/description). Keep: generate/edit-lock/style-extraction templates, reference-image guidance, debugging table, phrases-that-work/fail lists (fold from prompt-log.md), vocabulary tables, ui-design content.
- `ui-design.md:5` references the harness's public `frontend-design` skill as the aesthetic layer above it — keep that pointer; they compose.

## Plan
- [x] [PORT] Create `design/` at the pack root from the Downloads folder — `README.md` (from its SKILL.md: strip frontmatter + tool names; keeps the two-lanes table, the three-things rule, anti-patterns; add the design-partner stance line), `vocabulary.md` (near-verbatim), `ui-design.md` (verbatim except: genericize the "Havio / Jumbo" worked-example header to "a health app whose users have brain fog" — keeps the teaching value, drops the project name), `image-prompting.md` (strip the Flora/Weavy node-canvas section and named tools/models → "your image tool"; fold prompt-log.md's generic phrases-that-work/fail lists in as a starter section). Original Downloads folder left untouched.
- [x] [NEW] `templates/design.md` — per-project design state: Feel parameters (the 5-param table row), Copy register, Style templates (extracted, with holds-up-for/breaks-on), Prompt log (4-line entry format), each section with a one-line comment on what belongs there. Header note: created on first design work; genuine design forks with alternatives still go to DECISIONS.
- [x] [NEW] Wire CORE.md: add `design.md` to the state tree at CORE.md:50-55 with a one-line comment; add a ~4-line **Design** subsection: the partner stance (translate, never require vocabulary, play back observables) + the routing line — visual work of any kind (UI planning/building, asset/image asks, "make it feel X" feedback) reads `design/README.md` + the project's `.claude/design.md`, creating the latter from `templates/design.md` on first use.
- [x] [NEW] Wire the three skills: **start** — the "walk the experience" bullet gains: for user-facing sprints read `design/ui-design.md` (five questions, four levels) + project design.md, and lock the design decisions into the sprint's Design block; **sprint-md-shape.md** — new optional `## Design` section (screen's job, primary action, worst state, feel parameters; omit for non-visual sprints); **build** — one guardrail: a UI step includes its states (empty/loading/error) as part of the step, not deferred polish; translate evaluative feedback via `design/vocabulary.md` and play back observables before coding; **wrap** — harvest table rows: prompt/style that worked → project design.md; transferable design-vocabulary lesson → global playbook.
- [x] → CHECKPOINT (machine): every path referenced in the new/edited lines resolves (`ls`/grep pass); no dir gained a SKILL.md that would make the installer link it.
- [ ] → CHECKPOINT (human): Stephen reads the wiring diff (CORE + three skills + template) — pack governance rule: he understands every line that governs him. Field verification happens later, on the next Jumbo session.

## Reuse as-is (read, do not modify)
- `setup` / `update` — no installer changes needed.
- `hooks/session-start.sh` — orientation stays design-free; design loads after intent by design.

## Out of scope
- Bootstrap creating design.md (lazy creation instead) and any hook changes.
- Seeding Jumbo's actual `.claude/design.md` (its own session, during the Jumbo migration).
- A screenshot→critique visual-review loop for /build checkpoints (roadmap candidate, not now).
- Pushing v3 to GitHub (separate roadmap item).

## Key decisions
- Reference layer, not a sixth skill — design loads only in service of expressed intent; the installer's SKILL.md gate makes this structural, not conventional. (Stephen's call, 2026-07-30.)
- Per-project design state; craft stays generic in the pack — Jumbo's calm register and the legal platform's precise register can't share one file.
- Strip personal tooling (Flora/Weavy/named models), keep tool-agnostic craft incl. style extraction. (Stephen's call.)
- Keep the worked example in ui-design.md, genericized — it teaches constraint→decision better than any rule; the project-specific version belongs in Jumbo's future design.md.

## Done criteria
- `design/` exists with 4 files, no SKILL.md; `bash setup` dry-logic confirms it isn't linked.
- `templates/design.md` exists and matches other templates' tone.
- CORE + start + sprint-shape + build + wrap each carry their wiring lines; total added prose across the five ≤ ~15 lines (this is a light touch, not a rewrite).
- Stephen has read and approved the wiring diff.
