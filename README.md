# ComputeStacks Documentation

The public documentation site for [ComputeStacks](https://github.com/ComputeStacks)
— the open-source container platform for service providers — built with
[Zensical](https://zensical.org), the successor to MkDocs Material.

Content is plain Markdown under `docs/`. The site is single-brand and
English-only, so the configuration is a single committed `zensical.toml` (no
templating).

## Run locally

Zensical runs inside Docker (pinned, since it is pre-1.0), so no local Python setup
is needed:

```bash
bash build/preview.sh          # serve at http://localhost:8000 (Ctrl-C to stop)
```

## Validate

```bash
# strict build — broken links / unresolved references fail the build
bash .claude/skills/manage-docs-site/scripts/build.sh

# scan for bare <angle-bracket> placeholders (the strict build misses these)
python3 .claude/skills/manage-docs-site/scripts/check_placeholders.py docs
```

## Structure

```
zensical.toml   # Zensical config + explicit nav (adding a page => edit nav)
docs/           # Markdown content
  index.md              # home (card-grid router)
  getting-started/      # architecture + installation
  integrations/         # webhooks
  admin-guide/          # billing, data management, platform management
  user-guide/           # backups, dev tools, concepts, how-tos, image docs
  api/                  # v8.0 API reference: uapi/ (User API), mapi/ (Manage API)
  img/ fonts/ stylesheets/
build/preview.sh                       # local Docker preview
.claude/skills/manage-docs-site/       # maintenance skill + scripts
  scripts/build.sh                     # strict build (Docker)
  scripts/check_placeholders.py        # angle-bracket scanner
```

## Maintaining the docs

See `.claude/skills/manage-docs-site/SKILL.md` for the build/validate mechanics, the
navigation rules, the Markdown gotchas, and a Zensical config reference.
