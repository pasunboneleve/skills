# AGENTS.md

Use repository-local instructions first when present.

## Skill Index

Every skill in this repository must live under `src/` and be listed in the root `README.md` with a link to its `SKILL.md`.

When creating, renaming, deleting, or materially changing a skill:

- Update the root `README.md` entry in the same change.
- Keep the link target in the form `src/skill-name/SKILL.md`.
- Design eval prompts as skill-ablation tests: with-skill runs should pass as close to 100% as possible, and without-skill runs should fail as close to 0% as possible.
- Do not make eval prompts self-contained by teaching the review shape, rubric, concept definition, expected fault, or expected answer. That behavior belongs in `SKILL.md`.
- Use the `testing` skill to choose validation scope. For skill package changes, the blast radius is each changed skill, so run focused validation:

```bash
direnv exec . bash scripts/validate_skills.sh <skill-name>
```
