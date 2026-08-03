# Roadmap

## Goal: v3 proven on real projects and in real hands
One line — Jumbo fully migrated and humming on v3, brother building his legal platform with it, and the pack's story tellable to a room.

## Now (the next sprint or two)
1. Migrate Jumbo's docs to v3 shapes via /bootstrap — the migration reference's first real test   [→ details]
2. Onboard the brother — first true cold-start user; his experience is the next round of field fixes   [→ details]

## Next (after that, ordered)
- Jumbo hygiene: split the hotfix-onboarding-security rolling-bug-tracker sprint; wrap the ~22 files of unwrapped work the snapshot flagged
- Resolve the crosswalk's open flags (#4 existing-arch-doc canonicality, #5 command-less sessions, #6 cold build/wrap don't read the global profile)   [→ details]
- Eval loop via the skill-creator plugin — scenario tests (triggering, wrap attribution) run with-skill vs baseline   [→ details]
- Talk / landing page from docs/how-vibeflow-works.md

## Later (parked inbox, unordered)
- Harvest the gbrain trial (local install 2026-07-29, `~/brain/GBRAIN-TRIAL.md`) — what does a life-brain feel like; which capture habits stick; informs cross-project brain + parked gap-analysis/dream-cycle ideas (research/gbrain-learnings.md)
- Autonomy wave 2: doc-truth Job 3 in a live scheduled routine; overnight spike branches for [unknowns]; research-on-capture micro-briefs in practice — gbrain's dream cycle proves the pattern; job ideas in research/gbrain-learnings.md
- Screenshot→critique visual-review loop for /build checkpoints — the residual of the design idea (core design layer shipped 2026-07-30, aa980ee)
- Opus 5 prompting-guide audit follow-ups — parked 2026-07-30, nothing urgent   [→ details]
- Periodic structure review ("has the project outgrown its files?") — noted from Letta comparison, deliberately not a rule yet
- Worktree guidance for parallel sessions touching the same files (trusted to judgment for now)
- Vector retrieval as a *finding* layer — only if/when multi-project or team scale arrives
- Cross-project knowledge repo (company brain) — same architecture one level up

## Done (recent — cap ~10)
- 2026-07-31: v3 merged to main (tag `v2` = rollback, `v3` branch deleted); README rewritten for fresh eyes; update check daily→weekly; hook-copy drift nudge; Jumbo's hook refreshed (jumbo dd32542)
- 2026-07-30: design integration — pack-root design/ references + per-project design.md + four-moment wiring (aa980ee)
- 2026-07-30: v3 pushed to GitHub (`origin/v3` @ ab9a641) — brother install unblocked
- 2026-07-29: gbrain deep-dive — ask-twice automation ticker + friction/delight log adopted into CORE/wrap (log retired 2026-08-03); local gbrain trial installed; brief in research/gbrain-learnings.md
- 2026-07-16: adaptive mods batch — promotion/demotion lifecycle, distill pass (condense-not-cut), hot-areas line, SessionEnd/PreCompact snapshot, statusline, provenance corollary
- 2026-07-16: brother feedback doc (GL-Brain-Vibeflow-Feedback.html in Downloads)
- 2026-07-15: crosswalk review round; bootstrap frontmatter repaired after formatter mangling
- 2026-07-07..08: field-fix wave from Jumbo dogfooding (lazy reads, resume sync, cp-first, Gather, consent, delegation, git-workflow lines)
- 2026-07-02: v3 built (383 lines vs v2's 1,068), 7 review agents, all findings applied

## Details

### jumbo-migration
Bootstrap detects the v2 shape → `bootstrap/references/migrate-v2-to-v3.md`. DECISIONS (51 date-log entries) → area registry with merge/dedupe (two wipe entries contradict — ask which mechanism holds); ROADMAP (~384 lines) → two-tier; PLAYBOOK.md retires (entries route to DECISIONS/gotchas/global profile); re-type live sprints' checkpoints (machine)/(human) while in there. Preserve originals as `-pre-v3.md`. Also seed Jumbo's `.claude/design.md` (feel parameters live in design/ui-design.md's worked example) — the design layer's first field test.

### brother-onboarding
He gets: the feedback doc (Downloads), install → `/bootstrap` on the legal-platform repo. Watch specifically: the plain-English trigger path ("help me finish my app"), the no-git fallback, question fatigue in bootstrap, whether the two-command story holds. His friction = the next field-fix wave. His report doubles as a ready-made ARCHITECTURE seed. (Resolved 2026-07-31: v3 merged to main early — he installs with the plain README clone line, no branch flag.)

### crosswalk-flags
Flag #6 is the realest (wrap writes the global profile but never reads it; cold /build may skip it — one clause each in entry/ground steps). #4: v2 had a "move your existing arch doc into .claude or leave a pointer?" ask that v3 cut; brother's repo (docs-heavy) may hit exactly this. #5: philosophical — command-less sessions get orientation but no working rules; fix costs per-session tokens; genuinely unsure.

### opus5-audit-followups
Pack audited vs the Opus 5 prompting guide (platform.claude.com/docs → prompting-claude-opus-5) 2026-07-30. Aligned already: scope guardrails, narration rules, doc-length caps. Parked calls: (1) scope fresh-context verifiers to [unknowns]/risky/unattended runs vs today's blanket dispatch — guide says Opus 5 self-verifies; field evidence (07-17) says verifiers catch real bugs; Stephen kept as-is, revisit after a Jumbo sprint on Opus 5; (2) add a when-to-delegate guardrail to /build (Opus 5 delegates more readily; pack has depth-cap but no when); (3) watch CORE's "audit each claim against a tool result" for double-verification symptoms before trimming.

### eval-loop
skill-creator plugin has the harness: define scenarios (does "help me finish my app" trigger bootstrap? does two-sprint wrap attribute correctly?), run with-skill vs baseline, grade, iterate. Do after brother onboarding supplies fresh failure cases.
