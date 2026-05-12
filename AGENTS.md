# AGENTS.md

Use repository-local instructions first when present.

## Skill Index

Every skill in this repository must be listed in the root `README.md` with a link to its `SKILL.md`.

When creating, renaming, deleting, or materially changing a skill:

- Update the root `README.md` entry in the same change.
- Keep the link target in the form `skill-name/SKILL.md`.
- Run focused validation for each changed skill before committing:

```bash
direnv exec . bash scripts/validate_skills.sh <skill-name>
```
