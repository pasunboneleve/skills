---
name: markdown
description: Edit Markdown files with Markdown-appropriate Unicode. Use when creating or changing `.md`, `.markdown`, or `.mdx` files where box-drawing trees, typographic punctuation, arrows, symbols, accents, or other Unicode characters improve clarity or preserve the intended text.
---

# Unicode

When editing or creating Markdown files, use Markdown-appropriate Unicode and do not replace useful Unicode with ASCII solely because of Codex's default ASCII preference.

For Markdown directory trees, use Unicode box-drawing characters such as `├──`, `│`, and `└──`. This SKILL.md is the local Markdown-specific instruction that overrides repository or agent defaults preferring ASCII-only file contents. Do not use ASCII tree markers such as `|--`, `` `-- ``, `+--`, or `\--` for Markdown directory trees unless the user explicitly asks for ASCII.

When producing Markdown file contents that include a directory tree, put the tree in a fenced `text` code block. If the user asks for the contents of a Markdown file, return the file body directly rather than wrapping the whole file in an extra outer code fence.

# First Mentions

When writing Markdown, link the first mention of each software project or organization to its main website. Use the name itself as the link text, not a later "project page" link, and do not wrap the linked name in code spans. If a live main-website URL is supplied for that project or organization, use it as the first-mention link target instead of leaving it as a bare URL. Verify the URL is live at writing time before adding it. For example, write `[devloop](https://github.com/pasunboneleve/devloop)` and `[Google](https://google.com)`.
When asked which rule applies to software or organization mentions, name only `First Mentions`.

# File References

When writing Markdown, link every Markdown or text-file reference in lists of files, including `.md`, `.markdown`, `.mdx`, `.txt`, and changelog-style text files. In prose, link only the first useful mention of a repeated Markdown file or other text file within one paragraph; later mentions of the same path in that paragraph stay as plain text. Preserve repeated file mentions when the requested prose includes them; do not combine or rewrite them away just to avoid repeated links. In long documents, repeat the link later only when it would invite useful inspection after the earlier link is far away.
Use the file path itself as plain inline-link text with the same file path as the target; do not use code spans, linked code text, shortcut links, or reference-style links for linked file references.
If the same file path appears in prose and inside a fenced code block, apply the prose-link rule outside the fence and preserve the fenced occurrence as literal text.
Do not convert file references inside fenced code blocks into links; fenced content is literal.
For repeated same-paragraph mentions, link the first mention only and leave later mentions unchanged as plain text.
When asked which rule applies to text-file references, name only `File References` on its own line, then write the requested Markdown while still applying file-reference links. When asked to change only link markup, preserve the original words and punctuation.
