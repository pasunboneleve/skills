# Codex skills

[![Skill CI](https://github.com/pasunboneleve/skills/actions/workflows/skill-ci.yml/badge.svg)](https://github.com/pasunboneleve/skills/actions/workflows/skill-ci.yml)

Personal Codex skills used from `~/.codex/skills`. Skill sources live under `src/`.

<br>

<p align="center" style="margin: 0.35rem 0 0.35rem 0;">
  <a href="https://commons.wikimedia.org/wiki/File:A_seated_man_sharpening_a_quill_pen._Engraving_by_C._Guttenb_Wellcome_V0024853.jpg"
  target="_blank"
  rel="noopener noreferrer">
    <img
        src="docs/images/quill-codex.jpg"
        alt="A seated man sharpening a quill pen beside an open codex"
        style="width:58.5%;"
        />
  </a>
</p>

<p align="center" style="margin: 0 0 1.25rem 0;">
    <sub>A sharpened tool. An open codex. A practiced hand.</sub>
</p>

## Skills

- [`change-friendly-architecture`](src/change-friendly-architecture/SKILL.md): reviews designs for narrow, testable boundaries and low blast radius.
- [`beads`](src/beads/SKILL.md): keeps Beads work claimed, updated with evidence, and closed when complete.
- [`coding`](src/coding/SKILL.md): surfaces code execution exceptions and keeps mixed-language scripts in separate files.
- [`commit-discipline`](src/commit-discipline/SKILL.md): prepares small local commits with clear rationale and task hygiene.
- [`create-skill`](src/create-skill/SKILL.md): creates concise skills with current eval scaffolding and focused validation.
- [`decompose-skill`](src/decompose-skill/SKILL.md): splits oversized skills into a small trigger surface plus focused resources.
- [`devloop`](src/devloop/SKILL.md): discovers [`devloop`](https://github.com/pasunboneleve/devloop) from its built-in guidance and validates workflows with observable evidence.
- [`documentation-boundary`](src/documentation-boundary/SKILL.md): separates README synopsis work from real documentation updates.
- [`docs-structure`](src/docs-structure/SKILL.md): organises README synopsis content and durable docs into focused files.
- [`markdown`](src/markdown/SKILL.md): edits Markdown with useful Unicode, including box-drawing directory trees.
- [`oiticica-style`](src/oiticica-style/SKILL.md): reviews prose and code through concrete contrast, diagnosis, correction, and explanation.
- [`release`](src/release/SKILL.md): releases through protected main, PR CI, merged release commits, tags, and release workflows.
- [`roborev-beads-workflow`](src/roborev-beads-workflow/SKILL.md): coordinates Beads task tracking with non-blocking RoboRev review.
- [`shell-script`](src/shell-script/SKILL.md): requires strict shell mode for shell scripts and automation wrappers.
- [`testing`](src/testing/SKILL.md): selects the narrowest deterministic validation for a change's blast radius.
- [`web-realtime-devloop`](src/web-realtime-devloop/SKILL.md): enforces a live browser development loop for realtime web work.

## Use

Run `./scripts/link_skills.sh` to symlink the skills into `~/.codex/skills` and the hosted Codex-home instructions into `~/.codex/AGENTS.md`.

## Validation

Run `bash scripts/validate_skills.sh`. The wrapper installs `skill-validator` into `~/.local/bin` and `agent-skills-eval` globally when either tool is not already on `PATH`.

Model-backed evals use [`scripts/agent-skills-eval.yaml`](scripts/agent-skills-eval.yaml), which sets target and judge temperature to `0`.

For local model-backed evals, put `OPENAI_API_KEY` in `.env`. The committed `.envrc` loads `.env` into the shell with direnv; `.env` is ignored by Git.

## Versioning

The current version is recorded in `VERSION`.

See `CHANGELOG.md` for release history. Version tags use `vMAJOR.MINOR.PATCH`.

## License

This project is licensed under GPL-3.0-or-later. See `LICENSE`.
