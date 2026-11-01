# Prompting references

Read when a project sends prompts to the Claude API: writing or editing a system prompt, or building and changing the code that calls the model. Not loaded at session start; these files serve that work, they don't precede it. Covers Claude Fable 5.1 (and Mythos 5.1, which shares its prompting page), Opus 5.5, Sonnet 5.5, and Haiku 5.5 only.

## Which guide

| Work | Read | Why |
|---|---|---|
| Writing, editing, or auditing text the model reads: a system prompt, a tool description, an example, an injected-data wrapper | `prompt-writing-best-practices.md` | Principles, prompt anatomy, per-model notes with Anthropic's measured text verbatim, a ship checklist |
| Writing or changing the code around the call: request settings, response parsing, conversation history, tool loops, progress rendering, unattended runs, compaction | `harness-best-practices.md` | A per-model settings matrix, the rules that keep a conversation valid and cached, what to do with tool results and mid-turn input, a build checklist |
| Checking a claim in either guide, or something neither covers | `references/` | The nine Anthropic pages, verbatim, each with its source URL in its frontmatter |

The boundary between the two guides: text the model reads is in the prompt guide; anything enforced in code is in the harness guide. Items that straddle, such as the autonomy block that only makes sense in an unattended loop, are cross-referenced rather than repeated. Most builds need both: a silent agent, a skipped tool call, and an ignored mid-task message all look like prompt problems and are usually harness problems.

## Wiring a project

Two lines in the project's `CLAUDE.md`:

```
Before writing, editing, or auditing a prompt sent to the Claude API, read ~/.claude/skills/vibeflow/prompting/prompt-writing-best-practices.md.
Before writing or changing code that calls the Claude API (request settings, response parsing, conversation history, tool loops), read ~/.claude/skills/vibeflow/prompting/harness-best-practices.md.
```

Keep the project's own material in the project: its worked example, where its prompts live, the provenance of each rule, and its eval guide. The guides here are shared across projects and carry nothing project-specific.

## Keeping it current

Both guides were distilled on 2026-11-01. The model pages go stale at each model release. To refresh: re-download each page in `references/` from the URL in its frontmatter, diff against the stored copy, carry any change into the guide that owns it, then run `python3 -I check-quotes.py` from this folder; it confirms every quoted block in both guides still appears in a reference. Where a guide and a reference disagree, the reference wins. Cells and lines marked † in the harness guide come from Anthropic pages that are not in `references/` (the per-model migration guides and "What's new" pages); verify those there.

## Files

- `prompt-writing-best-practices.md`: how a good prompt reads, anatomy, model notes (Fable 5.1, Opus 5.5, Sonnet 5.5, Haiku 5.5), blocks from the general page, keeping a prompt alive, ship checklist.
- `harness-best-practices.md`: settings matrix and effort, reading the response, conversation validity and caching, tool results and mid-turn input, progress and silence, long and unattended runs, input handling and vision, build checklist.
- `references/claude-prompting-best-practices.md`: the general page for all current models.
- `references/prompting-claude-fable-5-1.md`, `prompting-claude-opus-5-5.md`, `prompting-claude-sonnet-5-5.md`, `prompting-claude-haiku-5-5.md`: the per-model pages.
- `references/guardrails-mitigate-jailbreaks.md`, `guardrails-reduce-prompt-leak.md`, `guardrails-increase-consistency.md`, `guardrails-reduce-latency.md`: Anthropic's *Strengthen guardrails* pages. The jailbreak page is the source for the harness guide's injection section; the others contribute single items to each guide.
