# Migrating an existing project into v2 structure

When a project already has docs in an older shape — a single accreted ARCHITECTURE doc (current state + changelog + decisions + debt all in one), or pre-v2 vibeflow files — **don't overwrite, and don't ingest the blob whole.** Split and reshape it into the v2 file structure. This is a reorganization: lose nothing, confirm each file.

## When this triggers
- An existing `.claude/` whose files predate the v2 shapes (no Map-on-top ARCHITECTURE, no PLAYBOOK, decisions/debt living inside ARCHITECTURE).
- A monolithic architecture doc (in `.claude/` or elsewhere) mixing current state, history, decisions, and open items.

Offer it plainly:

> "Your docs are in the older single-doc shape. Want me to migrate to the v2 structure — split into a tight current-state ARCHITECTURE (Map on top), a DECISIONS log, and roadmap/debt — preserving the original? Nothing's lost; you confirm each file."

## The split (read the source doc(s) first, then route)

- **Current-state truth → `ARCHITECTURE.md`.** Distill the **Map** (stack / services / where things live / key patterns) from the synthesis-level content. Put current-state detail below (storage, pipelines, inventories). Pull **Invariants** and **Gotchas/learnings** into their named sections — these are the highest-value, most-reused parts of the old doc, so don't let them stay buried.
- **Decisions-with-reasoning → `DECISIONS.md`** in `Chose / Because / Affects` form. Drop any "locked" framing — they're living rationale.
- **Open decisions / debt / TODOs → `ROADMAP.md`** (Later). These are future work, not architecture.
- **Dated sprint narratives → drop from the living doc.** They're changelog; the history stays in git and the preserved original. Fold only their *resulting current state* into ARCHITECTURE — don't copy the narratives.
- **Constants, pixel values, `file:line` citations → drop.** They've already rotted or will. Keep the *lesson* (a gotcha), not the literal.
- **Create the missing v2 files:** empty `PLAYBOOK.md` (header), `research/`, `sprints/archive/`.

## Preserve the original

Never delete the source. Move it to `.claude/archive/<name>-pre-v2.md` (or leave it in place with a pointer from ARCHITECTURE). The migration reorganizes; it doesn't destroy. If anything was lost in the split, the original is the safety net.

## In-flight sprints

If active sprint files exist in an old shape, **leave them alone** — don't rewrite mid-flight work. New sprints get the v2 shape via `/start`.

## Confirm each file

This is a big restructure. Draft each split file inline and write it only after the user confirms — go file by file, not all at once. Show your reasoning for what went where, so the user can catch a miscategorized decision or a dropped gotcha.
