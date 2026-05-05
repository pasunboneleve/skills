#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd -- "${script_dir}/.." && pwd -P)"
dest_root="${CODEX_SKILLS_DIR:-${HOME}/.codex/skills}"

mkdir -p -- "${dest_root}"

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

printf 'done: %d linked, %d skipped, %d failed\n' "${linked}" "${skipped}" "${failed}"

if ((failed > 0)); then
  exit 1
fi
