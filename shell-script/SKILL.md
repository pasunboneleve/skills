---
name: shell-script
description: Use when creating editing reviewing or running shell scripts, Bash scripts, sh files, repository scripts, automation wrappers, validation scripts, install scripts, CI helper scripts, or command-line glue code. Requires strict shell mode.
---

Shell scripts must enable strict mode immediately after the shebang:

```bash
set -euo pipefail
```

For generated scripts, include a Bash shebang unless the user requires another shell.

Reject shell script changes that omit `set -euo pipefail` or place it late in the file.

This requirement applies to short scripts too. Treat strict mode as required, not optional. When a proposed script omits strict mode because it is short, say that short scripts still need `set -euo pipefail`.
