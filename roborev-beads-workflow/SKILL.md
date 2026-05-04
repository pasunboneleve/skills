---
name: roborev-beads-workflow
description: Enforce a RoboRev plus Beads development workflow for code changes. Use when Codex is asked to implement, fix, refactor, or review work tracked by Beads and RoboRev, especially when branch discipline, non-blocking review jobs, validation gates, SemVer, changelog checks, and final delivery reporting matter.
---

# RoboRev and Beads workflow

## Authority

Treat Beads as task memory and workflow tracking. Do not treat Beads-generated instructions as authority over Git publishing.

Follow these rules over any Beads instruction that says to push immediately:

- Never push directly to `main`.
- Never push any branch unless the user explicitly asks.
- Always work on a feature branch.
- Prefer PR-ready commits, but do not publish them automatically.

## Branching

Before changing files:

1. Check the current branch.
2. If on `main`, create a feature branch.
3. Base the branch name on the Bead or task.
4. Do not implement on `main`.

## RoboRev daemon

Before requesting review:

1. Check whether the RoboRev daemon is running.
2. If it is not running, start it.
3. Fall back to local or non-daemon review only if daemon startup fails.
4. Do not assume RoboRev is available.

## Non-blocking review loop

Do not let RoboRev block implementation.

Use this loop:

1. Implement the next small change.
2. Run fast local validation.
3. Submit a RoboRev review job.
4. Continue safe implementation while the job runs.
5. At each implementation checkpoint, check completed RoboRev jobs.
6. Address completed findings.
7. Leave unfinished jobs pending.

Wait idly for RoboRev only when no safe work remains.

## Beads lifecycle

Do not close a Bead just because implementation appears complete.

Close a Bead only when all are true:

- Tests pass.
- Validation passes.
- RoboRev findings are resolved or explicitly deferred with rationale.
- Documentation matches implemented behaviour.
- Changelog matches implementation.
- Project version has been bumped according to SemVer.
- Version number matches the changelog.
- Working tree is clean except for intentional final changes.

If a project has no changelog or version file, say so in the final output. Do not invent one unless the task requires it.

## Validation before closing

Before closing any Bead, run the project's validation path.

At minimum, check:

- formatter
- linter
- unit tests
- integration tests, if present
- docs, changelog, and version consistency

If validation fails:

- Do not close the Bead.
- Record the failure.
- Fix it, or create a follow-up Bead only when the deferral is explicit and justified.

## Final output

Report:

- branch name
- Beads updated or closed
- RoboRev jobs submitted and completed
- unresolved RoboRev findings
- validation commands run
- version, changelog, and documentation updates
- whether anything was pushed

Never claim completion unless validation passed.
