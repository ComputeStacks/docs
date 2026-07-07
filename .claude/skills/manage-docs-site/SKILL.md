---
name: manage-docs-site
description: >-
  How to build, validate, edit, and publish the public ComputeStacks
  documentation site — the Zensical (successor to MkDocs Material) site in this
  repo. Use when asked to add/edit a page, change nav/theme/config, build or
  preview locally, or publish docs changes. Covers the site mechanics and the
  authoring conventions.
user-invocable: true
---

# The ComputeStacks documentation site

Single-brand, English-only static docs built with [Zensical](https://zensical.org)
(the successor to MkDocs Material, same team) using the **`modern`** theme.

| | |
|---|---|
| **Generator** | Zensical, pinned `0.0.45` (pre-1.0). Config is a **plain committed `zensical.toml`** (NOT a template — this site has no multi-brand/bilingual machinery, unlike the sibling `cloudpress-docs`). |
| **Content** | Plain Markdown in `docs/` — the source of truth. |
| **Build/serve** | Runs Zensical **inside Docker** (the sandbox can't pip-install it — no ensurepip). |
| **Deploy** | Not wired yet — the project is on GitHub, so GitHub Pages is the likely target. |

## Commands

```bash
bash build/preview.sh                                    # serve at :8000 (Ctrl-C to stop)
bash .claude/skills/manage-docs-site/scripts/build.sh    # strict build → non-zero on broken links/refs
python3 .claude/skills/manage-docs-site/scripts/check_placeholders.py docs   # angle-bracket scan
```

Always run **both** the strict build and the scanner before publishing. The strict
build catches broken internal links, unresolved refs, bad anchors, and bracket
link-references; it does **not** catch the angle-bracket bug (below) — the scanner does.

## Navigation is explicit

The `nav` array in `zensical.toml` defines the six tabs (Home · Getting started ·
Integrations · Admin guide · User guide · API reference) and every sub-section.
**Adding a page requires a `nav` edit** — a new file under `docs/` does not appear on
its own. Section labels are the quoted strings in `nav`; leaf labels come from each
page's `# H1`. TOML nav uses single-line inline tables; sub-sections nest as
`{ "Section" = ["a.md", "b.md"] }`. A section's index page (e.g. `api/uapi/index.md`)
is the first entry of its list (with `navigation.indexes`).

## Theme

Brand blue is **`#008fd5`** (the accent disk in the stacked-disk logo) — not a
Zensical named color, so the palette uses `primary/accent = "custom"` and the real
values live in `docs/stylesheets/extra.css`. Dark mode is the `slate` scheme with a
lighter dark-gray background ramp.

> **Modern-theme header gotcha:** the `modern` theme colors the header with
> `--md-default-bg-color--light` (a light surface in light mode, dark in dark mode),
> **not** the primary color (that's the `classic` theme). So the header logo must
> read on both a light and a dark background — use the **coloured** `img/logo.png`
> (grey disks + blue swoosh), not the white-line `img/logo-white.png` (which is kept
> as an alternate for a colored header). Favicon: `img/favicon.png`.

Fonts (Open Sans + JetBrains Mono) are **self-hosted** in `docs/fonts/` via
`docs/stylesheets/fonts.css` + `font = false`, so the built site makes no Google
Fonts requests.

## Markup gotchas (these misrender if ignored)

Zensical is a Markdown parser, so bare markup in prose breaks rendering:

1. **Angle brackets** — `<region>`, `Array<Object>` in prose parse as HTML tags and
   break the block. Always backtick them. The strict build does NOT catch this — run
   `check_placeholders.py` (it ignores real HTML tags like `<div>` used in card grids).
2. **Square brackets** — `[{ id }]` in prose parses as a link reference; the strict
   build flags it. Backtick bracketed examples.
3. **Admonition / collapsible bodies** — `!!! note`, `??? abstract "…"` bodies must be
   indented **4 spaces**, and there must be a **blank line before** the `!!!`/`???`
   marker (otherwise it's read as lazy continuation of the previous list/paragraph and
   renders as a nested list, not a collapsible).

## Authoring conventions (match the migrated pages)

- **Page title:** one `# H1`; sub-sections `##`/`###`.
- **API endpoints:** `## Title`, the route on its own line in backticks
  (`` `GET /api/users` ``), then `**OAuth authorization required**: `scope``, then
  collapsibles: `??? abstract "Schema"` and `??? example "Example"` (bodies +4 spaces).
- **Callouts:** `!!! note`, `!!! tip`, `!!! warning`, `!!! danger`, `!!! success`
  (bodies indented 4 spaces).
- **Card grids** (home, `api/index.md`): `<div class="grid cards" markdown> … </div>`
  (needs `attr_list` + `md_in_html`, both enabled).
- **Internal links:** relative Markdown paths; anchors are slugified headings.

## API reference scope

The API reference documents the **v8.0 API only** — `api/uapi/` (User API) and
`api/mapi/` (Manage API), each grouped by resource. The older v7.1 API is not
published here.

## Zensical reference

- Native TOML config under `[project]`; `[project.theme]` (features, palette,
  logo/favicon, `font`), `[[project.theme.palette]]` (one table per scheme),
  `[project.markdown_extensions.*]` — an explicit extension list **replaces** the
  defaults, so any feature the content uses must be listed.
- CLI: `zensical build [--strict]`, `zensical serve [-a IP:PORT]`.
- Live docs (fetch for current detail — Zensical is pre-1.0):
  `https://zensical.org/docs/` (authoring, setup, extensions).
