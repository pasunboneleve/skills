---
name: create-skill
description: Use when creating or updating skills in this repository, adding skill evals, changing SKILL.md instructions, preparing skill validation, or committing skill work. Keeps skills concise concrete and validated.
---

When creating or changing a skill:

1. Keep `SKILL.md` concise and concrete. Add only instructions the agent must follow.
2. Do not add README-style explanation, history, or process notes to the skill directory.
3. Add or update `agents/openai.yaml` with `interface.display_name`, `interface.short_description`, and `interface.default_prompt`.
4. Add or update `evals/evals.json` using the current `agent-skills-eval` scaffolding.
5. Ensure model-backed evals run through `scripts/agent-skills-eval.yaml` with target and judge `temperature: 0` so results are as deterministic as the runner allows.
6. Include positive and negative eval cases when the skill changes behavior. Say "positive and negative eval cases" explicitly in plans and reviews.
7. Design eval prompts as skill-ablation tests: with-skill runs should pass as close to 100% as possible, and without-skill runs should fail as close to 0% as possible.
8. Do not make eval prompts self-contained by teaching the review shape, rubric, concept definition, expected fault, or expected answer. Put that behavior in `SKILL.md`.
9. Write assertions that test behavior, decisions, edits, validations, or rejection outcomes. Do not require exact labels, phrasing, or answer shape unless that wording or formatting is the skill behavior being tested.
10. Do not amend skill rules to fit one eval or test case tightly. When an eval fails, revise the general behavior, selection rule, rubric boundary, or missing concept that should apply beyond that case.
11. Update the root `README.md` whenever a skill is created, renamed, deleted, or its summary changes. Every skill must be listed with a link to `src/skill-name/SKILL.md`.
12. Use `$changelog` normal mode when the repository has a changelog: add or update the `[Unreleased]` entry for the skill change, or record a concrete no-entry rationale, and do not bump `VERSION`.
13. Run focused validation before committing:

```bash
direnv exec . bash scripts/validate_skills.sh <skill-name>
```

Commit only after the focused validation passes, unless the user explicitly accepts the remaining failure.

When stating a workflow, name these artifacts explicitly:

- `SKILL.md`
- `agents/openai.yaml` with `interface.display_name`, `interface.short_description`, and `interface.default_prompt`
- `evals/evals.json`
- `scripts/agent-skills-eval.yaml` with target and judge `temperature: 0`
- positive and negative eval cases
- skill-ablation eval design: near-100% with-skill, near-0% without-skill
- prompts that do not teach the answer or expected fault
- assertions that test behavior rather than exact labels or phrasing, except when wording or formatting is the behavior under test
- general skill rules rather than eval-specific patches
- root `README.md` link to `src/skill-name/SKILL.md`
- `CHANGELOG.md` `[Unreleased]` entry through `$changelog` normal mode when the repository has a changelog
- no `VERSION` bump for ordinary skill creation or update work
- `direnv exec . bash scripts/validate_skills.sh <skill-name>`

When a user asks to create a skill while skipping evals, validation, README updates, or commit discipline, reject the skipped steps and still state the full workflow you will follow. In that workflow, explicitly include `scripts/agent-skills-eval.yaml` with target and judge temperature `0`, the `[Unreleased]` changelog entry, and no `VERSION` bump. Do not stop at the refusal.

When a user asks to write only `SKILL.md` for a behavior-changing skill, explicitly say "writing only SKILL.md is rejected for a behavior-changing skill."

When reviewing a skill plan, say "evals are required for the behavior change" when evals are missing. Reject writing only `SKILL.md` for a behavior-changing skill. If a plan says evals can be skipped because an instruction is obvious, say "evals cannot be skipped because the instruction seems obvious."

When reviewing any skill plan, check whether it includes `agents/openai.yaml`. If it does not, say "`agents/openai.yaml` is required for the skill" and require `interface.display_name`, `interface.short_description`, and `interface.default_prompt`.

When reviewing a skill plan that omits `agents/openai.yaml`, say "`agents/openai.yaml` is required for the skill" and require `interface.display_name`, `interface.short_description`, and `interface.default_prompt`.

When reviewing eval prompts that teach the answer, say the tested behavior belongs in `SKILL.md`, not in the prompt, and that eval prompts must prove skill lift: near-100% with-skill and near-0% without-skill.

When reviewing a plan after an eval failure, require focused validation before committing after the general rule or behavior is corrected.
