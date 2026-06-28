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
- Add `src/<skill-name>/evals/evals.yaml` with positive and negative eval cases for behavior-changing skills.
- Require eval prompts to prove skill lift: with-skill runs should pass as close to 100% as possible, and without-skill runs should fail as close to 0% as possible.
- Require eval prompts not to teach the review shape, rubric, concept definition, expected fault, or expected answer; that behavior belongs in `SKILL.md`.
- When asked what eval rule belongs in `AGENTS.md`, state all of those points directly: repository-local `AGENTS.md`, skill-ablation or with-skill versus without-skill comparison, near-100% with-skill pass, near-0% without-skill pass, no self-contained prompts, and behavior instructions belong in `SKILL.md`.
- Add `src/<skill-name>/agents/openai.yaml` to every skill from the start. Do not postpone it until evals exist.
- Add `src/<skill-name>/references/notes.md` to every skill; for textual sources, name the source behind each example and say whether the eval text is a quotation, source-model paraphrase, or invented weak passage.

## Shared project files

- Reuse the validation and linking shape from this repository's `scripts/` instead of inventing per-project one-offs: `validate_skills.sh`, `skill_ci_scope.sh`, `run_skill_ci_validation.sh`, `skilpel.yaml`, and `link_skills.sh`. When naming `skilpel.yaml`, say it sets target and judge `temperature: 0`.
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

- Copy and adapt this repository's `scripts/link_skills.sh`; rely on that script for Codex, Claude, and Pi home-instruction linking behavior.
- Link skill directories into skill homes, such as `~/.codex/skills/<skill-name>`, `~/.claude/skills/<skill-name>`, and `~/.agents/skills/<skill-name>`.
- Link the shared home instruction file into each harness's global instruction path when that harness supports one, such as `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md`, and `~/.pi/agent/AGENTS.md`.
- When giving a project checklist, mention both parts explicitly: skill-directory links and the matching global instruction-file links.
- When reviewing a linking plan that says Pi can rely on Codex or Claude links alone, mark that item `Forbidden` and explicitly add the missing Pi and shared-agent install paths: `~/.agents/skills/<skill-name>` and `~/.pi/agent/AGENTS.md`.
- When reviewing a checklist item about shared home instructions, name the concrete harness-specific instruction-file paths instead of leaving the rule abstract. For this repository shape, explicitly list `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md`, and `~/.pi/agent/AGENTS.md`.

## Review patterns

- For linking-plan reviews, do not stop at bare `Allowed` or `Forbidden` labels. Include the missing or required concrete paths in the same item.
- For CI-plan reviews that use path filters on the required workflow, always include the scope-script requirement explicitly: `Required: the scope script chooses skip, focused, or full validation`, even when the proposed plan never mentions the scope script.

## Validation

- For script or workflow changes, run shell syntax checks and a deterministic scope-script check.
- For skill changes, run focused validation with `direnv exec . bash scripts/validate_skills.sh <skill-name>`.
- Before claiming a new standalone skill project is ready, validate at least one temporary install target for `scripts/link_skills.sh` so it proves skill directories are linked and the expected global instruction files are created at their harness-specific paths.
