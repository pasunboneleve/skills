# Codex skills

[![Skill CI](https://github.com/pasunboneleve/skills/actions/workflows/skill-ci.yml/badge.svg)](https://github.com/pasunboneleve/skills/actions/workflows/skill-ci.yml)

Personal Codex skills used from `~/.codex/skills`.

## Skills

- [`change-friendly-architecture`](change-friendly-architecture/SKILL.md): reviews designs for narrow, testable boundaries and low blast radius.
- [`commit-discipline`](commit-discipline/SKILL.md): prepares small local commits with clear rationale and task hygiene.
- [`documentation-boundary`](documentation-boundary/SKILL.md): separates README synopsis work from real documentation updates.
- [`docs-structure`](docs-structure/SKILL.md): organises README synopsis content and durable docs into focused files.
- [`oiticica-style`](oiticica-style/SKILL.md): reviews prose and code through concrete contrast, diagnosis, correction, and explanation.
- [`release`](release/SKILL.md): releases through protected main, PR CI, merged release commits, tags, and release workflows.
- [`roborev-beads-workflow`](roborev-beads-workflow/SKILL.md): coordinates Beads task tracking with non-blocking RoboRev review.
- [`strunk-white-editor`](strunk-white-editor/SKILL.md): revises prose for clarity, brevity, and directness.
- [`web-realtime-devloop`](web-realtime-devloop/SKILL.md): enforces a live browser development loop for realtime web work.

## Use

Run `./scripts/link_skills.sh` to symlink the skills into `~/.codex/skills` and the hosted Codex-home instructions into `~/.codex/AGENTS.md`.

## Validation

Run `python3 scripts/validate_skills.py`.

## Versioning

The current version is recorded in `VERSION`.

See `CHANGELOG.md` for release history. Version tags use `vMAJOR.MINOR.PATCH`.

## License

This project is licensed under GPL-3.0-or-later. See `LICENSE`.
