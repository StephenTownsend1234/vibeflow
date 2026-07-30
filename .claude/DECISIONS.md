# Decisions

Registry of why the pack is shaped this way — grouped by area, merge-don't-append, ≤6 lines. Full v2→v3 mechanism history lives in `docs/v2-vs-v3-crosswalk.md`; this file holds only the load-bearing calls a future session must not silently reverse.

## Core philosophy

### Principles over choreography (2026-07-02)
**Chose:** rewrite v2's 1,068 lines of staged procedure into ~380 lines of principles + hard boundaries only where fragile.
**Because:** Fable-5-class models degrade under prescription (official guidance), and Jumbo transcripts showed every good moment came from principles, every bad one from ceremony. The evidence lives in the audit (`~/.claude/jobs/f0192545/tmp/audit/`).

### The consent layer (2026-07-02, tail 2026-07-08)
**Chose:** ask when the answer changes *what* gets built; act freely on *how*; unrequested additions are proposals; a sidestepped answer is not consent.
**Because:** field data — the transparentModal incident (unasked polish caused a whole debug session) and the notification planning that locked two forks on "[no preference]" + an off-topic reply. This is the pack's identity; also applies to changes to the pack itself.

### Human gates canon; research drafts only (2026-07-02, confirmed vs Letta 2026-07-15)
**Chose:** background/autonomous work writes only to `research/` with an Assumptions block; canonical files change through human-confirmed wrap/plan steps.
**Because:** watched a competing system write agent research straight into canonical memory, auto-committed. Canon is earned at confirmation, never before.

## Planning (/start)

### Gather stage — user context is the raw material (2026-07-08)
**Chose:** explicit dump-invitation → play-back → experience-walk-before-tech → alternating question rounds; tripwire "if the user has barely spoken, you're deciding their sprint for them."
**Because:** v2's ceremony was accidentally load-bearing (forced user turns); the lean v3 plan path let Claude shape a whole sprint from four short answers. Experience forks decide technical forks (notification capture: confirmation UX killed extraction).

### One plan gate; cp-first sprint handoff (2026-07-02, cp restored 2026-07-08)
**Chose:** ExitPlanMode is the only plan approval (Pre-Plan Handshake folded in). Sprint file = `cp` of the approved plan + status-header edit, never re-synthesis.
**Because:** three gates confirmed already-agreed content; and the first v3 sprint re-wrote 101 plan lines from memory — fidelity drift Stephen caught immediately.

### Orientation is deterministic and lazy (2026-07-02; lazy 2026-07-07)
**Chose:** hook injects identity/Map/roadmap-top/sprint-status-lines; full sprint files load only after the user picks one; git reconciliation proportional to the gap.
**Because:** anything before user intent must be near-instant; 6-minute pre-choice reading walls and unconditional git archaeology both got flagged in the field.

## Build

### One-shot by default, derived not asked (2026-07-02)
**Chose:** run mode derived from the plan, announced with an override phrase; verify-each only for [unknowns]/risky surfaces.
**Because:** Stephen: "after a thorough plan, one-shot always works great; checkpoints make Claude overbuild between steps."

### Fresh-context verifiers + typed checkpoints (2026-07-02)
**Chose:** `→ CHECKPOINT (machine)` dispatches to /verify (fed by the /run-skill-generator recipe); `(human)` interrupts with a concrete action list; humans only see what only humans can judge.
**Because:** the writing session grades its own homework generously; Fable docs confirm fresh-context verification outperforms self-critique.
Re-examined 2026-07-30 vs the Opus 5 prompting guide (which calls verifier instructions redundant): kept unchanged — the 07-17 overnight-run evidence (5 real bugs the builder rationalized past) outranks; revisit only if field sessions show over-verification.

### Anti-overbuild guardrails kept despite leanness guidance (2026-07-02)
**Chose:** keep don't-overbuild / don't-speculate / verify-with-tools even though official guidance says such prompts are now redundant.
**Because:** Stephen's standing field observation — "claude still likes to overbuild" — outranks generic guidance. Do not remove on a doc's authority.

## Design

### Reference layer, not a sixth skill (2026-07-30)
**Chose:** design craft lives at pack-root `design/` (no SKILL.md → the installer's gate means it can never become a command) + per-project `.claude/design.md`, lazy-created on first design work; wired into CORE/start/build/wrap at four moments, ~15 lines total.
**Because:** design must load after expressed intent, never before (the tuning heuristic); Stephen wanted a partner that supplies the design vocabulary he doesn't have — feelings and references in, observables played back for a yes/no. Adapted from his Opus 5 design system; personal tooling (Flora/Weavy) stripped to generic craft.

## Wrap & memory files

### Registry not diary; collision by design (2026-07-01..02)
**Chose:** DECISIONS grouped by area, merge-don't-append, supersede-in-place with date+why, ≤6-line entries; transient states live only in sprint TO-DOs.
**Because:** Jumbo's 614-line date-log grew contradictions 300 lines apart (the two wipe entries) and deploy-state prose that rotted on contact. Adjacency beats archaeology.

### Re-verify existing claims at wrap (2026-07-02)
**Chose:** for each diff-touched area, check Map/roadmap/gotcha claims still hold before saving.
**Because:** living-doc rot was v2's one systematic failure (stale Map hid a real chat-injection bug); first outings caught the "both on 4.6" line and a false "bridge DONE" claim.

### Harvest question + distill = condense, not cut (2026-07-08; distill 2026-07-16)
**Chose:** one end-of-session question ("what did this teach — learnings, lessons, preferences, frictions?") gated by the future-session test; distill passes merge/compress but delete only the provably superseded/shipped — unsure → keep or ask.
**Because:** praise-gated capture failed (2 entries/16 sprints); pure-friction capture risks a don't-list; Stephen: compounding knowledge, not bloat, and never scrap what we might need.

### Automation ticker + friction/delight log (2026-07-29, from gbrain)
**Chose:** wrap tracks recurring-smelling manual tasks in `.claude/automations.md` (line + dates; 2+ dates → automate-or-delete fork) and appends ≤1 friction/delight line per session to the global `~/.claude/vibeflow/friction.md`. Gap analysis deliberately parked.
**Because:** gbrain deep-dive (research/gbrain-learnings.md) — "asked twice = automate" was the one instinct vibeflow lacked; friction capture makes the brother's field-fix loop work without Stephen mediating. Stephen: keep both super simple, no overlogging.

### Promotion/demotion lifecycle (2026-07-16)
**Chose:** greppable, high-cost gotchas get promoted to deterministic hooks; once promoted, their prose demotes to one pointer line.
**Because:** the db-push guard worked, yet four prose copies (incl. always-loaded CLAUDE.md) kept the incident alive in every session's conversation. Mechanized rules don't need re-reading.

## Hooks & harness (the mod layer)

### Deterministic shell, hard caps, fail-silent (2026-07-02..16)
**Chose:** orientation + snapshot + statusline are plain shell — no AI calls; 120-line/16KB caps; exit 0 on any failure; snapshot is self-cleaning (wrap deletes it; clean state removes it).
**Because:** the always-on tier must be un-hallucinatable, free, and never able to break a session. The harness never self-modifies — every hook was proposed, reviewed, tested before install (trust gradient: memory < skills < mods).

## Distribution

### v3 as a branch; symlinks make it live (2026-07-02)
**Chose:** develop on branch `v3` in the installed repo; accept that the checked-out branch is live everywhere; main stays v2 until Stephen merges.
**Because:** instant test-and-revert (`git checkout main`) beat parallel suffixed commands; the symlink liveness is documented as a gotcha, not fought.
