# Architecture

## Map

**What this repo is:** a Claude Code skill pack. Plain-language instruction files + templates + shell hooks. No build, no dependencies; "deploying" = git.

**Where things live:**
```
CORE.md                 shared layer: role, guiding principle, Decision card,
                        communication rules, file routing rules, global profile
<cmd>/SKILL.md          the five skills (bootstrap/start/build/wrap/roadmap),
                        each ~45-90 lines, frontmatter = trigger surface
start/references/       sprint-md-shape.md (the sprint template) · sequencing.md
bootstrap/references/   migrate-v1.md (→v2 shapes) · migrate-v2-to-v3.md
roadmap/references/     background-routine.md (Ship Captain + autonomous Spotter)
design/                 design references — lane picker (README), vocabulary
                        translation, ui-design, image-prompting; read on visual
                        work per CORE's Design section (no SKILL.md = never a skill)
templates/              the project-state file shapes (incl. design.md) + global-profile.md
hooks/                  session-start.sh (orientation) · session-snapshot.sh
                        (SessionEnd/PreCompact breadcrumb) · statusline.sh
docs/                   v2-vs-v3-crosswalk.md · how-vibeflow-works.md
setup / update          installer (symlinks each cmd dir into ~/.claude/skills/)
.claude/                THIS project's own vibeflow state (dogfood)
```

**Key patterns:** principles over choreography; hard explicit boundaries only where the path is fragile; every skill reads CORE first; progressive disclosure (references load only when their stage fires); all shared text lives exactly once, in CORE.

**Run & verify:** edit a SKILL.md → it hot-reloads on next invocation (symlinks make the working tree live). Real verification = run a session on Jumbo and watch the behavior. Hooks: `bash -n` then run with `CLAUDE_PROJECT_DIR=<project>` against Jumbo (read-only).

## Detail

### Distribution model
`setup` symlinks each command dir (any dir containing SKILL.md) into `~/.claude/skills/`. Consequence: **the checked-out branch is live everywhere, immediately** — an edit on the checked-out branch changes behavior in every project on this machine. Remote: GitHub `StephenTownsend1234/vibeflow`; **main = v3** since the 2026-07-31 fast-forward merge, and development happens on main directly. The pre-v3 tree is preserved as tag `v2` (`git checkout v2` to revert). The README's plain clone now installs v3 with no `--branch` flag.

Skills are symlinks (always current after `update`), but **hooks are per-project copies** installed by /bootstrap — they age silently. Two mechanisms in `session-start.sh` cover this: a weekly update ping (`ls-remote` against the installed branch, ISO-week stamp in `.last-update-check`) and a per-session drift check (`cmp` of the project's hook copies vs the pack) that prints a nudge line — never overwrites, since a differing copy may be deliberate customization.

### Gotchas / learnings
- **Markdown format-on-save destroys YAML frontmatter** (turns `name:` into a `## name:` heading and strips the closing `---`), silently unregistering the skill — it shows a blank description in the skills list. Happened 2026-07-15 to bootstrap. Exclude SKILL.md from formatters, and check `head -4` after editing in an external editor.
- **The hook's output caps are load-bearing:** 120 lines / 16KB total; `.last-session.md` injects only `head -8` (wrap must keep it ≤8 lines); the Map extraction is exact-match `^## Map$`. Anything appended to hook output must fit inside the caps.
- **Skill frontmatter is the auto-trigger surface** — descriptions carry plain-English triggers on purpose ("help me finish my app" → bootstrap). Rewording a description changes triggering behavior; treat it as an interface, not prose.
- **`python heredoc && git commit` chains can commit even when the script fails** (observed 2026-07-15) — commit as a separate command after verifying the edit landed.
- Wrap-commit detection greps `docs(wrap):` exactly; projects with only older `wrap:` commits measure "since last wrap" from further back until their first v3 wrap. Self-healing.
