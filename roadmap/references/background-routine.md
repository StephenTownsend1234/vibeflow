# Background routine (opt-in): Ship Captain + Ship Spotter

roadmap can keep working between sessions — one routine, run daily, doing two jobs: **Ship Captain** keeps you pointed at the goal, and **Ship Spotter** scouts upcoming work so planning is faster. Opt-in and off by default; everything in `/roadmap` works without it.

## Setting it up

Set it up with the `/schedule` skill once there's a goal and a path for it to work with — the end of the first real roadmap session is the natural moment. Recommend a **daily** cadence, or ask the user's preferred schedule.

Because it reads the project's local `.claude/` files, create it as a **Local** routine (Desktop app → Routines → New routine → Local) so it has filesystem access — a cloud routine can't see the local repo. Point the task prompt back here:

> "Run the vibeflow background routine for this project: follow `roadmap/references/background-routine.md` against this project's `.claude/`."

## What each run does

Read state first (cheap — don't deep-read everything): `.claude/ROADMAP.md` (Goal + Now/Next), `.claude/PROJECT.md`, the `.claude/ARCHITECTURE.md` Map, the **active sprint files** (`.claude/sprints/*.md` — they scope the Now work; read for context, never modify), and the sprint archive (what's shipped lately).

### Job 1 — Ship Captain (keep the goal in view)

Read what's shipped recently against the goal, and give an honest, encouraging take on how the user is tracking:

- Is the recent work moving the goal, or drifting into minutiae?
- What's the highest-leverage next move — the one thing that unlocks the goal soonest?
- Anything to speed up, ship sooner, or stop polishing?

This is roadmap's orient-to-the-goal thinking (value × dependency, the one thing, what you're avoiding) applied to recent history. Keep it short and encouraging — a captain holding the heading, not a scold. Celebrate real progress, then point at what matters next. If the priority order looks off, *suggest* a reshuffle in the digest — never silently reorder the roadmap.

### Job 2 — Ship Spotter (scout upcoming work — ask first)

**Don't research autonomously. Propose, then ask.** Across the Now/Next items (ignore Later) pick the *one* most worth researching before the user starts it — large, uncertain, or unfamiliar tech/integration; skip routine work, verification, copy-writing, and anything already scoped in an active sprint. In the digest, name it, say why in a line, and ask for the 1–2 pieces of context that would make the research good. If nothing upcoming genuinely needs it, propose nothing — a quiet run is fine. Skip items that already have a fresh `.claude/research/<slug>.md` brief.

The research itself happens **when the user replies with context** (a live session, not the scheduled run): follow `/start` Stage 2.2's "Research the approach" (`../../start/SKILL.md`) — investigate-don't-speculate; 2–3 options + grounding (`path:line` and web sources) + pitfalls — a brief, not a plan or code. Write it to `.claude/research/<slug>.md` stamped with the date + framing, and append a `brief: research/<slug>.md` pointer to that item in ROADMAP.md (append only — never restructure).

## The digest

End each run with one short digest to the user's Claude chat:

- **Ship Captain:** how they're tracking toward the goal + the highest-leverage next move (and any priority-reshuffle suggestion).
- **Ship Spotter:** the one upcoming item worth researching + the 1–2 pieces of context needed to do it well. If a previously-proposed item got context, note the brief it produced (with path).

Spotter's ask, plainly:

> "'<item>' is coming up — worth researching first because <reason>. Share <1–2 context questions> and I'll dig in before your next sprint."

When the user replies with context, research it then (live) and write the brief.

## Guardrails

- **Opt-in, low-noise.** Keep the digest short and worth reading. A quiet run with nothing to propose is fine — never manufacture work.
- **Ask first; Now/Next only.** Don't research autonomously — propose + ask. Research only on the user's reply, Now/Next only, never Later. Skip items with a fresh brief; propose at most one per run.
- **Briefs are head-starts, not gospel.** `/start` re-validates against the current framing and refreshes anything stale.
- **Inform, don't decide.** *Suggest* reprioritization in the digest; never silently restructure ROADMAP. The only writes are research files in `.claude/research/` + their `brief:` pointers, and only after a reply. Don't touch sprints, decisions, scope, or order.
