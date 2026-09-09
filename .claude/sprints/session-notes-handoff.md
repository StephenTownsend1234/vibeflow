# Sprint: Session notes handoff

**Status:** planned 2026-09-09 · run mode: one-shot · 5/5 steps · on `main` · Jumbo hook refreshed (jumbo 93072ce)

## Goal
A fresh chat starts knowing what recent chats worked on, what's still open, and what to do next — even when several chats wrapped at once.

## Context
Stephen wraps two or more chats at a time on Jumbo. Findings (`.claude/research/multi-chat-handoff.md`): the hook emits the stable sections first and Jumbo's Map + roadmap alone hit the 16KB cap, so sprint lines and the carry-forward were never emitted; the harness spills hook output above ~10KB to a file with a 2KB preview (every Jumbo session since 2026-08-26); the single-digest `.last-session.md` is rewritten by whichever chat wraps and races when wraps overlap. Stephen's framing: a guide's note — "here's what we worked on lately, what's still open, what I think we should do next" — not a log of everything.

## Approach
Invert the hook to a recency layer under 9KB: sprint lines, other chats active now (transcript mtimes, degrade-to-nothing), commits from the last 36h, uncommitted count, snapshot, session notes, then a capped roadmap Now and Map. `.last-session.md` keeps its name but becomes a stack of short per-chat notes (`## <date time> · <thread>`, worked on / still open / next), prepended by each wrap, never rewritten by another chat, trimmed past 7 days; the hook shows the last 36h (minimum the newest). Chosen over a changelog (Stephen: no exhaustive log) and over dropping the hook (a fresh read costs ~32K tokens on Jumbo and can't see post-wrap commits, unwrapped sessions, or live chats).

## Ground truth
- `hooks/session-start.sh:12-25` emit PROJECT/Map/roadmap first; `:66-69` inject `head -8` of `.last-session.md`; `:108` caps at 120 lines / 16KB. Jumbo output today: 16000 B, no sprint/last-session/since-wrap lines.
- Hook stdin JSON carries `session_id` (docs: code.claude.com/docs/en/hooks). Transcripts live at `~/.claude/projects/<cwd with non-alphanumerics → '-'>/<session_id>.jsonl`, touched every turn; format undocumented.
- `wrap/SKILL.md:64` writes the ≤8-line digest with the merge rule; `start/SKILL.md:16-29` describe the injected sections and the brief template; `.claude/ARCHITECTURE.md:40` records the caps; `docs/v2-vs-v3-crosswalk.md:97,156` describe the file and the hook.
- Prototype (`scratchpad/session-start-v2.sh`) on Jumbo: 6.5KB with every section present.

## Plan
- [x] [NEW] Rewrite `hooks/session-start.sh` — recency-first order, per-section caps, 9KB total, live-chats line, 36h commits, session-notes window; verify `bash -n` + read-only runs on Jumbo and vibeflow (<9KB, all sections)
- [x] [NEW] `wrap/SKILL.md` step 4: prepend a ≤5-line session note, own chat only, re-read before write, trim >7 days
- [x] [NEW] `start/SKILL.md`: orientation list, live-chats handling, brief in the guide's shape (Lately / Sprints / Open / Next)
- [x] [NEW] Docs: ARCHITECTURE gotcha (9KB cap, spill), crosswalk rows 97 + 156
- [x] [NEW] Jumbo: refresh the hook copy, convert its `.last-session.md` to one note; commit by path

## Out of scope
- Promoting CHANGELOG to the pack templates (stays a dogfood experiment).
- JSON `additionalContext` output experiment (the byte cap alone fixes the spill).
- Statusline changes.

## Done criteria
- Jumbo and vibeflow orientation both under 9KB with sprint lines, commits, and notes present.
- Two wraps in one day produce two notes, neither overwriting the other.
