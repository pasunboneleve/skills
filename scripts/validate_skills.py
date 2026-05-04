#!/usr/bin/env python3
"""Validate repository-local Codex skills."""

from __future__ import annotations

import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
NAME_RE = re.compile(r"^[a-z0-9-]+$")


def main() -> int:
    errors: list[str] = []
    skill_dirs = sorted(
        path
        for path in ROOT.iterdir()
        if path.is_dir()
        and not path.name.startswith(".")
        and (path / "SKILL.md").exists()
    )

    if not skill_dirs:
        errors.append("no skill directories found")

    for skill_dir in skill_dirs:
        validate_skill(skill_dir, errors)

    if errors:
        for error in errors:
            print(f"error: {error}", file=sys.stderr)
        return 1

    print(f"validated {len(skill_dirs)} skill(s)")
    return 0


def validate_skill(skill_dir: Path, errors: list[str]) -> None:
    name = skill_dir.name
    if not NAME_RE.fullmatch(name):
        errors.append(f"{name}: directory name must use lowercase letters, digits, and hyphens")

    skill_path = skill_dir / "SKILL.md"
    text = skill_path.read_text(encoding="utf-8")
    frontmatter, body = split_frontmatter(skill_path, text, errors)
    if frontmatter is None:
        return

    metadata = parse_simple_yaml(frontmatter, skill_path, errors)
    expected_keys = {"name", "description"}
    actual_keys = set(metadata)
    if actual_keys != expected_keys:
        errors.append(
            f"{skill_path}: frontmatter keys must be exactly name and description"
        )

    skill_name = metadata.get("name", "")
    description = metadata.get("description", "")
    if skill_name != name:
        errors.append(f"{skill_path}: name {skill_name!r} must match directory {name!r}")
    if not description.strip():
        errors.append(f"{skill_path}: description must be non-empty")
    if "TODO" in text or "[TODO" in text:
        errors.append(f"{skill_path}: scaffold TODO text remains")
    if not body.strip():
        errors.append(f"{skill_path}: body must be non-empty")

    validate_openai_yaml(skill_dir, name, errors)


def split_frontmatter(
    path: Path, text: str, errors: list[str]
) -> tuple[str | None, str]:
    if not text.startswith("---\n"):
        errors.append(f"{path}: missing YAML frontmatter")
        return None, text

    try:
        end = text.index("\n---\n", 4)
    except ValueError:
        errors.append(f"{path}: frontmatter is not closed")
        return None, text

    return text[4:end], text[end + len("\n---\n") :]


def parse_simple_yaml(text: str, path: Path, errors: list[str]) -> dict[str, str]:
    values: dict[str, str] = {}
    for line_no, line in enumerate(text.splitlines(), start=1):
        if not line.strip():
            continue
        if line.startswith((" ", "\t")) or ":" not in line:
            errors.append(f"{path}:{line_no}: expected simple key: value frontmatter")
            continue
        key, value = line.split(":", 1)
        key = key.strip()
        value = value.strip()
        if value.startswith(("'", '"')) and value.endswith(("'", '"')):
            value = value[1:-1]
        values[key] = value
    return values


def validate_openai_yaml(skill_dir: Path, name: str, errors: list[str]) -> None:
    path = skill_dir / "agents" / "openai.yaml"
    if not path.exists():
        errors.append(f"{path}: missing agents/openai.yaml")
        return

    text = path.read_text(encoding="utf-8")
    required = ["display_name", "short_description", "default_prompt"]
    for key in required:
        if not re.search(rf"^\s+{key}:\s+\".+\"\s*$", text, re.MULTILINE):
            errors.append(f"{path}: missing quoted interface.{key}")

    if f"${name}" not in text:
        errors.append(f"{path}: default_prompt must mention ${name}")
    if "TODO" in text:
        errors.append(f"{path}: scaffold TODO text remains")


if __name__ == "__main__":
    raise SystemExit(main())
