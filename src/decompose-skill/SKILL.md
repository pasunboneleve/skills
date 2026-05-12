---
name: decompose-skill
description: Decompose oversized, tangled, or multi-purpose Codex skills into a concise SKILL.md plus focused references, scripts, and assets. Use when creating or refactoring skills that exceed practical context size, mix unrelated workflows, duplicate reference material, hide resource selection rules, or need progressive disclosure.
---

# Decompose skill

Use this skill to turn a large or vague skill into a small trigger surface and a set of loadable resources.

The goal is not to split by word count alone. Split so another Codex instance can choose the right file from the skill body without loading irrelevant material.

When reviewing or planning a decomposition that creates, renames, removes, or changes skills, explicitly require both:

- root `README.md` links in the form `src/skill-name/SKILL.md`
- focused validation for every changed or new skill with `direnv exec . bash scripts/validate_skills.sh <skill-name>`

Reject plans that leave `README.md` alone, skip focused validation because the change is "only moving text", or commit before validation passes.

## Decomposition Workflow

1. Identify the skill's jobs.
   - List the distinct user intents the skill supports.
   - Keep one skill only if those intents share one trigger, one workflow, or one operational boundary.
   - Recommend separate skills when intents would trigger in different situations or require unrelated tools.

2. Protect the trigger surface.
   - Put all "when to use" conditions in the YAML `description`.
   - Keep frontmatter to `name` and `description` only.
   - Make the description broad enough for discovery and specific enough to avoid false triggers.

3. Shrink `SKILL.md` to routing and rules.
   - Keep core workflow, invariants, resource map, and validation commands.
   - Move long examples, schemas, command catalogs, provider details, policy tables, and variant-specific instructions into `references/`.
   - Keep direct links from `SKILL.md` to every reference file and state when to read each one.

4. Choose resource types by use.
   - Use `scripts/` for deterministic operations that agents would otherwise rewrite.
   - Use `references/` for material that may need to enter context.
   - Use `assets/` for templates, binaries, images, fonts, or boilerplate copied into outputs.
   - Delete unused resource directories and placeholder files.

5. Preserve executable paths.
   - Keep fragile command sequences in scripts when possible.
   - Include script invocation examples in `SKILL.md`.
   - Test added or changed scripts by running a representative command.

6. Validate after each structural change.
   - State the exact validation command in plans and reports.
   - Run focused validation for each changed skill:

```bash
direnv exec . bash scripts/validate_skills.sh <skill-name>
```

   - Forward-test with realistic prompts when the split changes how agents discover instructions.
   - Update the root `README.md` when decomposition creates, renames, removes, or changes the summary of a skill. Every skill must be listed with a link to `src/skill-name/SKILL.md`.
   - Commit only after focused validation passes, unless the user explicitly accepts the remaining failure.

## Split Criteria

Split content out of `SKILL.md` when one of these is true:

- An agent only needs it for one provider, framework, file type, product area, or workflow branch.
- It is a long example set rather than a rule.
- It is reference data, such as schemas, API fields, policy clauses, or command matrices.
- It repeats information already available in a script, template, or generated artifact.
- It makes the main workflow harder to scan.

Keep content in `SKILL.md` when one of these is true:

- It prevents unsafe or invalid use.
- It decides which resource to load.
- It is a core invariant for every use of the skill.
- It gives the shortest reliable command for validation.
- It names how to recover from common failure modes.

## Reference Design

Prefer one-level references:

```text
skill-name/
├── SKILL.md
├── agents/openai.yaml
├── scripts/
├── references/
│   ├── aws.md
│   ├── gcp.md
│   └── schema.md
└── assets/
```

For each reference linked from `SKILL.md`, include:

- the file path
- the condition for reading it
- the task it supports

Example:

```markdown
- Read `references/aws.md` when the deployment target is AWS.
- Read `references/schema.md` before writing SQL against the warehouse.
```

For reference files longer than 100 lines, put a short table of contents at the top.

## Writing Rules

- Write in imperative form.
- Prefer concrete commands, file names, and decision rules over explanation.
- Do not create README, changelog, installation guide, or quick-reference files inside a skill.
- Do not duplicate the same instruction in `SKILL.md` and a reference file.
- Do not bury trigger conditions in the body; the body loads only after the skill triggers.
- Keep examples small enough to teach the pattern without becoming the pattern library.

## Decomposition Output

When reporting a decomposition, include:

- `Trigger`: revised YAML description or confirmation that it is unchanged.
- `Body`: what remains in `SKILL.md`.
- `References`: files created or changed and when to read them.
- `Scripts`: files created or changed and how they were tested.
- `Assets`: files created or changed and how they are used.
- `Validation`: commands run and results.
- `README`: root `README.md` links added, changed, or confirmed.

If a proposed split would create needless indirection, keep the skill whole and name the reason.
