# Roadmap investigator (opt-in background routine)

Does pre-sprint research **ahead of you**, so `/start` isn't gated on slow research. It periodically looks at the roadmap, picks the Now/Next items worth investigating, researches the ones that are ready, and pings you to reshape the ones that are too vague to research yet. By the time you plan a sprint from that item, the homework is done.

This is **opt-in** — you turn it on; it's not default behavior.

## Setting it up

Run it as a scheduled routine (best for true between-session "working ahead") via the `/schedule` skill — e.g. a daily run:

> `/schedule` a routine named `roadmap-investigator`, daily, in this project directory, with the task: *"Run the vibeflow roadmap investigator: follow the steps in `roadmap/references/investigator.md` against this project's `.claude/`."*

Or run it once in-session with `/loop` if you just want a one-off pass. It only acts on the current project's `.claude/`.

## What it does each run

1. **Read state:** `.claude/ROADMAP.md` (Goal + Now + Next), `.claude/PROJECT.md`, the `.claude/ARCHITECTURE.md` Map. (Cheap — don't deep-read everything.)

2. **Triage each Now/Next item** (ignore Later — don't research the junk drawer):
   - **Worth investigating?** Large, uncertain, or unfamiliar tech/integration → yes. Routine/obvious → skip. (Same generous gate as `/start` Stage 2.2.)
   - **Already has a fresh brief?** If `.claude/research/<slug>.md` exists and the item's framing hasn't changed → skip (dedupe).
   - **Ready to research?** Defined enough to have a research target?
     - **Worth it + ready + no fresh brief** → research it (step 3).
     - **Worth it + too vague** → don't research. **Ping the user to reshape it** (step 5) — a one-line definition is enough to make it researchable next run.

3. **Research** using the *same approach as `/start` Stage 2.2* — read `../../start/SKILL.md`'s "Research the approach" stage and follow it: the generous gate, Tier 1 (inline web + read the project's own code) / Tier 2 (focused research subagent or `deep-research` for big unknowns), structured research (competing hypotheses, confidence, self-critique), and investigate-don't-speculate. Produce the **same kind of output**: 2–3 approach options + grounding (`path:line` and web sources) + known pitfalls. **A brief, not a plan or code.**

4. **Write the brief** to `.claude/research/<slug>.md`, stamped with the date and the item framing it was based on (so `/start` can tell if it's gone stale). Add a `brief: research/<slug>.md` pointer to that item in ROADMAP.md.

5. **Notify** with a short digest — what was researched (with the file paths), and which items need reshaping. For "too vague to research" items, send a **push notification** asking the user to define it in a line:

   > "Roadmap item *'<item>'* looks worth researching but it's loosely scoped — reply with a one-line definition (what it is + what it unlocks) and I'll research the approach before your next sprint."

   When they reply, that reshapes the item; the next run researches it.

## Guardrails

- **Now/Next only.** Never research Later.
- **Dedupe + cap.** Skip items with a fresh brief; cap how many items you research per run (a few — don't burn a run trying to do everything).
- **Briefs are head-starts, not gospel.** `/start` re-validates against the current item framing and refreshes anything stale. Priorities shift; a brief is a draft.
- **Write only to `.claude/research/` and the ROADMAP pointer.** Don't touch sprints, don't write decisions, don't change scope. The investigator informs; it doesn't decide.
- **Ping, don't guess.** When an item is too vague, ask the user to reshape it — never research a guess at what they meant.
