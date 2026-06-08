# SPRINT.md shape

The doc must be readable cold by a fresh `/build` chat. Front-load context; put decisions lower. Order is load-bearing.

The Tasks section is **coarse by design** — a handful of meaningful steps with checkpoints, not a micro-checklist. The plan's job is to convey the approach and where to stop and verify, then trust `/build` to one-shot the spans between checkpoints.

```markdown
# Sprint: <name>

## Goal
<one sentence — what ships>

## Context
<2-4 sentences. What's the user problem this solves? What breaks without this?
What's already built (reference prior sprint if relevant)? One paragraph someone
reading cold needs to understand why this matters.>

## Approach
<The approach locked during planning, in 2-4 sentences — the option chosen in
Stage 2.3 and why. Include the grounding that made it the right call (a web
finding, a constraint from our stack). This is the expensive-to-reverse decision;
state it plainly so /build doesn't drift from it.>

## Ground truth
<Verified facts from plan-mode investigation. Each bullet cites `path:line` for
load-bearing claims the plan depends on. Examples:
- "chat/index.ts:180 streams SSE meta/delta/done events — Lab proxies with ReadableStream"
- "transcribe/index.ts:42 hardcodes audio/m4a — needs a content-type branch for webm"
These are the facts the rest of the sprint is built on. If one is wrong, replan.>

## Port map (only if porting existing work)
Include PORT rows only. REUSE goes in the "Reuse as-is" list below. Omit entirely
for greenfield sprints.

| Source | Target | Swap | Notes |
|---|---|---|---|
| ... | ... | ... | ... |

## Plan
A short ordered list of coarse steps — each a span /build can one-shot — with
explicit checkpoints. ~3-6 steps total, not a micro-checklist. Tag steps
`[PORT]` / `[NEW]` / `[REUSE]`. Tag complexity only when `unknowns` or `blocked`.

Mark checkpoints with `→ CHECKPOINT:`. At each one, /build offers to verify — the
user can check it there, or one-shot through and verify at the end.

- [ ] [NEW] <coarse step — an outcome, not a micro-task> — <file paths>
- [ ] → CHECKPOINT: <what to verify and how — e.g. "confirm streaming latency feels right">
- [ ] [PORT] <next coarse step> — <file paths>
- [ ] [NEW] [unknowns] <step with real design risk> — <file paths>
- [ ] → CHECKPOINT: <final verification>

## Reuse as-is (read, do not modify)
- <paths to existing files the sprint depends on but does not change>

## Out of scope
- <explicit no's>

## Key decisions
<Not "locked" — the decisions made during planning so the /build chat knows the
reasoning. The user may revise during the sprint; that's fine.>
- <bullet per decision with one-line rationale>

## Open questions
- <only real unknowns, not fake decisions>

## Done criteria
- <concrete, testable pass/fail gates>
```

## Sections banned from SPRINT.md

- No "Realistic effort", "Timeline", "Effort estimate", or "Execution order" with hours.
- No day assignments, no hour estimates anywhere.
- No "Phase 1 / Phase 2 / Phase 3" temporal slicing — order the step list and mark checkpoints; that's the slicing.

Scope is conveyed through step ordering, checkpoints, and the `[unknowns]` / `[blocked]` tags only.
