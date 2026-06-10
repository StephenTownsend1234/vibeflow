# Migrating an existing project into v2 structure

When a project already has docs in an older shape — a single accreted ARCHITECTURE doc (current state + changelog + decisions + debt all in one), or pre-v2 vibeflow files — **don't overwrite, and don't ingest the blob whole.** Split and reshape it into the v2 file structure. This reorganizes `.claude/` markdown only — it never touches application code, the database, or migrations. Lose nothing; collaborate with the user and confirm each file.

## When this triggers
- An existing `.claude/` whose files predate the v2 shapes (no Map-on-top ARCHITECTURE, no PLAYBOOK, decisions/debt living inside ARCHITECTURE).
- A monolithic architecture doc (in `.claude/` or elsewhere) mixing current state, history, decisions, and open items.
- A **partially-migrated** project: `DECISIONS.md` / `ROADMAP.md` already exist but in the old format, and decisions or debt are *also* duplicated inside ARCHITECTURE. Here the job is reshape + merge + dedupe across sources, not just route.

Offer it plainly:

> "Your docs are in the older single-doc shape. Want me to migrate to the v2 structure — split into a tight current-state ARCHITECTURE (Map on top), a DECISIONS log, and roadmap/debt — preserving the original? Nothing's lost; you confirm each file."

## The split (read the source doc(s) first, then route)

- **Current-state truth → `ARCHITECTURE.md`.** Distill the **Map** (stack / services / where things live / key patterns) from the synthesis-level content. Put current-state detail below (storage, pipelines, inventories). Pull **Invariants** and **Gotchas/learnings** into their named sections — these are the highest-value, most-reused parts of the old doc, so don't let them stay buried.
- **Decisions-with-reasoning → `DECISIONS.md`** in `Chose / Because / Affects` form. Drop any "locked" framing — they're living rationale. **If a `DECISIONS.md` already exists,** treat it and any "Decisions made" section inside ARCHITECTURE as two halves of one log — merge and **dedupe** so nothing is duplicated or dropped; where two entries conflict, ask the user which still holds.
- **Open decisions / debt / TODOs → `ROADMAP.md`.** Future work, not architecture. **Reshape an existing ROADMAP** (milestones → Goal; backlog → Now/Next/Later), and **preserve real detail** — an open bug with repro steps, a carried item with substance — as a full Later entry or a `research/<slug>.md` brief. Don't flatten a rich item to a one-liner and lose what made it actionable.
- **Dated sprint narratives → drop from the living doc, but extract their truth first.** They're changelog; the history stays in git and the preserved original. A dated section often mixes narrative *with* how the app works now — pull the current-state truth into the Map/detail, then drop the narrative. Dropping a whole section blindly loses real architecture.
- **Constants, pixel values, `file:line` citations → drop.** They've already rotted or will. Keep the *lesson* (a gotcha), not the literal.
- **Create the missing v2 files:** empty `PLAYBOOK.md` (header), `research/`, `sprints/archive/`.
- **Refresh an existing `PROJECT.md`:** update its living-doc pointers to the v2 roles, and bring the **Phase** line current — old phase lines often name a launch date that's already passed.

## Outside the docs — flag, don't touch

Migration reorganizes `.claude/` markdown only. If the project's `CLAUDE.md` (or a parent repo's) routes to a *different or uninstalled* command suite — old gstack commands, a prior workflow — surface it and offer to update or remove that routing as a separate step. It's not part of the doc split, but a half-migrated project still pointing at dead commands is confusing.

## Preserve the original

Never delete the source. Move it to `.claude/archive/<name>-pre-v2.md` (or leave it in place with a pointer from ARCHITECTURE). The migration reorganizes; it doesn't destroy. If anything was lost in the split, the original is the safety net.

## In-flight sprints

If active sprint files exist in an old shape, **leave them alone** — don't rewrite mid-flight work. New sprints get the v2 shape via `/start`.

## Collaborate — ask, don't assume

This is a big restructure, and the user knows what the docs don't: which open decisions are now settled, which "active" sprints are actually abandoned, which backlog items still matter. **Lead with questions wherever it's ambiguous** — "is this still open, or did we resolve it?", "is this sprint live or dead?" — rather than guessing. Draft each split file inline and write it only after the user confirms — go file by file, not all at once. Show your reasoning for what went where, so they can catch a miscategorized decision or a dropped gotcha.
