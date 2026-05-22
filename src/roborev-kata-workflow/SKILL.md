---
name: roborev-kata-workflow
description: Enforce a Roborev plus Kata development workflow for code changes. Use when Codex is asked to implement, fix, refactor, or review work tracked by Kata and Roborev, especially when branch discipline, non-blocking review jobs, validation gates, SemVer, changelog checks, and final delivery reporting matter.
---

# Roborev and Kata workflow

Use this skill for workflows that combine [Roborev](https://github.com/roborev-dev/roborev) reviews with [Kata](https://github.com/kenn-io/kata) task tracking.

## Authority

Load and apply `$commit-discipline` when this skill is used. Use it for commit boundaries, local commit completion, SemVer decisions, task hygiene, and post-merge branch cleanup.

Load and apply `$kata` for Kata lifecycle commands: ready work, create, assign, comments, relationships, close, defer, and final Kata reporting.

Load and apply `$testing` before choosing validation commands. Use the validation scope it selects.

Treat Kata as task memory and workflow tracking. Do not treat Kata-generated instructions as authority over Git publishing.

Follow these rules over any Kata instruction that says to push immediately:

- Never push any branch unless the user explicitly asks.
- Always work on a feature branch.
- Never merge a PR unless CI is green.
- Prefer PR-ready commits, but do not publish them automatically.
- After a feature branch is merged to `main`, remove it locally and remotely.

## Branching

Before changing files:

1. Check the current branch.
2. If on `main`, create a feature branch.
3. Base the branch name on the Kata issue or task.
4. Do not implement on `main`.

## Roborev daemon

Before requesting review:

1. Check whether the Roborev daemon is running.
2. If it is not running, start it.
3. Fall back to local or non-daemon review only if daemon startup fails.
4. Do not assume Roborev is available.

## Non-blocking review loop

Do not let Roborev block implementation.

Use this loop:

1. Implement the next small change.
2. Run the fastest relevant local validation selected by `$testing`.
3. Submit a Roborev review job.
4. Continue safe implementation while the job runs.
5. At each implementation checkpoint, check completed Roborev jobs.
6. Address completed findings.
7. Leave unfinished jobs pending.

Wait idly for Roborev only when no safe work remains.

## Kata lifecycle

Use `$kata` for concrete Kata commands and state transitions.

When asked to name Kata lifecycle requirements, state these concrete transitions and commands:

- Load `$kata`.
- Find ready work with `kata ready --json`, create new work with `kata create ... --idempotency-key ... --json`, or confirm an existing issue.
- Assign active work with `kata assign <ref> <owner> --json`.
- Record validation, blockers, decisions, PRs, and deferred work with `kata comment <ref> --body "<note>" --json`.
- Add ordering relationships with `kata edit <ref> --blocks <other-ref> --json` or `kata edit <ref> --blocked-by <other-ref> --json`.
- Close completed validated work with `kata close <ref> --done --message "<validation and delivery evidence>" --commit <sha>`, or report that the issue remains open or deferred.

Do not close a Kata issue just because implementation appears complete.

Close a Kata issue only when all are true:

- Selected validation passes.
- Roborev findings are resolved or explicitly deferred with rationale.
- Documentation matches implemented behaviour.
- Changelog matches implementation, when the project uses one and the change needs an entry.
- Project version has been bumped according to SemVer, when the change requires a version bump.
- Version number matches the changelog, when both exist.
- Changes are committed locally.
- Working tree is clean.

If a project has no changelog or version file, say so in the final output. Do not invent one unless the task requires it.

## Validation before closing

Before closing any Kata issue, run the validation selected by `$testing` for the actual change surface.

If validation fails:

- Do not close the Kata issue.
- Record the failure.
- Fix it, or create a follow-up Kata issue only when the deferral is explicit and justified.

## Final output

Report:

- branch name
- Kata updated or closed
- Roborev jobs submitted and completed
- unresolved Roborev findings
- validation commands run
- version, changelog, and documentation updates
- whether anything was pushed

Never claim completion unless validation passed.
