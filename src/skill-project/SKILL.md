---
name: skill-project
description: Create or review a standalone repository that publishes a set of Codex or Claude skills with shared validation, linking, eval, and agent metadata conventions.
---

# Skill project

Use this skill when creating or reviewing a standalone skill-set repository.

When answering, include the concrete files or links involved. For review requests, label each disputed item as `Allowed`, `Forbidden`, or `Mandatory`.

## Repository shape

- Put skills under `src/<skill-name>/SKILL.md`; do not mix skill directories with `scripts/`, `home/`, docs, or project metadata.
- Add each skill to `README.md` with a link to `src/<skill-name>/SKILL.md`.
- Add `src/<skill-name>/evals/evals.json` with positive and negative eval cases for behavior-changing skills.
- Require eval prompts to prove skill lift: with-skill runs should pass as close to 100% as possible, and without-skill runs should fail as close to 0% as possible.
- Require eval prompts not to teach the review shape, rubric, concept definition, expected fault, or expected answer; that behavior belongs in `SKILL.md`.
- Add `src/<skill-name>/agents/openai.yaml` to every skill from the start. Do not postpone it until evals exist.
- Add `src/<skill-name>/references/notes.md` to every skill; for textual sources, name the source behind each example and say whether the eval text is a quotation, source-model paraphrase, or invented weak passage.

## Shared project files

- Reuse the validation and linking shape from this repository's `scripts/` instead of inventing per-project one-offs: `validate_skills.sh`, `skill_ci_scope.sh`, `run_skill_ci_validation.sh`, `skilpel.yaml`, and `link_skills.sh`.
- Keep model-backed evals on a `skilpel.yaml` config that sets both target and judge `temperature: 0`.
- Add `.envrc` with `dotenv_if_exists .env`.
- Add `.env` to `.gitignore`.
- Document that local evals need a non-version-controlled `.env` containing the configured model provider key, such as `OPENAI_API_KEY=...`.
- Add a pull-request GitHub Actions workflow with a required `validate` job.
- Add repository-local `AGENTS.md` instructions that include the skill-ablation eval rule for every future skill.
- Do not use `pull_request.paths`, `paths-ignore`, or other path filters that suppress the required `validate` workflow.
- When a file does not need skill validation, the workflow must still run and report `validate`; the scope script must choose `skip`, `focused`, or `full`.
- Distinguish skipping skill validation from skipping the whole required workflow. Skipping the workflow leaves no required check result.
- When reviewing a CI plan that uses path filters on a required workflow, say explicitly: `Forbidden: suppressing the required validate workflow`; `Required: the validate workflow still runs`; `Required: the scope script chooses skip, focused, or full validation`; `Skipping skill validation is not the same as skipping the workflow`.
- Document the GitHub repository secret needed by CI, such as `OPENAI_API_KEY` or the configured provider key.

## Linking rules

- Copy and adapt this repository's `scripts/link_skills.sh`; rely on that script for Codex-home instruction linking behavior.
- Link skill directories into skill homes, such as `~/.codex/skills/<skill-name>` and `~/.claude/skills/<skill-name>`.
- Do not link, copy, or install `home/AGENTS.md`, `AGENTS.md`, `CLAUDE.md`, or any other top-level agent instruction file into `~/.claude/CLAUDE.md`.
- Refuse a link script that installs top-level agent instruction files into Claude, even if it correctly links skill directories.
- When giving a project checklist, mention the Claude top-level prohibition explicitly, not only the positive skill-directory links.

## Validation

- For script or workflow changes, run shell syntax checks and a deterministic scope-script check.
- For skill changes, run focused validation with `direnv exec . bash scripts/validate_skills.sh <skill-name>`.
- Before claiming a new standalone skill project is ready, validate at least one temporary install target for `scripts/link_skills.sh` so it proves skill directories are linked and `~/.claude/CLAUDE.md` is not created.
