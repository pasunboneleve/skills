---
name: create-skill
description: Use when creating or updating skills in this repository, adding skill evals, changing SKILL.md instructions, preparing skill validation, or committing skill work. Keeps skills concise concrete and validated.
---

When creating or changing a skill:

1. Keep `SKILL.md` concise and concrete. Add only instructions the agent must follow.
2. Do not add README-style explanation, history, or process notes to the skill directory.
3. Add or update `evals/evals.json` using the current `agent-skills-eval` scaffolding.
4. Include positive and negative eval cases when the skill changes behavior. Say "positive and negative eval cases" explicitly in plans and reviews.
5. Run focused validation before committing:

```bash
direnv exec . bash scripts/validate_skills.sh <skill-name>
```

Commit only after the focused validation passes, unless the user explicitly accepts the remaining failure.

When stating a workflow, name these artifacts explicitly:

- `SKILL.md`
- `evals/evals.json`
- positive and negative eval cases
- `direnv exec . bash scripts/validate_skills.sh <skill-name>`

When a user asks to write only `SKILL.md` for a behavior-changing skill, explicitly say "writing only SKILL.md is rejected for a behavior-changing skill."

When reviewing a skill plan, say "evals are required for the behavior change" when evals are missing. Reject writing only `SKILL.md` for a behavior-changing skill. If a plan says evals can be skipped because an instruction is obvious, say "evals cannot be skipped because the instruction seems obvious."
