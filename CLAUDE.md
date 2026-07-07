# CLAUDE.md

Guidance for Claude Code (claude.ai/code) working in this repository.

This repo builds the **public ComputeStacks documentation site** with
[Zensical](https://zensical.org) — the successor to MkDocs Material, by the same
team, using its **`modern`** theme. ComputeStacks is an open-source container
platform for service providers (<https://github.com/ComputeStacks>).

Content is plain Markdown in `docs/`.

## How this differs from the CloudPress docs site

If you know the sibling `cloudpress-docs` repo: this one is deliberately **simpler**.
It is **single-brand, single-language**, so there is **no** token template, no
`build/render.py`, no `brands/`, no `i18n/`. The config is a **plain committed
`zensical.toml`** built directly. Do not add that machinery unless the site
actually becomes multi-brand or multi-language.

## Commands

The sandbox can't `pip install` (no ensurepip), so everything runs Zensical inside
Docker, pinned (Zensical is pre-1.0).

- **Preview** at <http://localhost:8000> (Ctrl-C to stop):
  ```bash
  bash build/preview.sh
  ```
- **Strict build / validate** (broken links + unresolved refs → non-zero exit):
  ```bash
  bash .claude/skills/manage-docs-site/scripts/build.sh
  ```
- **Angle-bracket scan** (a clean strict build does NOT catch this — see gotchas):
  ```bash
  python3 .claude/skills/manage-docs-site/scripts/check_placeholders.py docs
  ```

## Navigation is explicit

The `nav` array in `zensical.toml` defines the tabs (Home · Getting started ·
Integrations · Admin guide · User guide · API reference) and all sub-sections.
**Adding a page requires a `nav` edit** — a new file under `docs/` does not appear
on its own. Leaf labels come from each page's `# H1`; section labels are the
quoted strings in `nav`.

## Theme

Brand blue is **`#008fd5`** (the accent disk in the stacked-disk logo). It isn't a
Zensical named color, so the palette uses `primary/accent = "custom"` and the real
values live in `docs/stylesheets/extra.css` (the supported `--md-*` override layer).
Dark mode uses the `slate` scheme with a lighter dark-gray background ramp. Fonts
(Open Sans + JetBrains Mono) are **self-hosted** in `docs/fonts/` (via
`docs/stylesheets/fonts.css` + `font = false`) so the built site makes no Google
Fonts requests. Logo/favicon are in `docs/img/` (`logo-white.png` is the header
mark; `logo.png` is a coloured variant kept for a light header).

## Markup gotchas (these misrender if ignored)

Zensical is a Markdown parser, so bare markup in prose breaks rendering:

- **Angle brackets:** `<region>`, `Array<Object>` in prose parse as HTML tags.
  Always backtick them. A strict build does **not** catch this — run
  `check_placeholders.py`. (Schema types in the API pages are already backticked.)
- **Square brackets:** `[{ id }]` in prose parses as a link reference; the strict
  build flags it. Backtick bracketed examples.
- **Admonition / collapsible bodies** (`!!! note`, `??? abstract "…"`) must be
  indented **4 spaces**, or the body leaks out of the block.

## API reference scope

The API reference publishes the **v8.0 API only** (`api/uapi/` = User API,
`api/mapi/` = Manage API). The older v7.1 API is not documented here.

## Deploy

Not wired yet. The project lives on GitHub, so GitHub Pages (a Zensical build
Action publishing `public/`) is the likely target — add it when the host is decided.
