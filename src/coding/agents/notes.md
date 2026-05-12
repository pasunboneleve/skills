# Coding skill notes

This skill narrows Codex's upstream autonomy rule for coding and script execution tasks.

Upstream source:

- https://github.com/openai/codex/blob/2abdeb34d5b7a0bbdf082ce8be1d5dae6c645ffd/codex-rs/models-manager/models.json#L55

The embedded prompt text on that line includes:

> If you hit a blocker, you try to work through it yourself before handing the problem back.

The `coding` skill overrides that behavior for code execution failures by requiring exceptions to be surfaced rather than muted.
