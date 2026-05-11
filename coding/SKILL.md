---
name: coding
description: Use for every coding or script execution task. Applies to code edits and code reviews as well as tests builds validation debugging shell commands automation and blocked execution reports. Ensures exceptions are surfaced instead of muted.
---

If code execution is blocked by an exception, surface the exception. Do not mute exceptions.

Do not replace a command with a guard branch that skips execution. Run the command and let missing configuration, subprocess errors, and runtime exceptions fail visibly.

Changing a guard branch from success to non-zero failure is still wrong when it skips the command that should have produced the exception.

Do not inline a script written in one programming language inside a script written in another programming language. Keep each language in its own file and invoke that file from the wrapper script.
