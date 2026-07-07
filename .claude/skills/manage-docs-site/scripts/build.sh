#!/usr/bin/env bash
#
# Strict-build the site with Zensical to validate it before publishing.
# `--strict` turns broken internal links + unresolved link references (e.g. an
# unbackticked `[ ... ]` in prose that Markdown reads as a link reference) into a
# non-zero exit. Runs inside a python image (the sandbox can't pip-install
# Zensical — no ensurepip), pinned to the version we ship.
#
# NOTE: a clean strict build does NOT catch the angle-bracket bug (`<guid>` in
# prose still *renders* wrong while *building* fine). Run the scanner too:
#   python3 .claude/skills/manage-docs-site/scripts/check_placeholders.py docs
#
# Usage:  bash .claude/skills/manage-docs-site/scripts/build.sh
set -uo pipefail

ZENSICAL_VERSION="0.0.45"   # keep in sync with build/preview.sh
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo .)"
if [ ! -f "$ROOT/zensical.toml" ]; then
  echo "error: no zensical.toml at repo root — run from the docs repo" >&2
  exit 2
fi
ROOT="$(cd "$ROOT" && pwd)"

docker run --rm -v "$ROOT":/docs -w /docs python:3.13-slim \
  sh -c "pip install --quiet --root-user-action=ignore zensical==${ZENSICAL_VERSION} && \
         zensical build --strict"
status=$?

# Build artifacts are root-owned (container runs as root); remove via docker so
# the working tree stays clean.
docker run --rm -v "$ROOT":/docs alpine \
  sh -c 'rm -rf /docs/public /docs/site /docs/.cache' >/dev/null 2>&1 || true

if [ "$status" -eq 0 ]; then
  echo "✅ strict build passed"
else
  echo "❌ strict build failed (exit $status) — see output above"
fi
exit $status
