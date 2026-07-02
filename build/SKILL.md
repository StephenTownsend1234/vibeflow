---
name: build
description: Execute vibeflow work — a planned sprint or direct iteration (Freebuild). Supplies the project's context and locked approach, holds scope, verifies with tools, and runs one-shot by default with checkpoints delegated to fresh-context verifiers. Use when the user wants to build, continue a sprint, or iterate on the product; /start flows into this automatically after routing or planning.
---

# /build

Read `~/.claude/skills/vibeflow/CORE.md` first (skip if already in context). Stance: **execute within the plan's guardrails — trust your reasoning on a coarse step, hold the line on scope.**

`/build` supplies what a fresh chat lacks: the project's context and the sprint's locked approach, the user's working preferences, and guardrails against the ways autonomous coding goes wrong. It is a frame, not a procedure — trust your execution on well-scoped steps.

## Entry

- **Warm** (arrived from `/start` in this chat): don't re-read or re-brief — pick up immediately.
- **Cold with a sprint**: read the sprint file + orientation gaps in one parallel batch (trust the sprint's Approach and Ground truth — don't re-investigate what plan mode grounded). Brief in four lines (sprint, approach, N/M steps, next up), ask "anything changed since this was planned?", then go.
- **No sprint (Freebuild)**: ask what they want to work on if unstated, load the working context for that target on demand, and iterate. If the work grows into real scope — several coherent steps, decisions worth recording — offer to capture it as a sprint so `/wrap` can track it; until then nothing is written to `.claude/`.

## Run mode

Derive it from the plan; don't ask. Announce in one line and proceed:

- **One-shot** (default after a thorough plan): work straight through; user-facing changes collect into a single verification pass at the end. "Running one-shot — say *checkpoint me* to change it."
- **Verify-each** only when the sprint has `[unknowns]` steps or genuinely risky user-facing surfaces (irreversible operations, money, data migrations).

For a long mechanical one-shot sprint, offer `/goal` once: "I can set a goal — every step checked off or a blocker recorded — so this runs to completion." Blockers recorded in the sprint file are a valid exit, not a stall.

## While building

**Honor the step tags:** verify `[REUSE]` targets are intact before depending on them (broken → surface as a blocker, don't silently fix); re-pin `[PORT]` sources if they've drifted since planning; pin the contract (input, output, empty/error states) on non-trivial `[NEW]` work.

**Guardrails** (the failure modes that still need holding, per this user's experience):

- **Don't overbuild.** Only changes the task requires — no extra configurability, no abstractions for one-time operations, no cleanup of code you didn't change. Unrequested additions are where sessions break: if you're tempted to add polish or infrastructure beyond the stated goal, that's a Decision card, not a silent inclusion.
- **Don't speculate about code — verify with tools.** Read the file before claiming how it works; check the deployed/DB state before asserting it. Trust the sprint's Ground truth citations; open anything else you depend on.
- **Don't expand scope silently.** A blocking discovery: surface it and decide together. Non-blocking: add to the sprint's TO-DOs and keep moving.
- **Match iteration to the feedback-loop cost.** If verifying needs the user (visual/device checks), front-load thinking and ship one considered change per round. Guess-and-check fast only when you can verify locally.
- **Ask for manual help when it's faster** — logs, dashboards, a screenshot: "while I work on X, can you check Y?"

## Checkpoints

At a `→ CHECKPOINT:` (or the end-of-sprint pass), split the verification:

- **Machine-verifiable** (behavior, contracts, data flow): dispatch a fresh-context verifier — the `/verify` skill, or a subagent given only the step's contract and the diff — instead of pausing for the user. Fresh eyes outperform self-review.
- **Human-only** (visual, feel, on-device): give the user a concrete action list — "open X, tap Y — does Z happen?" — and wait. These are the only checkpoints that interrupt.

**Before reporting progress or completion, audit each claim against a tool result from this session** — a diff, a test run, a command output. Unverified things are reported as unverified.

## When things break

The most recent change is the first suspect — back it out before stacking workarounds. Before trying fix N+1, state in one sentence why fix N failed, backed by evidence (a log, a test result), not a hypothesis. Two failed fixes without a confirmed cause → stop, summarize what you've ruled out, and ask the user for the data they can get faster than you (console output, device logs).

## Completion

All steps checked: run the collected verification pass (one-shot mode), then suggest `/wrap` — don't auto-run it. New technical decisions and deferred discoveries stay noted in the sprint file for wrap to route. If work contradicted ARCHITECTURE, flag it for wrap rather than silently editing.
