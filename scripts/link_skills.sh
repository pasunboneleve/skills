#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd -- "${script_dir}/.." && pwd -P)"
codex_home="${CODEX_HOME:-${HOME}/.codex}"
dest_root="${CODEX_SKILLS_DIR:-${codex_home}/skills}"
agents_src="${repo_root}/home/AGENTS.md"
agents_dest="${codex_home}/AGENTS.md"

mkdir -p -- "${dest_root}" "${codex_home}"

linked=0
skipped=0
failed=0

while IFS= read -r -d '' skill_file; do
  skill_dir="$(dirname -- "${skill_file}")"
  skill_name="$(basename -- "${skill_dir}")"
  dest="${dest_root}/${skill_name}"

  if [[ -e "${dest}" && ! -L "${dest}" ]]; then
    printf 'error: %s exists and is not a symlink\n' "${dest}" >&2
    failed=$((failed + 1))
    continue
  fi

  if [[ -L "${dest}" && "$(readlink -- "${dest}")" == "${skill_dir}" ]]; then
    printf 'skip: %s -> %s\n' "${dest}" "${skill_dir}"
    skipped=$((skipped + 1))
    continue
  fi

  ln -sfn -- "${skill_dir}" "${dest}"
  printf 'link: %s -> %s\n' "${dest}" "${skill_dir}"
  linked=$((linked + 1))
done < <(find "${repo_root}" -type f -name SKILL.md -print0 | sort -z)

if [[ ! -f "${agents_src}" ]]; then
  printf 'error: %s does not exist\n' "${agents_src}" >&2
  failed=$((failed + 1))
elif [[ -e "${agents_dest}" && ! -L "${agents_dest}" ]]; then
  printf 'error: %s exists and is not a symlink\n' "${agents_dest}" >&2
  failed=$((failed + 1))
elif [[ -L "${agents_dest}" && "$(readlink -- "${agents_dest}")" == "${agents_src}" ]]; then
  printf 'skip: %s -> %s\n' "${agents_dest}" "${agents_src}"
  skipped=$((skipped + 1))
else
  ln -sfn -- "${agents_src}" "${agents_dest}"
  printf 'link: %s -> %s\n' "${agents_dest}" "${agents_src}"
  linked=$((linked + 1))
fi

printf 'done: %d linked, %d skipped, %d failed\n' "${linked}" "${skipped}" "${failed}"

if ((failed > 0)); then
  exit 1
fi
