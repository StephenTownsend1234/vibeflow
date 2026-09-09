# Research brief: multi-chat wrap → next-session handoff

Written 2026-09-09 from a /start exploration. Question (Stephen): with two chats wrapping at the same time in one project, is `.last-session.md` the right thing for the next chat to start from, or should it read the most recent work instead? Evidence below is from the vibeflow pack, Jumbo's git history (`~/jumbo`), and Claude Code transcripts under `~/.claude/projects/`.

## Findings (ranked by how much they explain the felt problem)

### 1. In Jumbo the carry-forward never reaches the model — the hook truncates before it
`hooks/session-start.sh` emits sections in this order: PROJECT head → Map → roadmap top → sprint status → worktrees → hot areas → snapshot → `.last-session.md` → briefs → since-last-wrap. Total cap: 120 lines AND 16KB.
Run read-only against Jumbo today: output is exactly 16000 bytes, 86 lines, ending mid-roadmap. Section sizes: roadmap 7973 B (Now items are 300–600-char single lines; the awk prints whole lines), Map 6345 B, PROJECT 1642 B. **Sprint status, snapshot, last-session, briefs and since-last-wrap are never emitted** (`grep -c '^Sprint \|^--- Last session\|^Since last wrap'` on the output = 0).
This project (vibeflow) emits 6.5KB and shows everything, which is why it looks fine from here.

### 2. The harness now spills large hook output to a file, showing a 2KB preview
Every Jumbo SessionStart since 2026-08-26, and every havio-clinic one since 2026-09-03, is recorded as `<persisted-output> Output too large (15.4KB) … saved to …/tool-results/hook-…-stdout.txt` with a ~2KB preview (PROJECT.md's first lines). Smallest spilled hook output observed: 10KB; this session's 6.5KB came through inline. So the practical ceiling is ~9KB, not 16KB. Sessions partly recover by reading the spill file (5 of the 7 most recent Jumbo sessions did), but that costs a turn and the spill file still lacks the sections from finding 1. Two of seven recent Jumbo sessions never touched `.last-session.md` at all.

### 3. The merge-on-read fix (1bef5b0) works when wraps are sequential — the concurrent case is still a race
Evidence it works: 08-03 (11:43 / 12:05 / 17:08) and 09-08 (22:49 / 00:02) wraps each preserved the other chat's thread in the file ("(am session, wrapped separately…)", "Other chat (same day, wrapped 1037e4a, then kept going)"). Even the pre-fix 07-30 burst (four wraps in 15 min) merged by hand.
Structural gap: wrap reads the file in step 1 and writes it in step 4, minutes later. Two chats wrapping in the same window both read the pre-wrap file; the second write clobbers the first. Not observed post-fix, but it's the exact scenario Stephen describes ("wrapping 2 chats at the same time").

### 4. A digest is stale within minutes when a chat wraps and keeps going
09-08: the daily-loop chat wrapped at 22:49, then landed six more commits (7a7e865…e806e12, fb36837 at 00:02 after the other chat's wrap). The digest that described it was second-hand and out of date the moment it was written. Sprint files and git carried the real state.

### 5. Nothing tells a session that other chats are live
`/start` says to ask "any other sessions running right now?" only when parallel work looks likely — the model can't tell. Transcripts at `~/.claude/projects/<slug>/<session_id>.jsonl` are touched on every turn; a prototype hook line listing transcripts modified in the last 20 min (excluding this `session_id`, which the hook receives on stdin) found the two live Jumbo chats and labeled them from their first prompt. Caveat: the transcript format is documented as internal and version-unstable — a hook may use mtimes (stable) and must degrade to a bare count if the label parse fails.

### 6. Hook facts verified from the docs (code.claude.com/docs/en/hooks)
Every hook gets `session_id`, `transcript_path`, `cwd`, `hook_event_name` on stdin. SessionStart `source` ∈ startup/resume/clear/compact/fork; additionalContext can be returned as JSON `hookSpecificOutput.additionalContext` (untested whether that path avoids the spill — worth one experiment). SessionEnd `reason` ∈ clear/resume/logout/prompt_input_exit/other. No built-in concurrent-session detection.

## Prototype result
`scratchpad/session-start-proto.sh` (volatile-first order, per-section caps, 9000-byte total, live-chat line, last-36h commit subjects instead of a stat line) run read-only on Jumbo: 9000 bytes / 105 lines with every volatile section present; only the roadmap tail is cut. Ordering: one-line identity → sprint lines → other live chats → commits last 36h + uncommitted count → snapshot → carry-forward → briefs → PROJECT (1.6KB) → Map (2.6KB) → roadmap (2KB, lines cut at 220 chars).

## The design question, from first principles
What a fresh session needs, and who can supply it:
- Stable orientation (identity, Map, roadmap) — files; slow-changing; can be capped hard.
- Per-thread state — sprint files already are the per-thread layer; deterministic status lines.
- What shipped recently — git. Commit subjects in Stephen's projects are already a digest (`feat(sessions): …`). A synthesized restatement adds nothing and goes stale.
- What only the chat knew — unverified/undeployed, where iteration stalled, a decision mid-air, a pointer. This is the residue that must be written by hand, and it's the only part `.last-session.md` should hold.
- Who else is working right now — transcript mtimes.

So: the carry-forward should stop restating commits, and it should be keyed per wrap rather than rewritten as one digest.

## Options for the carry-forward file
**A. Ledger of per-wrap entries (recommended).** Each wrap adds its own dated `HH:MM · <thread>` block (thread = sprint name or "freebuild: <topic>"), ≤4 lines of non-derivable residue. Wrap never rewrites another chat's block; it re-reads the file immediately before writing (race window drops from minutes to milliseconds). The hook injects entries from the last ~36h newest-first under a byte cap; wrap drops entries older than 7 days. Same shape as CHANGELOG (already append-only, adopted 08-03). Single-chat behavior is unchanged in spirit: one entry, injected next session.
**B. Keep the single digest, close the race.** Re-read right before write, and narrow content to the residue. Cheapest; still leaves one chat writing second-hand claims about another chat's thread.
**C. No carry-forward file.** Sprint files + git + live-chat line only. Loses the only trace of a Freebuild session and the "where iteration stalled" line, which /wrap calls the most valuable line in the file. Rejected.

## Non-fork fixes (bugs, no alternative worth living with)
- Reorder the hook volatile-first; per-section caps; total ≤9KB. Try JSON `additionalContext` output once to see whether it dodges the spill; keep the cap regardless.
- Roadmap/Map lines cut at ~220 chars in the hook (the files stay as they are).
- Replace the "since last wrap" stat line with last-36h commit subjects (race-free: not relative to whichever chat wrapped last).
- Add the other-live-chats line; wrap uses it for attribution ("2 other chats live — leaving `payments/` as theirs").
- Briefs list capped to the 5 most recent.

## Proposed sprint (if A is picked)
1. Hook: reorder + caps + commits line + live-chat line (`hooks/session-start.sh`); verify read-only on Jumbo and vibeflow: <9KB, all sections present, live chats detected.
2. Wrap: ledger semantics in `wrap/SKILL.md` step 4 (own block, re-read before write, residue-only content, 7-day trim); update the ≤8-line wording.
3. Start: brief reads the live-chat line and, when others are live, asks which thread this chat is before re-grounding.
4. Bootstrap/update: refresh the hook copy in projects (the drift nudge already handles this); one line in `docs/v2-vs-v3-crosswalk.md` open flags.
5. Field test: next Jumbo double-wrap.
