# Design

<!--
The project's visual language — the design state every session inherits, so "make it
feel right" stops being re-decided from scratch. Created on FIRST design work (a
user-facing sprint, an asset ask), not at bootstrap — not every project is visual.

Rules that keep this file useful:
- Parameters and templates live here; a genuine design fork with a real alternative
  (and its why) still goes to DECISIONS like any other decision.
- Append to the prompt log after any generation worth keeping — failures included;
  a failure names the gap between the words used and the thing wanted.
- Promote a log entry to Style templates once it produces a consistent series.
- Craft references live in the pack (`design/` next to CORE.md): vocabulary
  translation, UI component tables, prompting templates. This file is only what's
  specific to THIS project.
-->

## Feel

| Density | Contrast | Radius | Motion | Copy register |
|---|---|---|---|---|
| <4px tight / 8px open> | <low / medium / high> | <0–full-round> | <duration + easing> | <terse ↔ conversational; in whose voice> |

<One sentence naming the feel target and the constraint that drives it — e.g.
"calm, restful: users are exhausted; cognitive load is the binding constraint.">

## Style templates

<!-- Extracted style prompts that produce consistent series. One per visual language, not per image. -->

### <name>
**Used for:** <surface — e.g. article headers, app store screenshots>
**Source reference:** <file or description of the image it was extracted from>

```
<the extracted style prompt>
```

**Holds up for:** <subjects it works with>
**Breaks on:** <subjects it does not work with>

## Prompt log

<!-- Four lines per entry. Newest first. -->

### <YYYY-MM-DD> — <what it was for> — <model/tool>
**Prompt:** <the actual text, verbatim>
**Result:** worked / partly / failed
**Note:** <what to change next time, or which phrase did the work>
