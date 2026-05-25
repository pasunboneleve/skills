---
name: coding
description: Use for every coding or script execution task. Applies to code edits and code reviews as well as tests builds validation debugging shell commands automation and blocked execution reports. Ensures exceptions are surfaced instead of muted.
---

If code execution is blocked by an exception, surface the exception. Do not mute exceptions.

Treat blocked code or script execution as a failed or incomplete validation run. Do not report validation as passed after an exception.

Do not replace a command with a guard branch that skips execution. Run the command and let missing configuration, subprocess errors, and runtime exceptions fail visibly.

Changing a guard branch from success to non-zero failure is still wrong when it skips the command that should have produced the exception.

Do not inline a script written in one programming language inside a script written in another programming language. Keep each language in its own file and invoke that file from the wrapper script.

Do not compose static multiline strings through consecutive function calls such as repeated append, write, add, or concatenation calls. When writing or reviewing code, reject that shape and use the language's idiomatic multiline string form, such as a heredoc, raw string literal, template literal, or triple-quoted string.

When modifying existing code that builds a static multiline string with repeated calls, rewrite the whole static value as one multiline string. Do not preserve or extend the repeated-call sequence.

Do not add machine-specific filesystem paths to scripts, code, configuration, or documentation unless the user explicitly asks for that exact path. Prefer repo-relative paths, source-relative paths, environment variables, or documented placeholders.

Source notes live in `references/notes.md`.
