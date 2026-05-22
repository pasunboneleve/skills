---
name: release
description: Prepare and execute a versioned release through a feature branch, PR, green CI, protected main, merged release commit, version tag, and tag-triggered release workflows when present. Use when Codex is asked to prepare, validate, publish, tag, or execute a release.
---

# Release workflow

## Hard rules

- Prepare release changes on a feature branch, never on `main`.
- Do not push a branch, merge a PR, or push a tag unless the user explicitly asks to execute the release.
- Do not push directly to `main`.
- Ensure the remote protects `main` from direct pushes before release work starts.
- Never merge if a release assumption is false.
- Never merge a PR unless CI is green.
- Never tag until the release PR is merged and the repository's required CI gate is green.
- Never require release artifacts unless tag-triggered release automation exists.
- Never call an artifact release complete until its tag-triggered workflows pass.
- If an assumption is false or uncertain, stop and prompt the user.

## Dependencies

Load and apply `$testing` before choosing local validation commands. Use the validation scope it selects for the release change surface.

Load and apply `$changelog` in release mode before changing version or release-note files. Use it to choose or confirm the release version, move `[Unreleased]` entries into the dated release section, recreate empty `[Unreleased]`, update the project version source, and verify version, changelog, release notes, and intended tag agree.

When stating release file edits and consistency checks, explicitly say to use `$changelog` release mode and that tagging is blocked until the changelog section, project version, release notes input, and intended tag version agree.

## Branch protection

Before release preparation:

1. Identify the publishing remote and default branch.
2. Check whether remote `main` rejects direct pushes through branch protection or a ruleset.
3. If `main` is not protected, protect it before continuing.
4. Require pull requests and current CI checks before merge when the platform supports them.
5. Stop if credentials, permissions, or platform support prevent the check or correction.

For GitHub repositories, inspect protection with `gh api` or `gh ruleset list`. Use the narrowest rule that blocks direct pushes to `main` and requires PRs.

## Required preconditions

Before changing release files, verify:

1. Current branch is a feature branch. If on `main`, create or switch to a release feature branch.
2. Project version exists and conforms to SemVer.
3. Changelog has `[Unreleased]` entries to release.
4. Changelog heading matches the project convention.
5. `$changelog` release mode can make the changelog version, project version, release notes, and intended tag agree.
6. Documentation describes new user-facing features.
7. Help or usage output describes new command-line functionality, when the project exposes command-line help.
8. Release notes can be extracted from the changelog.
9. Selected local validation passes.
10. Release surface has been classified as artifact or tag-only.

## Release preparation

1. State that `$changelog` release mode owns release changelog and version edits.
2. Discover and inspect the project version source.
3. Inspect the changelog.
4. Use `$changelog` release mode to confirm the release version, finalize the changelog section, recreate `[Unreleased]`, update the version source, and verify consistency.
5. Check whether implemented changes include user-facing features or command-line changes.
6. If user-facing features exist, update docs and confirm `$changelog` has the matching release-note entry.
7. If command-line changes exist, update help text and verify help or usage output.
8. Extract release notes when the project has a script or generator.

## Release surface

Before tagging, inspect release automation.

For GitHub repositories, check `.github/workflows/` for workflows triggered by version tags, such as:

```yaml
on:
  push:
    tags:
      - "v*"
```

Also check workflows triggered by GitHub release events.

If a tag-triggered release workflow exists, treat the project as an artifact release. After pushing the tag, wait for the triggered workflow and verify its outputs.

If no tag-triggered release workflow exists, treat the project as tag-only. Do not require release artifacts or release workflow checks. A tag-only release is complete when the release PR is merged, the required CI gate is green, and the version tag is pushed.

## CI gate semantics

Treat the repository's required CI gate as green when one of these is true:

- A protected branch requires PR checks, the release PR merged through that protection, and the required PR checks passed.
- A post-merge workflow runs on `main` and the run for the merged release commit passed.

Do not require a separate post-merge `main` run when the repository has no push-to-main workflow or manual dispatch for the relevant validation. In that case, record that the protected PR check was the CI gate and that no separate main workflow exists.

Do not tag if a separate post-merge `main` workflow exists and has not passed for the merged release commit. In that case, explicitly say the `push-to-main workflow` must pass for the merged release commit.

When reporting this decision, include `Required CI gate status:` and state whether the gate was `protected PR CI` or `post-merge main CI`. If protected PR CI is the gate, also state `No separate post-merge main workflow exists` or `No separate main run is required`.

When protected PR CI is the gate and there is no post-merge `main` workflow, do not stop tagging solely because the merge commit has no separate main CI status. Report `Required CI gate status: protected PR CI. No separate post-merge main workflow exists; no separate main run is required.`

## Local validation

Run the validation selected by `$testing` before creating or updating the PR. The scope must match the release change surface, including docs, help, version, changelog, packaging, or behavior checks when those surfaces changed.

## PR and merge flow

After selected local validation passes:

1. Push the feature branch only if the user asked to execute the release.
2. Create or update the release PR.
3. Wait for PR CI to finish.
4. If PR CI is not green, do not merge.
5. If PR CI is green, merge the PR with the project convention.
6. Fetch and check out the updated `main`.
7. Verify `main` points at the merged release commit.
8. Determine the required CI gate:
   - If branch protection required the passing PR check and no separate post-merge `main` workflow exists, treat the protected green PR check as the release CI gate.
   - If a separate post-merge `main` workflow exists, wait for that workflow on the merged release commit.
9. If the required CI gate is not green, do not tag.

## Tag and release flow

After the PR is merged and the required CI gate is green:

1. Create the version tag on the merged `main` release commit.
2. Push the tag only if the user asked to execute the release.
3. For artifact releases, wait for tag-triggered workflows to finish.
4. For artifact releases, treat any failed release workflow as an incomplete release.
5. For tag-only releases, do not wait for workflows that do not exist.

For artifact releases, verify every workflow triggered by the tag. Do not assume one workflow covers the whole release when the project publishes multiple artifacts or separates release creation from artifact upload.

## Tag rules

- Use `vMAJOR.MINOR.PATCH` unless the project clearly uses another format.
- The tag version without leading `v` must match:
  - project version
  - changelog version entry
  - release PR content
  - release notes extraction input
- Do not reuse or move a pushed tag unless the user explicitly asks and the correction plan is clear.

## Stop conditions

Stop and prompt the user if:

- branch creation is ambiguous
- remote `main` is not protected and cannot be protected
- version is missing
- version is not SemVer
- changelog `[Unreleased]` entries are missing for changes being released
- changelog heading does not match the project convention
- `$changelog` release mode leaves the changelog, project version, release notes, or intended tag inconsistent
- release notes extraction fails
- documentation is stale or missing
- help output is stale or missing
- local validation fails
- PR CI is not green
- the required CI gate is not green
- merge strategy is not identified
- tag format is ambiguous
- tag-triggered release workflows fail for an artifact release
- credentials or permissions are missing

## Final output

Report:

- release version
- branch name
- main protection status or correction
- PR link or identifier
- PR CI status
- required CI gate status, including whether it was protected PR CI or post-merge main CI
- release surface: artifact or tag-only
- merge commit
- tag created
- tag pushed
- release workflow status
- validation commands run
- documentation, changelog, help, and version updates
- assumptions that required user confirmation

For artifact releases, do not call the release complete unless the PR was merged, the required CI gate passed, the version tag was pushed, and tag-triggered workflows passed.

For tag-only releases, do not call the release complete unless the PR was merged, the required CI gate passed, and the version tag was pushed.
