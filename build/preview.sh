#!/usr/bin/env bash
#
# Preview the docs locally at http://localhost:8000.
#
# Runs Zensical inside Docker because the sandbox can't pip-install it directly
# (no ensurepip). Pinned because Zensical is pre-1.0. Ctrl-C to stop.
#
# `zensical serve` returns HTTP 200 for ANY path (a fallback page), so confirm a
# page by its <title>/content, not the status code. A build clobbers public/
# (what serve uses) — restart serve after any build.
#
# Usage:  bash build/preview.sh
set -uo pipefail

ZENSICAL_VERSION="0.0.45"   # keep in sync with build.sh
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ROOT="$(cd "$ROOT" && pwd)"

# -w /docs is required for `zensical serve` to find the project.
docker run --rm -it -p 8000:8000 -v "$ROOT":/docs -w /docs python:3.13-slim sh -c "
  pip install --quiet --root-user-action=ignore zensical==${ZENSICAL_VERSION} &&
  zensical serve -a 0.0.0.0:8000
"
