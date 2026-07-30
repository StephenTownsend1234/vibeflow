# Design references

Read when the work is visual — planning or building UI, generating an image or asset, or feedback that arrives as a feeling ("calmer", "more premium"). Not loaded at session start; these files serve intent, they don't precede it.

**The partner stance:** the user is not a designer and never needs to be. Don't ask them for design vocabulary — ask for feelings, references, and examples, do the translation yourself, and play the observables back for a yes/no. They say "calm and premium"; you answer "so: cream background, one accent, 12–16px radius, 300ms ease-out — like this?"

Two lanes share one core skill: replacing evaluative words with observable ones.

"Clean" is a verdict. It describes how the finished thing made someone feel. No model and no engineer can render a verdict. "Off-white background, one accent colour, generous margins, no texture" describes what is actually on the surface, and that can be built.

The whole skill is learning to look at a thing and say what is physically there.

## Which lane

| Situation | Lane | Why |
|---|---|---|
| Real product UI, anything with your exact brand hex values, anything that needs to be edited later | **Code** (`ui-design.md`) | Editable, versionable, exact |
| Photography, illustration, texture, collage, editorial header, mood, anything with a physical world in it | **Pixels** (`image-prompting.md`) | Models render texture and light that code cannot |
| A screen mockup for a pitch deck or landing page, not shipping | Either | Image is faster; code is reusable |

A UI screenshot generated as an image is a dead end. It cannot be corrected, the hex values will be approximately wrong, and the text will have subtle errors. Build UI as code.

## Files

- `vocabulary.md` — translation tables. Evaluative word in, observable description out. Read this first when stuck for words.
- `image-prompting.md` — generate template, edit/lock template, the reference-extraction workflow.
- `ui-design.md` — component decisions, interface states, flow, and how "feel" maps to numeric parameters.
- The project's `.claude/design.md` — its visual language: feel parameters, style templates, prompt log. Create it from `templates/design.md` on first design work; append to its log after any generation worth keeping.

## The one rule that governs both lanes

Before producing anything, name three things:

1. **The subject.** The literal object, screen, or scene. Concrete noun.
2. **The audience and the job.** Who sees it, what they should do or feel. Stating this does real work with reasoning image models: "this is for a high-end cookbook" steers composition and focus without further instruction.
3. **The one thing it must get right.** Everything else is negotiable.

If a brief cannot answer these, the output will be generic regardless of how many adjectives are stacked on top.

## Anti-patterns in both lanes

- **Adjective stacking.** "Stunning, cinematic, 8k, professional, modern" gives nothing to render or build. Each of those words should be replaced by a physical fact or deleted.
- **Regenerating instead of editing.** If a result is 80% right, describe the single change. Starting over discards the 80%.
- **Changing several things at once.** When three things change and the result is worse, which one broke it is unknowable. One change per pass.
- **Skipping the reference.** A reference image or an existing screen is worth more than any amount of description. Extract from it rather than describing from memory.

## Working style

Ship a rough version fast, then correct it with one targeted change at a time. Both lanes reward iteration over planning. The reference-extraction workflow in `image-prompting.md` exists to make the second, third, and tenth asset nearly free once the first one is right.
