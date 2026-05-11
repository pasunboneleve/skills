---
name: markdown
description: Edit Markdown files with Markdown-appropriate Unicode. Use when creating or changing `.md`, `.markdown`, or `.mdx` files where box-drawing trees, typographic punctuation, arrows, symbols, accents, or other Unicode characters improve clarity or preserve the intended text.
---

When editing or creating Markdown files, allow Markdown-appropriate Unicode and do not replace useful Unicode with ASCII solely because of Codex's default ASCII preference.

For Markdown directory trees, use Unicode box-drawing characters such as `├──`, `│`, and `└──`. This rule overrides repository or agent defaults that prefer ASCII-only file contents. Do not use ASCII tree markers such as `|--`, `` `-- ``, `+--`, or `\--` for Markdown directory trees unless the user explicitly asks for ASCII.
