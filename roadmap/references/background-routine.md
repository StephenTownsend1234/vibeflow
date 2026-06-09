# Background routine (opt-in): Ship Captain + Ship Spotter

roadmap can keep working between sessions — one routine, run daily, doing two jobs: **Ship Captain** keeps you pointed at the goal, and **Ship Spotter** scouts upcoming work so planning is faster. Opt-in and off by default; everything in `/roadmap` works without it.

## Setting it up

Set it up with the `/schedule` skill once there's a goal and a path for it to work with — the end of the first real roadmap session is the natural moment. Recommend a **daily** cadence, or ask the user's preferred schedule.

Because it reads the project's local `.claude/` files, create it as a **Local** routine (Desktop app → Routines → New routine → Local) so it has filesystem access — a cloud routine can't see the local repo. Point the task prompt back here:

> "Run the vibeflow background routine for this project: follow `roadmap/references/background-routine.md` against this project's `.claude/`."

## What each run does

Read state first (cheap — don't deep-read everything): `.claude/ROADMAP.md` (Goal + Now/Next), `.claude/PROJECT.md`, the `.claude/ARCHITECTURE.md` Map, and the sprint archive (what's shipped lately).

### Job 1 — Ship Captain (keep the goal in view)

Read what's shipped recently against the goal, and give an honest, encouraging take on how the user is tracking:

- Is the recent work moving the goal, or drifting into minutiae?
- What's the highest-leverage next move — the one thing that unlocks the goal soonest?
- Anything to speed up, ship sooner, or stop polishing?

This is roadmap's orient-to-the-goal thinking (value × dependency, the one thing, what you're avoiding) applied to recent history. Keep it short and encouraging — a captain holding the heading, not a scold. Celebrate real progress, then point at what matters next.

### Job 2 — Ship Spotter (scout upcoming work)

Triage each Now/Next item (ignore Later — don't research the junk drawer):

- **Worth investigating?** Large, uncertain, or unfamiliar tech/integration → yes. Routine → skip. (Same generous gate as `/start` Stage 2.2.)
- **Already has a fresh brief?** If `.claude/research/<slug>.md` exists and the framing hasn't changed → skip.
- **Ready to research?** Defined enough to have a research target?
  - Worth it + ready + no fresh brief → research it.
  - Worth it + too vague → don't research; ask the user to reshape it (a one-line definition makes it researchable next run).

Research using the same approach as `/start` Stage 2.2 — read `../../start/SKILL.md`'s "Research the approach" stage and follow it (the generous gate, Tier 1 inline / Tier 2 subagent, structured research, investigate-don't-speculate). Produce the same output: 2–3 approach options + grounding (`path:line` and web sources) + pitfalls — a brief, not a plan or code. Write it to `.claude/research/<slug>.md`, stamped with the date and the framing it was based on (so `/start` can tell if it's gone stale), and add a `brief: research/<slug>.md` pointer to that item in ROADMAP.md.

## The digest

End each run with one short digest to the user's Claude chat:

- **Ship Captain:** how they're tracking toward the goal + the highest-leverage next move.
- **Ship Spotter:** what got a brief (with file paths), and which items need a one-line reshape to be researchable.

For items too vague to research, ask plainly:

> "Roadmap item '<item>' looks worth researching but it's loosely scoped — reply with a one-line definition (what it is + what it unlocks) and I'll research the approach before your next sprint."

When the user replies, that reshapes the item; the next run researches it.

## Guardrails

- **Opt-in, low-noise.** The user turned this on — keep the digest short and worth reading. Encourage, don't nag.
- **Now/Next only for research.** Never research Later. Dedupe (skip fresh briefs) and cap how many items you research per run.
- **Briefs are head-starts, not gospel.** `/start` re-validates against the current framing and refreshes anything stale.
- **Inform, don't decide.** Write only to `.claude/research/` and the ROADMAP brief pointer. Don't touch sprints, write decisions, or change scope or priorities — that's the user's call in a real `/roadmap` session.
- **Ping, don't guess.** When an item is too vague, ask the user to reshape it — never research a guess at what they meant.
