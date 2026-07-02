---
name: wrap
description: End a vibeflow session by saving its progress, decisions, and learnings into the `.claude/` files so the next session starts smarter — reconciles sprints against the real diff, re-verifies existing doc claims in touched areas, routes each fact to its one home, archives completed sprints, and makes a checkpoint commit. Use at session end, when the user says to wrap up / save the session, or when context is running low and work should be preserved.
---

# /wrap

Read `~/.claude/skills/vibeflow/CORE.md` first (skip if already in context). Stance: **save this session so a cold session with no memory of this chat starts smarter — nothing it needs should live only here.**

The test for every action: *would a fresh session need this to proceed well?* Precision over volume — each fact lands once, in its one home. Wrap often runs with context nearly gone, so the order below is deliberate: cheapest, highest-value work first, and everything front-loaded into batches.

## 1 — Ground (one silent batch)

In one parallel pass: `git status` + `git diff` (uncommitted) + `git log` since the last wrap commit (find it via the `docs(wrap):` prefix); every in-flight sprint file; the target docs you may edit (DECISIONS + ARCHITECTURE — skim whole, you'll edit only diff-touched areas — and ROADMAP top); `.claude/.last-session.md` if present. Reading targets now prevents mid-apply read-thrash later.

Base "what shipped" on the diff and log — the conversation supplies the *why* and the attribution, not the *what*. Stamp dates from the environment, never from memory (long sessions carry a stale sense of today).

## 2 — Attribute

Map changed paths → sprint scopes **explicitly** when more than one sprint is in flight, and say the mapping in one line ("profile components → profile-vault; bridge → hotfix task D — updating both"). A path both sprints could claim: attribute by which sprint's step it advances. Every touched sprint file gets its status updated — never consolidate two sprints' work into one file. Changes this session didn't discuss get flagged as a line in the proposal, not a standalone question ("`payments/` also changed — leaving it out as another chat's work unless you say otherwise").

Update each touched sprint: check off what the diff proves shipped; "Last session" one-liner; "Next up" with the context to resume cleanly — **including where iteration stalled mid-conversation** ("user was mid-feedback on the Me page; reflection treatment undecided"), which is often the most valuable line in the file. Route open TO-DOs yourself (promote to a step / defer to ROADMAP Later / resolve into DECISIONS / drop) — only genuinely open forks go to the user.

Freebuild session with real work and no sprint: summarize what shipped from the diff and fold outcomes into the docs below; offer a retroactive archive entry only if the user wants a trace.

## 3 — Harvest and route

Walk the session once — the diff for what changed, the conversation for what we *learned* — and route each piece:

| What you have | Where it goes |
|---|---|
| sprint progress / where iteration stalled | the sprint file |
| a fact about how the system works, a gotcha | ARCHITECTURE (Map if it changes orientation) |
| a choice + rationale (real alternative existed) | DECISIONS — into its **area**, merged not appended |
| a priority shift | ROADMAP (top tier); details block if context came with it |
| a phase/focus change | PROJECT.md's phase line, rewritten in place |
| a correction to how we work / a transferable lesson | global profile (`~/.claude/vibeflow/playbook.md`) |

Routing rules (from CORE.md, applied here): transient states → sprint TO-DOs only; merge-don't-append in DECISIONS (supersede in place, ≤6 lines/entry); lessons positive **or** negative; edit docs in place — never bolt on dated "what we did" sections; a quiet session legitimately updates only sprint progress. Auto-memory handles incidental session habits on its own — wrap owns the git-tracked project state; don't duplicate into both.

**Re-verify existing claims (the step that prevents doc rot):** for each area the diff touched, check the Map, the ROADMAP top, and matching DECISIONS/gotcha lines — do they still hold? A model bump, a retired table, a cleared blocker: rewrite the stale sentence now, while the change is in context. While in ROADMAP, delete shipped items (top line + details block) and fix any dead pointers you notice.

**Preferences:** if the user corrected *how* you worked this session (verbosity, check-ins, framing, scope appetite), update the Working preferences block in the global profile — edit in place, max ~10 bullets.

## 4 — Propose once, apply once

Present a **compact proposal** in one message: any genuinely open "needs your call" forks (AskUserQuestion, with recommendations — say "none" if none) together with one line per file describing what you'll write. Not full drafts — one scannable list the user can veto items from ("skip design tho"). Answering the forks — or a bare go-ahead — is the single confirmation; apply immediately, honoring any vetoes. A session with nothing worth saving: say so in one line and stop — no proposal, no commit.

On that confirmation: apply all writes in parallel, including `.claude/.last-session.md` — a 2–3 line carry-forward (what shipped, what's unverified/undeployed, where iteration stalled), overwritten each wrap; it's what a future session or parallel chat reads first, and the only trace a no-sprint Freebuild session leaves. Archive any fully-checked sprint (`sprints/archive/<sprint-NNN>-<slug>.md`, next sequential NNN), then make the checkpoint commit (`docs(wrap): <summary>` plus any uncommitted session work the user wants included). Never push.

Then **one** final summary: the commit hash, one line per file changed, and the carry-forward for next session. No second recap.

## 5 — If a sprint was archived

Offer once: plan the next sprint now (read `../start/SKILL.md`, run its planning), or defer — "next session, `/start` picks up from here."
