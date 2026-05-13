---
name: commit-discipline
description: Prepare small, reviewable local commits with explicit rationale, SemVer impact, task hygiene, branch cleanup expectations, and clear commit commentary. Use when Codex is asked to commit work, prepare a PR-ready change, close Beads after implementation, decide version impact, write commit messages, or clean up merged feature branches.
---

# Commit discipline

## Dependencies

Load and apply `$oiticica-style` before writing non-trivial commit messages. Use it to keep commit commentary concrete: claim, decision, consequence, and remaining risk.

Load and apply `$testing` before deciding validation scope. Use it to choose the narrowest deterministic checks for the change's blast radius.

## Core rules

- Keep commits small, coherent, and reviewable.
- Commit completed work locally after the selected validation passes.
- Do not push unless the user explicitly asks.
- Push only feature branches, never `main`.
- Do not merge a PR unless CI is green.
- Close Beads once changes are complete, validated at the selected scope, and committed locally.
- Do not close Beads for uncommitted work.
- Track unfinished work in Beads, not TODO comments.
- After a feature branch is merged to `main`, remove the feature branch locally and remotely.

## Task hygiene

- Create or update a Bead before substantial work.
- Keep each Bead scoped to a reviewable unit.
- Record follow-up work as a Bead when it is real and deferred.
- Do not leave TODO comments in code.
- Do not hide incomplete work in comments, dead code, or vague final notes.
- Before closing a Bead, confirm selected validation passed and the working tree is clean except for intentional final changes.

## Version impact

Use SemVer: `MAJOR.MINOR.PATCH`.

- `PATCH`: bug fixes, refactors, documentation, tests, cosmetic changes, or internal changes with no new user-visible capability and no breaking change.
- `MINOR`: new backwards-compatible user-visible capability.
- `MAJOR`: breaking change to behaviour, API, data format, command contract, or other external interface.

When in doubt, treat a change that adds no new user-visible capability as `PATCH`.

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
- When asked for this formatting rule, name the distinction as command literals versus proper names.
- Put reasoning in the commit message instead of scattering it across code comments.
