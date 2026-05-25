---
name: ci
description: Add or review GitHub Actions CI for programming-language and skills projects, including README badges linked to workflow runs.
---

# CI

Use this skill when adding, reviewing, or fixing repository CI.

## GitHub Actions

Implement a GitHub Actions workflow under `.github/workflows/` unless the repository already has the correct workflow.

For programming-language projects, run the repository's deterministic tests, linters, format checks, builds, or package checks. Prefer the project's existing commands and package manager. Do not invent a test command when the repository has a clear one.

For skills projects, run skills validation with the repository's validation wrapper and validate the smallest affected skill set. In this repository shape, CI keeps one stable required `validate` job, uses the scope script to decide skip, focused, or full validation, and runs the wrapper only for affected skills:

```bash
scripts/skill_ci_scope.sh "$event_name" "$head_sha" "$base_sha" "$before_sha"
scripts/run_skill_ci_validation.sh
```

Do not make skills-project CI revalidate unrelated skills for ordinary pull requests. Shared validation infrastructure, cross-cutting configuration, and scope script changes should keep the required job stable, validate script syntax or equivalent static checks, and still run skill validation only for the changed `src/<skill>` directories.

For hybrid projects, include both the programming-language checks and the skills validation.

Make pull requests run the CI workflow. Add `push` on `main` when post-merge validation is needed. Add tag triggers only when the repository actually publishes release artifacts from tags.

If a required CI job can skip work by scope, the workflow must still report a stable required check. Do not suppress a required workflow with `paths-ignore`. When rejecting that pattern, state the replacement: put skip, focused, or full validation decisions inside the job, and for skills projects validate the smallest affected skill set so ordinary changes do not revalidate unrelated skills.

## README Badge

Add or update a CI badge near the top of `README.md`.

Use the workflow badge image for the chosen workflow and link the badge to the GitHub Actions workflow runs page filtered to the default branch, so readers can reach the latest relevant run. Use this shape:

```markdown
[![CI](https://github.com/<owner>/<repo>/actions/workflows/<workflow>.yml/badge.svg?branch=<default-branch>)](https://github.com/<owner>/<repo>/actions/workflows/<workflow>.yml?query=branch%3A<default-branch>)
```

Keep the badge label aligned with the workflow name, such as `CI`, `Tests`, or `Skill CI`.

## Validation

After changing CI, validate at the narrowest useful boundary:

- Syntax or source-visible review of the workflow YAML.
- The commands the workflow will run, when they can run locally.
- README badge target and image URL.
- A pushed PR check, when the workflow can only be fully verified by GitHub Actions.

Do not claim CI is complete until the workflow file, README badge, and selected validation evidence agree.
