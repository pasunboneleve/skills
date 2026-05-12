---
name: shell-script
description: Use when creating editing reviewing or running shell scripts, Bash scripts, sh files, repository scripts, automation wrappers, validation scripts, install scripts, CI helper scripts, or command-line glue code. Requires strict shell mode.
---

Shell scripts must enable strict mode immediately after the shebang:

```bash
set -euo pipefail
```

For generated scripts, include a Bash shebang unless the user requires another shell.

When asked for complete script contents, return a fenced `bash` code block containing the script. Put `set -euo pipefail` immediately after the shebang and before any executable command.

Preserve every requested command in generated scripts. If the user asks for `git status --short`, include `git status --short` exactly inside the script; do not replace it with a summary or a different status command.

For a requested `scripts/check-release.sh` that prints the current branch and then runs `git status --short`, use this shape:

```bash
#!/usr/bin/env bash
set -euo pipefail

git branch --show-current
git status --short
```

Reject shell script changes that omit `set -euo pipefail` or place it late in the file.

This requirement applies to short scripts too. Treat strict mode as required, not optional. When a proposed script omits strict mode because it is short, say that short scripts still need `set -euo pipefail`.
