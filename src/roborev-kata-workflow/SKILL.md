---
name: roborev-kata-workflow
description: Enforce a Roborev plus Kata development workflow for code changes. Use when Codex is asked to implement, fix, refactor, or review work tracked by Kata and Roborev, especially when branch discipline, non-blocking review jobs, validation gates, SemVer, changelog checks, and final delivery reporting matter.
---

# Roborev and Kata workflow

Use this skill for workflows that combine [Roborev](https://github.com/roborev-dev/roborev) reviews with [Kata](https://github.com/kenn-io/kata) task tracking.

## Authority

Load and apply `$commit-discipline` when this skill is used. Use it for commit boundaries, local commit completion, SemVer commentary, task hygiene, and post-merge branch cleanup.

Load and apply `$changelog` when the project has a changelog or version file. Use normal mode for ordinary implementation work and release mode for release work.

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

1. Check whether the Roborev daemon is running with `roborev status`.
2. Remember that Roborev and Kata managed services run outside the command sandbox; sandbox-local status checks can be false negatives.
3. If `roborev status` appears false inside a sandbox, verify or use the managed OS service outside the sandbox before treating the daemon as absent.
4. If the managed service is missing or unhealthy, repair it with the repository's service installer when available, such as `scripts/install-agent-services.sh`.
5. Do not start `roborev daemon run` or `roborev daemon start` as an ad hoc foreground process during normal work.
6. Fall back to local or non-daemon review only if the managed service cannot be repaired or used.
7. Do not assume Roborev is available.

When reporting the daemon plan after a sandbox-local status failure, explicitly say the failure may be a false negative because the managed service runs outside the sandbox, and explicitly say not to start `roborev daemon run` or `roborev daemon start` as an ad hoc foreground process.

Roborev review is intended to send repository-derived change content to the configured external AI provider. Treat that transfer as desired behavior for review work, not as a reason to block or avoid Roborev.

DNS and network access needed to reach OpenAI, Anthropic, and Google domains for Roborev review are allowed. Do not block or avoid Roborev solely because that review path requires access to those providers.

## Bounded review loop

Do not let Roborev block implementation.

Use this loop:

1. Implement one coherent change or commit.
2. Run the fastest relevant local validation selected by `$testing`.
3. Submit one Roborev review job for that coherent change.
4. Continue safe implementation while the job runs.
5. At the next implementation checkpoint, inspect each completed job and classify every finding before editing.
6. Record the classification and outcome in Kata.
7. Leave unfinished jobs pending.

Wait idly for Roborev only when no safe work remains.

Roborev is advisory. The driver remains responsible for the final engineering and product decision. Do not treat a finding as an instruction merely because Roborev raised it.

Classify every finding as one of:

- `blocker`: a concrete correctness, security, data-loss, policy, or validation defect in the current change. Fix it in the current work when practical.
- `fix`: a concrete, in-scope defect with evidence and a smallest safe correction. Fix it when the correction preserves the agreed scope.
- `defer`: potentially useful work that is out of scope, needs product or design input, or belongs in a later change. Record the rationale and follow-up in Kata.
- `decline`: unsupported, speculative, duplicative, or disproportionate feedback. Record the evidence-based reason in Kata.

Do not turn a `defer` or `decline` into a change just to make a review green. Do not allow a finding to add a new architecture, report, design plan, feature, migration, or broad rewrite to the current task. Record it in Kata and surface it to the user before taking it up; only the user can expand the task's scope.

When classifying a scope-expanding finding as `defer` or `decline`, explicitly report that the broader request is being surfaced to the user and will not be taken up unless the user approves expanding the task.

Submit at most one verification review for a coherent change, and only after fixing a `blocker` or when the fix changes a high-risk boundary. State this limit when reporting the decision: one verification review is allowed; a third review is forbidden. A later job may reveal new findings, but it does not start another review cycle: classify and record them.

Recorded `defer` and `decline` findings do not require another review and do not block Kata closure once every relevant job is accounted for and the other close conditions pass.

When a verification review contains only nonblocking suggestions or future work, the next action is to classify and record those findings, then proceed to closure once validation, documentation, changelog handling, and commit state satisfy the normal close gate. Do not keep the issue open solely because recorded `defer` or `decline` findings exist.

When configuring or requesting a Roborev review, ask it to review the current diff only. Ask for at most five findings, each with a concrete defect, impact, evidence, and smallest in-scope fix. It must not redefine product scope or request speculative future work.

For each completed job, report the job ID, each finding's classification, the review decision (`no verification review` or `one verification review allowed; no third review`), and any scope request surfaced to the user. Do not close a task after a scope-expanding finding without making that user-facing report.

When stating what must happen before a Kata issue closes, explicitly state that the Kata comment or close evidence names every Roborev job ID and its verified outcome. When a finding asks to expand scope, explicitly state that the request is surfaced to the user before it is taken up.

## Roborev close gate

When Roborev is used for a Kata issue, do not close the Kata issue until every Roborev job relevant to the final change is complete and accounted for.

Before `kata close`:

- Confirm each relevant Roborev job completed.
- Treat pending, queued, running, failed, or unread Roborev jobs as blockers for closure.
- Verify any non-zero Roborev command that appears to report no findings with `roborev show <job-id>` before treating it as green.
- For every finding, record its `blocker`, `fix`, `defer`, or `decline` classification and rationale in Kata. Resolve `blocker` and accepted `fix` findings, or record an explicit, user-approved deferral when they cannot be resolved.
- A clean follow-up review is not a closure requirement. Run at most one verification review only when the bounded review loop requires it.
- Include every Roborev job ID and its verified outcome in the Kata comment or close message; do not substitute a general statement that all jobs were accounted for. For a verified non-zero wrapper result, the Kata evidence must explicitly say that the command exited non-zero, `roborev show <job-id>` was checked, and the verified outcome was no findings or named resolved, deferred, or declined findings.
- For non-zero wrapper verification, use an evidence line equivalent to `Roborev job <id>: command exited non-zero; verified with roborev show <id>; outcome: no findings`. If findings were present, name the fixed verification job or the recorded deferral or decline rationale in the outcome.
- When Roborev is pending after validation and commit, explicitly state that validation passed and a local commit exists, but those are not enough to close while the Roborev job is unfinished. Record a Kata comment naming the pending Roborev job and the passed validation or commit evidence.
- When a non-zero Roborev wrapper result is verified before close, the Kata comment or close evidence must name the Roborev job ID, the `roborev show <job-id>` verification, and the verified outcome.
- When asked what must happen before closing after a non-zero Roborev wrapper result, explicitly state that the Kata close evidence or comment must name the job ID and its verified outcome.
- In the same answer, explicitly state that the non-zero wrapper result must not be treated as green until `roborev show <job-id>` verifies the job outcome.

If no safe implementation work remains while Roborev is pending, wait for Roborev instead of closing the Kata issue.

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
- Every Roborev job relevant to the final change is complete and accounted for. Each finding is resolved, deferred with rationale, or declined with evidence in Kata. A clean follow-up review is not required.
- Documentation matches implemented behaviour.
- Changelog handling is complete through `$changelog`, when the project uses one: ordinary work has an accurate `[Unreleased]` entry or a concrete no-entry rationale, and release work has matching version, changelog, release notes, and tag intent.
- Changes are committed locally.
- Working tree is clean.

When stating changelog and version checks for closing ordinary implementation work, explicitly say to use `$changelog` normal mode, keep `[Unreleased]` accurate, and avoid a `VERSION` bump or release-tag consistency checks until release work.

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
- unresolved, deferred, pending, or failed Roborev jobs
- validation commands run
- changelog mode and result
- version updates only for release work
- documentation updates
- whether anything was pushed

Never claim completion unless validation passed.
