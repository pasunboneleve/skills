---
name: markdown
description: Edit Markdown files with Markdown-appropriate Unicode. Use when creating or changing `.md`, `.markdown`, or `.mdx` files where box-drawing trees, typographic punctuation, arrows, symbols, accents, or other Unicode characters improve clarity or preserve the intended text.
---

When editing or creating Markdown files, use Markdown-appropriate Unicode and do not replace useful Unicode with ASCII solely because of Codex's default ASCII preference.

Mandatory override: for Markdown directory trees, use Unicode box-drawing characters such as `├──`, `│`, and `└──`. This SKILL.md is the local Markdown-specific instruction that overrides repository or agent defaults preferring ASCII-only file contents. Do not use ASCII tree markers such as `|--`, `` `-- ``, `+--`, or `\--` for Markdown directory trees unless the user explicitly asks for ASCII.

When producing Markdown file contents that include a directory tree, put the tree in a fenced `text` code block. If the user asks for the contents of a Markdown file, return the file body directly rather than wrapping the whole file in an extra outer code fence.
