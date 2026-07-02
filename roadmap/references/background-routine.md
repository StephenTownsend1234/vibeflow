# Background routine (opt-in): Ship Captain + Ship Spotter

One routine, run daily as a **Local** scheduled task (it reads the project's `.claude/` files, so cloud routines can't see it). Set up via `/schedule`; task prompt:

> "Run the vibeflow background routine for this project: follow `roadmap/references/background-routine.md` against this project's `.claude/`."

Each run reads (cheap, don't deep-read everything): ROADMAP top tier + the Details blocks of Now/Next items, PROJECT.md, the ARCHITECTURE Map, active sprint files (context only — never modify), and recent archive entries.

## Job 1 — Ship Captain (hold the heading)

Read what shipped recently against the goal and give an honest, encouraging take: is the work moving the goal or drifting into minutiae? What's the highest-leverage next move? Anything to ship sooner or stop polishing? Suggest a reshuffle in the digest if the order looks off — never silently reorder ROADMAP.

## Job 2 — Ship Spotter (research ahead, autonomously)

Pick the **one** Now/Next item most worth researching before the user starts it — large, uncertain, or unfamiliar tech/integration. Skip routine work, items already scoped in an active sprint, and items with a fresh brief. If nothing qualifies, a quiet run is fine — never manufacture work.

**Research it now, in this run.** Answer your own context questions from the item's Details block, PROJECT, ARCHITECTURE, DECISIONS, and the sprint archive. Then investigate properly — real code reads (`path:line`), web sources, known pitfalls — and write the brief to `.claude/research/<slug>.md`:

```markdown
# <item> — research brief (YYYY-MM-DD)

## Assumptions I made
- <each context question you answered yourself, and the answer you assumed>

## Options (2-3, with a recommendation)
## Grounding (path:line + sources)
## Pitfalls
```

The Assumptions block is the safety mechanism: the user can audit your framing in ten seconds and correct it in one reply. Append a `[brief: research/<slug>.md]` pointer to the item's top line in ROADMAP (append-only — never restructure). Fall back to asking in the digest only when an item is too vague to research at all — and say what would unblock it.

## The digest

One short message: Captain's read (tracking + highest-leverage next move) and, if Spotter ran, "brief written for <item> — check the assumptions block, correct anything wrong." Short enough to always be worth reading.

## Guardrails

- One brief per run, Now/Next only, skip fresh-brief items.
- Writes are limited to `research/` files + their pointer lines. Never touch sprints, decisions, scope, or order.
- Briefs are head-starts, not gospel — `/start` re-validates against the current framing.
