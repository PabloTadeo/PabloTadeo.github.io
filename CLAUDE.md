# Project context for Claude Code

Personal academic portfolio for **Pablo Tadeo Ríos-Gallardo, PhD**. Read this before editing.

## What this site is for

A strategic academic portfolio aimed at a faculty position in **Artificial Intelligence, Data
Science and Statistics** in Kinesiology. Every section must answer: *does this demonstrate AI, data
science, statistics, exercise science, teaching, mentorship, or the intersection of them?* If it
does not, it gets reframed, relocated, or removed.

The narrative is **not** "I measure athletes with technology". It is: *AI- and data-driven solutions
at the intersection of artificial intelligence, data science, statistics and exercise science, to
solve real problems in human performance, education and health.* Sport technology is the
application, not the identity.

## Hard rules

1. **The surname is always `Ríos-Gallardo`** — accent on the í, hyphenated. No exceptions,
   anywhere: markup, metadata, alt text, commit messages.
2. **No emojis.** Anywhere.
3. **Never overstate editorial status.** `Published`, `Accepted`, `Under peer review` and
   `In preparation` are distinct and must never be blended. The patent is *in preparation*, not
   filed — do not write "patent pending" or "patent filed".
4. **Never invent data.** No statistics, DOIs, dates, co-author names, URLs or profile links that
   were not supplied. If something is missing, leave the slot empty and flag it.
5. **No secrets in the repo.** No tokens, keys or credentials, not even in comments. Authenticate
   with `gh auth login` or SSH.
6. **Article titles, journal names and author lists stay in English** in every language version.

## Architecture

Single `index.html`: styles in one `<style>` block, content, then two `<script>` blocks
(interaction, then the i18n engine). No framework, no build, no dependencies. GitHub Pages serves it
as-is. Keep it that way — the value of this repo is that it has no toolchain to rot.

## Design system

Apple-style restraint on a UTSA palette. `--navy #0C2340` carries structure; `--orange #F15A22` is
the accent and appears only in small doses: eyebrows, the 56 px rule under each heading, metric top
bars, list bullets, animated pulses, editorial-status pills. System font stack, weight 600 headings
with negative letter-spacing, 1024 px content column, alternating white and `--paper` bands.

Photographs render greyscale at rest and recover colour on hover. Diagrams are hand-written inline
SVG using the CSS custom properties — never raster, never an external library. All motion respects
`prefers-reduced-motion`. There is a print stylesheet: the page doubles as a printable CV.

## Graceful degradation for images

Any `.evidence img`, `.work__fig img` or `.beyond__photo img` that fails to load hides its own
container, and an evidence strip with no surviving thumbnails hides itself. This is deliberate:
image slots can be committed before the image exists. Preserve this behaviour.

## Common tasks

- **New publication** → copy an `<article class="pub">` into the correct `.pubgroup`, update
  `.pubgroup__h span` counter and the `.metric__n` figures. Add a one-line `.pub__hl` highlight;
  prefer real numbers over description.
- **New translation string** → append a `["English","Español"]` entry to `PAIRS` at the bottom of
  the file. The English side must match the element's inner HTML exactly (whitespace is normalised).
- **Still pending**: Spanish for the `.entry` blocks (Teaching, Funding, Service, Education,
  Presentations) and the 25 `.agent p` descriptions; Chinese version; figures for selected work
  cards 02 and 03; the Shiny teaching app and the ML-Asymmetries repository in the ecosystem
  section.

## Tone

Direct, concrete, no filler. Short declarative headings. Never promotional. When a result has a
caveat — for example the systematic bias in the AI jump height study — state it. Declaring a
limitation demonstrates judgment; hiding one that a reviewer will find in the figure does the
opposite.
