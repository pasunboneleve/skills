---
name: changelog
description: Use when deciding changelog entries, maintaining [Unreleased], removing reverted unreleased entries, or preparing release version and changelog sections.
---

# Changelog

Use this skill when a project has a `CHANGELOG.md` or equivalent release history.

## Normal Mode

Use normal mode for implementation, documentation, packaging, test, workflow, and behavior changes before release.

- Complete normal-mode handling has three parts: maintain `[Unreleased]`, leave `VERSION` unchanged, and leave dated release sections for release mode.
- Record relevant changes under `[Unreleased]`.
- Do not bump `VERSION`.
- Do not create dated version sections.
- Keep entries about the net unreleased state, not the work history.
- Keep `CHANGELOG.md` as a human-readable standalone text file. Do not collapse release notes into version-control compare links, commit lists, issue lists, or diff summaries. Compare links may supplement the prose, but they must not replace meaningful entries.
- Add entries for user-facing changes, behavior changes, bug fixes, deprecations, removals, packaging changes, release-policy changes, and validation-policy changes.
- Allow no entry only with a concrete reason, such as an internal refactor with no behavior, packaging, validation, documentation, or user-facing impact.
- When reverting, abandoning, or superseding an unreleased change, remove or narrow its `[Unreleased]` entry in the same change.
- If a revert itself has user-visible impact, describe the resulting shipped state, not the transient change.

## Release Mode

Use release mode only when preparing a release.

- Read `[Unreleased]` and choose or confirm the SemVer version from the accumulated entries.
- Move the accumulated entries from `[Unreleased]` to `[MAJOR.MINOR.PATCH] - YYYY-MM-DD`.
- Create a fresh empty `[Unreleased]` section.
- Update the project version source, such as `VERSION`, to the same version.
- Verify the project version, changelog heading, release notes, and intended tag version agree.
- Preserve the human-readable entries when finalizing a release; do not replace them with a compare link or raw diff.
- Do not tag or call the release ready while the version source and changelog disagree.

## SemVer

Use SemVer: `MAJOR.MINOR.PATCH`.

- `PATCH`: bug fixes, refactors, documentation, tests, packaging metadata, validation-policy changes, or internal changes with no new user-visible capability and no breaking change.
- `MINOR`: new backwards-compatible user-visible capability.
- `MAJOR`: breaking changes to behavior, API, data format, command contract, or other external interface.

When in doubt, treat a change that adds no new user-visible capability as `PATCH`.

## Reject

Reject ordinary implementation commits that:

- bump `VERSION`;
- create dated release sections;
- replace human-readable changelog prose with version-control diffs, commit lists, issue lists, or compare links;
- leave reverted or abandoned behavior described under `[Unreleased]`;
- omit a needed `[Unreleased]` entry without rationale.

Reject release preparation that:

- leaves `[Unreleased]` entries duplicated in the release section;
- fails to recreate an empty `[Unreleased]`;
- leaves `VERSION`, changelog heading, release notes, or tag version inconsistent.
