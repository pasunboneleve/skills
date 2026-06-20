---
name: commit-discipline
description: Prepare small, reviewable local commits with explicit rationale, SemVer impact, task hygiene, branch cleanup expectations, and clear commit commentary. Use when asked to commit work, prepare a PR-ready change, decide version impact, write commit messages, or clean up merged feature branches.
---

# Commit discipline

## Dependencies

Load and apply `$oiticica-style` before writing non-trivial commit messages. Use it to keep commit commentary concrete: claim, decision, consequence, and remaining risk.

Load and apply `$testing` before deciding validation scope. Use it to choose the narrowest deterministic checks for the change's blast radius.

Load and apply `$changelog` when the project has a changelog or version file. For ordinary commits, use normal mode: update `[Unreleased]` when the change needs an entry, record a concrete no-entry rationale when it does not, and do not bump `VERSION` or create dated release sections.

## Core rules

- Keep commits small, coherent, and reviewable.
- Commit completed work locally after the selected validation passes.
- Do not push unless the user explicitly asks.
- This skill does not decide push branch targets; follow higher-level workflow or repository instructions for branch-target policy.
- Do not merge a PR unless CI is green.
- Close Kata issues once changes are complete, validated at the selected scope, and committed locally.
- Do not close Kata issues for uncommitted work.
- Track unfinished work in Kata, not TODO comments.
- After a feature branch is merged to `main`, remove the feature branch locally and remotely.
- Handle changelog state through `$changelog` before committing when the project has a changelog or version file.

## Task hygiene

- Do not leave TODO comments in code.
- Do not hide incomplete work in comments, dead code, or vague final notes.
- Before closing a Kata issue, confirm selected validation passed and the working tree is clean except for intentional final changes.

## SemVer classification

Use `$changelog` for SemVer classification and changelog policy.

For ordinary commits:

- Report the SemVer impact in the commit rationale when it matters.
- Keep version source changes for release preparation.
- Reject ordinary commits that bump `VERSION` or create dated changelog sections before release.
- When stating required changelog and version handling before commit, explicitly include all four outcomes: normal-mode handling, `[Unreleased]` entry or no-entry rationale, no `VERSION` bump, and no dated release section.

## Commit message rules

For simple mechanical changes, a concise subject may be enough.

For non-trivial changes, include:

1. `Context`: what problem, ambiguity, or risk made the change necessary.
2. `Decision`: what changed and which boundary, invariant, or behaviour is now enforced.
3. `Alternatives considered`: at least one plausible option and why it was not chosen.
4. `Tradeoffs`: what risk, limitation, or cost remains.
5. `Architectural impact`: which boundaries, interfaces, state flow, or failure paths changed.

A change is non-trivial when it:

- introduces or modifies an abstraction or boundary
- changes behaviour or invariants
- affects failure handling or external interfaces
- changes version, release, or compatibility expectations
- involves meaningful design tradeoffs

## Commentary style

- Explain what changed and why.
- Name tradeoffs directly.
- Prefer active voice.
- Omit needless words.
- Use concrete nouns and strong verbs.
- Avoid ceremony for simple edits.
- Wrap command literals in backticks, such as `grep` or `ls -lah`.
- Do not wrap proper names in backticks, such as Angular, Python, AWS, or .NET.
- When asked to state, name, or label this formatting rule, start with `command literals versus proper names`.
- Put reasoning in the commit message instead of scattering it across code comments.
