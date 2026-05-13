# AGENTS.md

Use repository-local instructions first when present.

## Skill Index

Every skill in this repository must live under `src/` and be listed in the root `README.md` with a link to its `SKILL.md`.

When creating, renaming, deleting, or materially changing a skill:

- Update the root `README.md` entry in the same change.
- Keep the link target in the form `src/skill-name/SKILL.md`.
- Use the `testing` skill to choose validation scope. For skill package changes, the blast radius is each changed skill, so run focused validation:

```bash
direnv exec . bash scripts/validate_skills.sh <skill-name>
```
