# Changelog

What changed and why, newest first — the backward-orienting record (ROADMAP orients forward; DECISIONS holds standing constraints). Append-only: /wrap adds one dated entry per session with meaningful change; old entries are never rewritten. Dogfood experiment (2026-08-03) — promote to the pack templates if it earns it.

## 2026-09-09 — Session notes handoff: hook recency-first under 9KB
Stephen flagged that wrapping two chats at once left the next session oriented on whichever wrapped last. Diagnosis (research/multi-chat-handoff.md) found worse: Jumbo's orientation hit the hook's own 16KB cap before the sprint lines and carry-forward were emitted, and since 2026-08-26 the harness spills hook output above ~10KB to a file with a 2KB preview — the carry-forward never reached a Jumbo session. Compared side by side against a plain read of the files (~32K tokens on Jumbo, blind to post-wrap commits, unwrapped sessions, and live chats), the hook won on both cost and truth. Shipped (db0745b): hook reordered recency-first (sprints, other chats active now via transcript mtimes, last-36h commits, snapshot, notes, then capped roadmap Now + Map) under 9KB; `.last-session.md` becomes a stack of ≤5-line per-chat notes in a guide's voice, prepended, never rewritten, 7-day trim; /start briefs as Lately / Sprints / Open / Next and treats live chats' files as theirs. Hook copies refreshed in Jumbo (93072ce) and havio-clinic (77b590d); hooks installed for the first time in the Paravita support agent (948eccf — still v2-shaped, bootstrap migration queued). Stephen's steer: keep it simple, a guide's note not a changelog; CHANGELOG stays a dogfood experiment.

## 2026-08-26 — Global playbook distilled; merge-first encoded
Stephen flagged the global playbook filling with junk too fast. Audit confirmed: 23 lesson entries / 291 lines (10 added in three August weeks from one Shopify project's sessions), a six-entry family all restating "the artifact of record drifts from the running system", and dated war-story narration leaking into Working preferences. Root cause was structural: the playbook's own header said "Lessons: **append**" — the one file exempt from merge-don't-append — and wrap's distill trigger never named it, so nothing ever merged. Distilled to 14 principle-titled, undated entries / 74 lines under Stephen's bar (genuinely global? would a *different* project act on it? unclear → delete): the rot family merged to one entry, the two shared-checkout lessons merged, three deleted outright (sequencing + delegation already lived as preference bullets; relay-geo too environmental to transfer). Fix encoded in the pack: CORE's Global profile section, wrap's routing rules + distill trigger, and templates/global-profile.md's lesson format now all say merge-first, kernel + reuse-when. The pre-distill playbook survives only in that session's transcript (the file lives outside any git repo).
Answered in passing: the "weird text file" a bootstrap session read (`~/.claude/projects/<project>/<session>/tool-results/<random>.txt`) is Claude Code's spill file for oversized tool results — harness plumbing, harmless.

## 2026-08-03 — Wrap-overreach field fixes + this changelog
A Jumbo audit-wrap transcript showed /wrap proposing 5 files + a hook for a session that changed no product code, codifying a backwards rule (ban `commit && push`) whose real cause was a stale push-hold, and using shorthand Stephen had to ask about ("counsel-gated clinic drafts", "open forks"). Fixes shipped (c603d7d): wrap gets explicit permission to leave harvest areas empty; the friction/delight log is retired (mechanism removed, `~/.claude/vibeflow/friction.md` deleted); a new "rules come from causes, not incidents" test replaces it in place; CORE Communication gains "name things by what they are" (no session-local shorthand).
Watch-items — model slips against rules that already exist; encode only if they recur: duplicating wrap facts into auto-memory; raising alarms before verifying severity-determining facts (the "public repo" that was private); narrating live agent results against moving state. The source transcript doubles as the eval loop's first scenario (wrap overreach regression).
Also: this changelog adopted — ROADMAP's Done list folded in below, DECISIONS refocused on standing constraints and closed doors. Reconciled from an earlier unwrapped session: `.last-session.md` now merges parallel-chat entries instead of clobbering (1bef5b0).
Roadmap correction (same day): Stephen flagged the "migrate Jumbo to v3" Now item as long done — verified in Jumbo's repo (v3 shapes throughout, PLAYBOOK retired, hotfix sprint archived 07-17, backlog wrapped clean by the 5-chat audit). It and the Jumbo-hygiene item removed; the surviving piece (seed Jumbo's design.md — the design layer's field test) moved to Next.

## 2026-07-31 — v3 on main
`main` fast-forwarded to v3 (tag `v2` = rollback, `v3` branch deleted) so a cold clone installs v3 with no branch flag — the brother's install path. README rewritten for fresh eyes (voice rule: plain principle first, then the technical how). Update check daily→weekly; hook copies now detect their own drift from the pack but never self-overwrite. Jumbo's session-start.sh refreshed from the pack (jumbo dd32542).

## 2026-07-30 — Design layer + v3 on GitHub + Opus 5 audit
Design integrated as a reference layer, not a sixth skill: pack-root `design/` references + per-project `.claude/design.md` (lazy-created) + four-moment wiring, ~15 lines total (aa980ee) — the design-partner stance: feelings and references in, observables played back. v3 pushed to GitHub (`origin/v3`), unblocking the brother's install. Pack audited against the Opus 5 prompting guide — already aligned on the big things; three calls parked (ROADMAP details).

## 2026-07-29 — gbrain deep-dive adoptions
From studying gbrain: the ask-twice automation ticker (recurring manual task → automate-or-delete fork) and the friction/delight log (retired 2026-08-03) adopted into CORE/wrap; local gbrain trial installed; brief in research/gbrain-learnings.md.

## 2026-07-16 — Adaptive mods batch
Promotion/demotion lifecycle (greppable high-cost gotcha → deterministic hook; prose demotes to a pointer), distill pass (condense, not cut), hot-areas orientation line, SessionEnd/PreCompact snapshot hook, statusline, provenance corollary. Brother feedback doc drafted (Downloads).

## 2026-07-15 — Crosswalk review round
v2-vs-v3 crosswalk reviewed; bootstrap frontmatter repaired after formatter mangling.

## 2026-07-07..08 — First field-fix wave from Jumbo dogfooding
Lazy reads, resume sync, cp-first sprint handoff, the Gather stage, the consent tail, the delegation depth cap, git-workflow lines — each fix traces to a flagged Jumbo session moment.

## 2026-07-02 — v3 built
383 lines vs v2's 1,068: principles over choreography, hard boundaries only where fragile. Seven fresh-context review agents; all findings applied. Full mechanism-by-mechanism v2→v3 history: docs/v2-vs-v3-crosswalk.md.
