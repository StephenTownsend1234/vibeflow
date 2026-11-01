#!/usr/bin/env python3
"""Check that every fenced block in the two guides appears in a reference page.

Run from anywhere:  python3 -I ~/.claude/skills/vibeflow/prompting/check-quotes.py
Exit 0 when every block matches (byte-for-byte, or differing only in the
indentation a source page adds inside an accordion); exit 1 otherwise.
Re-run after refreshing anything in references/ or editing a guide.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent
GUIDES = ["prompt-writing-best-practices.md", "harness-best-practices.md"]
FENCE = re.compile(r"```[a-z]*\n(.*?)```", re.S)


def norm(text: str) -> str:
    text = re.sub(r"\n[ \t]+", "\n", text)
    return re.sub(r"[ \t]+", " ", text).strip()


raw = "\n".join(p.read_text() for p in sorted((ROOT / "references").glob("*.md")))
nraw = norm(raw)
exact = indent_only = missing = 0
for name in GUIDES:
    for match in FENCE.finditer((ROOT / name).read_text()):
        block = match.group(1).rstrip("\n")
        first = block.splitlines()[0][:70] if block else ""
        if block in raw:
            exact += 1
        elif norm(block) in nraw:
            indent_only += 1
        else:
            missing += 1
            print(f"MISSING  {name}: {first}")
print(f"exact {exact}, indentation-only {indent_only}, missing {missing}")
sys.exit(1 if missing else 0)
