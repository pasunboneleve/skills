# Skills for [Codex](https://developers.openai.com/codex/cli), [Claude Code](https://www.anthropic.com/claude-code), and [Pi](https://github.com/earendil-works/pi-mono)

[![Skill CI](https://github.com/pasunboneleve/skills/actions/workflows/skill-ci.yml/badge.svg)](https://github.com/pasunboneleve/skills/actions/workflows/skill-ci.yml?query=event%3Apull_request)

Shared coding-agent skills used from `~/.codex/skills`, `~/.claude/skills`, and `~/.agents/skills`. Skill sources live under `src/`.

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

- [`change-friendly-architecture`](src/change-friendly-architecture/SKILL.md): reviews designs for narrow, testable boundaries, explicit dependencies, visible workflows, and low blast radius.
- [`beads`](src/beads/SKILL.md): keeps Beads work claimed, updated with evidence, and closed when complete.
- [`changelog`](src/changelog/SKILL.md): keeps unreleased changelog entries accurate and finalizes version sections at release time.
- [`ci`](src/ci/SKILL.md): adds GitHub Actions checks and README badges for code and skills projects.
- [`coding`](src/coding/SKILL.md): surfaces code execution exceptions, keeps code idiomatic, separates mixed-language scripts, and avoids machine-specific paths.
- [`commit-discipline`](src/commit-discipline/SKILL.md): prepares small local commits with clear rationale, safe non-trivial commit-message handling, changelog discipline, and task hygiene.
- [`create-skill`](src/create-skill/SKILL.md): creates concise skills with OpenAI metadata, eval scaffolding, and focused validation.
- [`decompose-skill`](src/decompose-skill/SKILL.md): splits oversized skills into a small trigger surface plus focused resources.
- [`devloop`](src/devloop/SKILL.md): discovers [`devloop`](https://github.com/pasunboneleve/devloop) from its built-in guidance and validates workflows with observable evidence.
- [`documentation-boundary`](src/documentation-boundary/SKILL.md): separates README synopsis work from real documentation updates.
- [`docs-structure`](src/docs-structure/SKILL.md): organises README synopsis content and durable docs into focused files.
- [`jira-priority`](src/jira-priority/SKILL.md): classifies the priority of a Jira issue using a customer-impact scheme with escalation rules for missing workarounds and critical business processes.
- [`kata`](src/kata/SKILL.md): keeps Kata issues searched, assigned, updated with evidence, and closed when verified.
- [`markdown`](src/markdown/SKILL.md): edits Markdown with useful Unicode, including box-drawing directory trees.
- [`pull-request`](src/pull-request/SKILL.md): prepares GitHub PRs and handles review-thread replies, resolutions, and linked external references.
- [`release`](src/release/SKILL.md): releases through protected main, PR CI, merged release commits, tags, and release workflows.
- [`repo-policy`](src/repo-policy/SKILL.md): configures GitHub repository policies for protected main, PR merges, CI gates, and artifact releases.
- [`roborev-kata-workflow`](src/roborev-kata-workflow/SKILL.md): coordinates Kata task tracking with bounded, advisory Roborev review and configured external review providers.
- [`shell-script`](src/shell-script/SKILL.md): requires strict shell mode for shell scripts and automation wrappers.
- [`skill-project`](src/skill-project/SKILL.md): scaffolds standalone skill-set repositories with shared validation, linking, eval, and agent metadata conventions.
- [`testing`](src/testing/SKILL.md): selects the narrowest deterministic validation for a change's blast radius.
- [`web-realtime-devloop`](src/web-realtime-devloop/SKILL.md): enforces a live browser development loop for realtime web work.

## Use

Run `./scripts/link_skills.sh` to symlink the skills into `~/.codex/skills`, `~/.claude/skills`, and `~/.agents/skills`, and to link the hosted home instructions into `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md`, and `pi`'s global context path at `~/.pi/agent/AGENTS.md`. The script also mirrors that same `AGENTS.md` into `~/.agents/AGENTS.md`.

Run `bash scripts/install-agent-services.sh` to install Kata and Roborev for the current user and configure their daemons as OS-managed user services. See [`docs/development/agent-services.md`](docs/development/agent-services.md) for requirements and service status commands.

## Validation

Run `bash scripts/validate_skills.sh`.

For the Kata and Roborev service installer, run `bash scripts/validate_agent_services.sh`.

For skill and global-instruction linking, run `bash scripts/validate_link_skills.sh`.

Model-backed evals use [`scripts/skilpel.yaml`](scripts/skilpel.yaml), which sets target and judge temperature to `0`.

To iterate on one eval case, pass a skill relpath and eval id:

```bash
bash scripts/validate_skills.sh --eval-id reject-overfit-domain-type change-friendly-architecture
```

For local model-backed evals, put `OPENAI_API_KEY` in `.env`. The committed `.envrc` loads `.env` into the shell with direnv; `.env` is ignored by Git.

## Contributing

See [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) for repository shape, validation workflow, and the local `skill-validator` and `skilpel` dependencies.

## Versioning

The current version is recorded in `VERSION`.

See `CHANGELOG.md` for release history. Version tags use `vMAJOR.MINOR.PATCH`.

## License

This project is licensed under GPL-3.0-or-later. See `LICENSE`.
