#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd -- "${script_dir}/.." && pwd -P)"
link_script="${repo_root}/scripts/link_skills.sh"
agents_src="${repo_root}/home/AGENTS.md"
tmp_root=""

cleanup() {
  if [[ -n "${tmp_root}" ]]; then
    rm -rf -- "${tmp_root}"
  fi
}

trap cleanup EXIT

assert_link_target() {
  local link="$1"
  local target="$2"

  if [[ ! -L "${link}" ]]; then
    printf 'error: expected symlink: %s\n' "${link}" >&2
    exit 1
  fi

  if [[ "$(readlink -- "${link}")" != "${target}" ]]; then
    printf 'error: expected %s -> %s, got %s\n' "${link}" "${target}" "$(readlink -- "${link}")" >&2
    exit 1
  fi
}

run_link_script() {
  local home="$1"

  env \
    HOME="${home}" \
    CODEX_HOME="${home}/.codex" \
    PI_HOME="${home}/.pi" \
    AGENTS_HOME="${home}/.agents" \
    CLAUDE_HOME="${home}/.claude" \
    bash "${link_script}"
}

tmp_root="$(mktemp -d "${TMPDIR:-/tmp}/link-skills-test.XXXXXX")"

normal_home="${tmp_root}/normal"
mkdir -p -- "${normal_home}"
run_link_script "${normal_home}" >/dev/null
assert_link_target "${normal_home}/.claude/CLAUDE.md" "${agents_src}"
assert_link_target "${normal_home}/.codex/AGENTS.md" "${agents_src}"
assert_link_target "${normal_home}/.pi/agent/AGENTS.md" "${agents_src}"
assert_link_target "${normal_home}/.agents/AGENTS.md" "${agents_src}"

conflict_home="${tmp_root}/conflict"
mkdir -p -- "${conflict_home}/.claude"
printf 'hand-managed claude instructions\n' >"${conflict_home}/.claude/CLAUDE.md"

if run_link_script "${conflict_home}" >/dev/null 2>"${tmp_root}/conflict.err"; then
  printf 'error: expected link_skills.sh to fail for preexisting non-symlink CLAUDE.md\n' >&2
  exit 1
fi

grep -Fq "exists and is not a symlink" "${tmp_root}/conflict.err"
grep -Fq "hand-managed claude instructions" "${conflict_home}/.claude/CLAUDE.md"
assert_link_target "${conflict_home}/.codex/AGENTS.md" "${agents_src}"
assert_link_target "${conflict_home}/.pi/agent/AGENTS.md" "${agents_src}"
assert_link_target "${conflict_home}/.agents/AGENTS.md" "${agents_src}"

first_skill="$(find "${repo_root}/src" -type f -name SKILL.md -print | sort | head -n 1)"
first_skill_dir="$(dirname -- "${first_skill}")"
first_skill_name="$(basename -- "${first_skill_dir}")"
assert_link_target "${conflict_home}/.codex/skills/${first_skill_name}" "${first_skill_dir}"
assert_link_target "${conflict_home}/.agents/skills/${first_skill_name}" "${first_skill_dir}"
assert_link_target "${conflict_home}/.claude/skills/${first_skill_name}" "${first_skill_dir}"

printf 'link_skills validation passed\n'
