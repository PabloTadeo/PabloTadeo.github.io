# pablotadeo.github.io

Personal academic portfolio of **Pablo Tadeo Ríos-Gallardo, PhD** — research at the intersection of
artificial intelligence, data science, applied statistics and exercise science.
Faculty of Sport Organization, Universidad Autónoma de Nuevo León, Monterrey, Mexico.

Live at <https://pablotadeo.github.io>

## Structure

```
.
├── index.html          single-file site: markup, styles, diagrams and the EN/ES engine
├── README.md
├── .gitignore
└── assets/
    ├── portrait.jpg            profile photograph (square, rendered as a circle)
    ├── figures/                key figures from published studies
    │   ├── skin-results.jpg
    │   ├── skin-setup-a.jpg
    │   ├── skin-setup-b.jpg
    │   └── skin-colorimetry.jpg
    └── media/                  photographic evidence for non-bibliographic claims
        └── marching-band.jpg
```

No build step, no dependencies, no package manager. GitHub Pages serves `index.html` directly.

## Local preview

```bash
python3 -m http.server 8000
# open http://localhost:8000
```

Opening `index.html` by double-click also works. Images resolve through relative paths, so the
`assets/` folder must sit next to `index.html`.

## Design system

| Token | Value | Use |
|---|---|---|
| `--navy` | `#0C2340` | UTSA blue. Headings, structure, footer, primary buttons |
| `--orange` | `#F15A22` | UTSA orange. Eyebrows, rules, accents, animated pulses |
| `--paper` | `#F5F5F7` | Alternating section bands |
| `--ink` | `#1D1D1F` | Body text |
| `--grey` / `--grey-2` | `#86868B` / `#6E6E73` | Secondary text |

Typography is the system stack (SF Pro on Apple devices). Headings run at weight 600 with negative
letter-spacing. Content column is capped at 1024 px.

## Adding content

**A publication.** Copy an existing `<article class="pub">` block into the right
`.pubgroup` (`published`, `accepted`, `review`, `prep`, `books`) and update the fields. Editorial
status groups must never be mixed. Update the counter in `.pubgroup__h span` and, if relevant, the
`.metric__n` values.

**A photograph.** Drop the file in `assets/media/` and reference it from an `.evidence` strip.
If the file is absent the thumbnail hides itself, so slots can be added before the image exists.

**A figure.** Drop it in `assets/figures/` and point a `.work__fig img` at it. Same graceful
degradation applies.

**A translation.** All Spanish strings live in the `PAIRS` array at the bottom of `index.html`,
as `["English", "Español"]`. The engine matches on normalised inner HTML, so the English string
must match the markup exactly. Article titles, journal names and author lists stay in English by
academic convention.

## Languages

English by default. The EN/ES switch is in the navigation bar. The site also honours the browser
language and the `#es` URL fragment. Chinese is planned and not yet implemented.

## Licence

Content and photographs © Pablo Tadeo Ríos-Gallardo. Brand icons in the contact section come from
Simple Icons (CC0); the LinkedIn glyph is drawn separately.
