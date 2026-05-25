# Markdown skill notes

This skill narrows Codex's upstream ASCII editing preference for Markdown files.

Upstream source:

- https://github.com/openai/codex/blob/2abdeb34d5b7a0bbdf082ce8be1d5dae6c645ffd/codex-rs/core/gpt_5_codex_prompt.md#L9

The prompt line says to default to ASCII when editing or creating files.

The `markdown` skill overrides that behavior for Markdown files when Unicode improves clarity or preserves intended text.
