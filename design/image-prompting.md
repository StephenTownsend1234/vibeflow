# Image Prompting

For any current image model, whatever tool it runs through.

Current-generation models reason about composition before rendering. They respond to a brief, not to keywords. Write like an art director talking to a photographer or illustrator, in full sentences.

---

## Template 1: Generate

Fill in what matters, skip what does not. Order roughly as written.

```
SUBJECT      The literal thing, in concrete terms.
ACTION       What it is doing, if anything.
SETTING      Place, time of day, quality of light in the room.
STYLE        The medium and finished look. Name the medium.
COMPOSITION  Framing, angle, lens behaviour.
LIGHTING     Where the light comes from, how it falls off.
COLOUR       Palette and grade.
TEXT         Any words on the image, in quotes, with position and typeface class.
PURPOSE      Who this is for. One sentence.
CONSTRAINTS  What must stay out. "no X, no Y, no Z."
```

Worked example, product:

> A matte-black stainless steel insulated water bottle, 750ml, slim cylindrical body with a brushed metal cap. Standing upright on a wet slate countertop, a few condensation droplets sliding down its side, mid-morning. In a quiet kitchen by a north-facing window, soft overcast daylight from the left. Photoreal, high-end commercial product photography. Tight three-quarter hero shot, slightly below eye level so the bottle feels tall, 85mm at f/8 so the product stays sharp while the background falls into soft blur. One large softbox from the left with a subtle reflector right. Cool desaturated grade, clean neutral whites, faint blue cast in the shadows. The words "STAY COLD. 24 HOURS." in small caps along the lower third. This is for a premium DTC brand's landing page. No other props, no hands, no visible logos, no harsh specular hotspots on the metal.

Worked example, editorial header:

> An editorial collage combining a cropped photograph of a hand holding a paper energy meter, torn-paper shapes in sage and cream, and thin hand-drawn line work. Off-white paper background with visible grain. Asymmetric composition, the hand entering from the lower left, generous negative space in the upper right. Flat even lighting as if scanned. Limited palette of dark green, sage, cream, and one warm amber accent. This is a header image for a long-form article about energy pacing in chronic illness, and it needs to feel calm rather than clinical. No text, no faces, no medical iconography, no gradients.

### The purpose line does real work

Stating who the image is for steers a reasoning model's planning step more efficiently than several more adjectives. "This is for a high-end cookbook" produces shallow focus and careful plating without asking for either.

---

## Template 2: Edit an existing image

This is the one that matters most when working from references. Drift happens the moment description of what stays is dropped.

```
LOCK         Everything that must not move. Be exhaustive. Repeat on every pass.
CHANGE       The single thing being altered.
AMOUNT       How far to take it.
CONSTRAINTS  What the edit must not break.
```

Worked example:

> **Lock:** the water bottle, matte-black finish, brushed cap, slim cylindrical body, the "STAY COLD. 24 HOURS." text, the condensation droplets, its size and position in frame, and the three-quarter hero angle.
> **Change:** swap the kitchen-counter background for a flat grey boulder beside a sunlit mountain hiking trail.
> **Amount:** full environment swap, understated. Soft natural daylight, not golden hour. Bottle looks shot on location, not composited.
> **Constraints:** do not relight or recolour the bottle beyond the new ambient light. No new reflections or hotspots on the metal. Keep the original cool grade. Do not touch the cap, droplets, or text. No hands, people, or gear in frame.

### Rules for editing

- **One change per message.** Ten stacked edits make it impossible to know which one broke the image.
- **Repeat the lock list every pass.** It is not remembered across turns as reliably as expected.
- **Never regenerate a result that is 80% right.** Describe the delta instead.
- **Lock the face first** when people are involved, before anything else.

---

## Template 3: Extract a style from a reference

The highest-leverage workflow. Turns one image that works into a template that produces twenty more.

Feed the reference image to a text model (Claude, GPT) and ask it to describe **only the qualities to preserve**, naming those qualities explicitly. Vagueness in the extraction request produces a vague template.

```
Write a system prompt that would recreate an image similar to the attached one.

Describe in detail:
- the medium and technique
- the composition and how elements are arranged in the frame
- the illustration or photographic style
- the colour application and palette
- the texture and finish
- the treatment of negative space

Do NOT describe the specific subject matter. The subject will be replaced.
Write it as reusable instructions, not as a caption.
```

The output is long. That is correct. It becomes the style template.

### Then vary the subject

```
Adjust the following prompt to the subject matter described in the attached
context. Give me three numbered options, each depicting a different object
and composition. Keep the medium, colour treatment, and style exactly as
specified below.

---
[paste the extracted style template here]
```

Render each of the three separately and pick. Three is the right number: enough to compare, few enough to judge.

### Why this beats describing from scratch

Describing a visual style from memory produces the average of everything similar the model has seen. Extracting it from a specific image produces that image's specific rules. This is how visual consistency is maintained across a series without a designer.

---

## Reference images

Current models accept multiple references in a single generation, and hold resemblance for several people across generations. Feeding one reference when several are available leaves control unused.

Useful combinations:
- One reference for composition, one for colour palette, one for texture
- Several angles of the same subject for consistency
- A rough sketch or wireframe as layout, plus a style reference

State what each reference is for: "use the first image for layout, the second for colour treatment only."

---

## Debugging bad output

| Symptom | Likely cause | Fix |
|---|---|---|
| Looks generic, "obviously AI" | Adjective-heavy prompt, model filled the gaps | Add physical facts: specific light, one imperfection, a named medium |
| Right idea, wrong mood | Style word not pinned to colour or light | Replace "cinematic" with a named grade and light direction |
| Text is wrong or misspelled | Text not quoted or not positioned | Wrap in quotes, name the position and typeface class, say "text must be sharp and correctly spelled" |
| Edit broke something else | Lock list too short | Enumerate everything that stays, then re-issue |
| Series is inconsistent | Prompting each image from scratch | Extract a style template from the first good one |
| Too busy | No constraints given | Add "no X, no Y" and specify negative space |

---

## Phrases that reliably work / fail (starter list)

A generic seed. The project's own list lives and grows in its `.claude/design.md` prompt log.

**Work:**
- `soft overcast light` — reliable for calm, non-dramatic
- `raking across` — for directional light that reveals texture
- `deep falloff into shadow` — for high-contrast, most of frame dark
- `visible paper grain` / `slightly misregistered ink` — for print authenticity
- `this is for [context]` — steers composition without further instruction

**Fail:**
- `stunning`, `masterpiece`, `8k`, `high quality` — no effect, or a generic pull
- `modern` alone — drifts by decade
- `professional` alone — produces stock photography
- Stacking more than two style adjectives without a colour or light fact
