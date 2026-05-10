#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_ROOT="${INSTALL_ROOT:-$HOME/.local}"
SKILL_VALIDATOR_VERSION="${SKILL_VALIDATOR_VERSION:-latest}"
export PATH="$INSTALL_ROOT/bin:$HOME/go/bin:$PATH"

ensure_skill_validator() {
  if command -v skill-validator >/dev/null 2>&1; then
    return 0
  fi

  if ! command -v go >/dev/null 2>&1; then
    printf 'error: skill-validator is not in PATH and go is unavailable to install it\n' >&2
    return 1
  fi

  mkdir -p "$INSTALL_ROOT/bin"
  GOBIN="$INSTALL_ROOT/bin" go install "github.com/agent-ecosystem/skill-validator/cmd/skill-validator@$SKILL_VALIDATOR_VERSION"
}

main() {
  ensure_skill_validator || return $?

  skill-validator check \
    --emit-annotations \
    --strict \
    --skip links \
    --allow-dirs agents,evals,examples,codex-home \
    --allow-flat-layouts \
    "$ROOT"
}

main "$@"
