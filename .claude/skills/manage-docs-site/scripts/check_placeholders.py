#!/usr/bin/env python3
"""Scan MkDocs Markdown for unescaped <...> angle-bracket placeholders.

Python-Markdown parses a bare ``<word>`` (e.g. ``<guid>``, ``<token>``,
``Array<Object>``) in prose / tables / list items as an HTML tag, which breaks
list nesting and rendering. They are only safe inside a backtick code span or a
fenced ``` code block. This script strips code spans and fences, then flags any
remaining angle-bracket placeholders so they can be backticked before pushing.

Usage:
    python3 check_placeholders.py [DOCS_DIR]   # default: ./docs

Exits non-zero if any potential violations are found.
"""
import re
import sys
import pathlib

docs_dir = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "docs")
if not docs_dir.exists():
    print(f"error: {docs_dir} does not exist", file=sys.stderr)
    sys.exit(2)

# Real HTML tags intentionally used in Markdown (e.g. the `md_in_html` card
# grids) are NOT placeholders — skip them. Everything else (`<guid>`,
# `Array<Object>`, `<region>`) is a bare placeholder that must be backticked.
HTML_TAGS = {
    "div", "span", "figure", "figcaption", "img", "br", "hr", "a", "p", "pre",
    "code", "em", "strong", "b", "i", "u", "sub", "sup", "mark", "kbd", "small",
    "ul", "ol", "li", "dl", "dt", "dd", "table", "thead", "tbody", "tr", "td",
    "th", "details", "summary", "section", "nav", "blockquote", "iframe", "video",
    "source", "h1", "h2", "h3", "h4", "h5", "h6", "!--",
}


def tag_name(frag):
    return re.sub(r"^</?", "", frag).split()[0].rstrip(">/").lower() if frag.strip("<>/ ") else ""


bad = []
for f in sorted(docs_dir.rglob("*.md")):
    in_fence = False
    for i, line in enumerate(f.read_text().split("\n"), 1):
        if re.match(r"^\s*```", line):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        # drop inline code spans, then look for <word...> placeholders/types
        stripped = re.sub(r"`[^`]*`", "", line)
        for m in re.finditer(r"<[A-Za-z/!][^>]*>", stripped):
            if tag_name(m.group(0)) in HTML_TAGS:
                continue
            bad.append((str(f), i, m.group(0), line.strip()))

if bad:
    print("POTENTIAL BARE ANGLE-BRACKET PLACEHOLDERS (wrap these in backticks):")
    for fn, ln, frag, full in bad:
        print(f"  {fn}:{ln}  {frag!r}   | {full[:100]}")
    sys.exit(1)

print(f"CLEAN: no bare <...> placeholders outside code spans/fences under {docs_dir}")
