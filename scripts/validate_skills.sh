#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_ROOT="${INSTALL_ROOT:-$HOME/.local}"
SKILL_VALIDATOR_VERSION="${SKILL_VALIDATOR_VERSION:-latest}"
AGENT_SKILLS_EVAL_VERSION="${AGENT_SKILLS_EVAL_VERSION:-latest}"
AGENT_SKILLS_EVAL_API_KEY_ENV="${AGENT_SKILLS_EVAL_API_KEY_ENV:-OPENAI_API_KEY}"
AGENT_SKILLS_EVAL_BASE_URL="${AGENT_SKILLS_EVAL_BASE_URL:-https://api.openai.com/v1}"
AGENT_SKILLS_EVAL_TARGET="${AGENT_SKILLS_EVAL_TARGET:-gpt-4o-mini}"
AGENT_SKILLS_EVAL_JUDGE="${AGENT_SKILLS_EVAL_JUDGE:-$AGENT_SKILLS_EVAL_TARGET}"
AGENT_SKILLS_EVAL_WORKSPACE="${AGENT_SKILLS_EVAL_WORKSPACE:-${TMPDIR:-/tmp}/agent-skills-eval-skills}"
AGENT_SKILLS_EVAL_MIN_DELTA="${AGENT_SKILLS_EVAL_MIN_DELTA:-0.20}"
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

ensure_eval_validator() {
  if command -v agent-skills-eval >/dev/null 2>&1; then
    return 0
  fi

  if command -v bun >/dev/null 2>&1; then
    bun add -g "agent-skills-eval@$AGENT_SKILLS_EVAL_VERSION"
    return $?
  fi

  if command -v npm >/dev/null 2>&1; then
    npm install -g "agent-skills-eval@$AGENT_SKILLS_EVAL_VERSION"
    return $?
  fi

  printf 'error: agent-skills-eval is not in PATH and neither bun nor npm is available to install it\n' >&2
  return 1
}

run_eval_validator() {
  local status=0
  local run_workspace

  run_workspace="$(mktemp -d "${AGENT_SKILLS_EVAL_WORKSPACE%/}.XXXXXX")" || return $?

  agent-skills-eval "$ROOT" \
    --workspace "$run_workspace" \
    --baseline \
    --target "$AGENT_SKILLS_EVAL_TARGET" \
    --judge "$AGENT_SKILLS_EVAL_JUDGE" \
    --base-url "$AGENT_SKILLS_EVAL_BASE_URL" \
    --api-key-env "$AGENT_SKILLS_EVAL_API_KEY_ENV" \
    --strict \
    --no-report || status=$?

  check_eval_deltas "$run_workspace" || status=$?
  return "$status"
}

check_eval_deltas() {
  local workspace="$1"
  local js_runtime

  if command -v node >/dev/null 2>&1; then
    js_runtime=node
  elif command -v bun >/dev/null 2>&1; then
    js_runtime=bun
  else
    printf 'error: neither node nor bun is available to check agent-skills-eval deltas\n' >&2
    return 1
  fi

  "$js_runtime" "$ROOT/scripts/check_eval_deltas.js" "$workspace" "$AGENT_SKILLS_EVAL_MIN_DELTA"
}

run_skill_validator() {
  skill-validator check \
    --emit-annotations \
    --strict \
    --skip links \
    --allow-dirs agents,evals,examples,home \
    --allow-flat-layouts \
    "$ROOT"
}

main() {
  ensure_skill_validator || return $?
  ensure_eval_validator || return $?
  run_skill_validator || return $?
  run_eval_validator || return $?
}

main "$@"
