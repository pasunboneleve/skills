---
name: kata
description: "Use when tracking work with Kata: creating task inventories, backlog lists, follow-up work, searching or creating issues, assigning active work, recording comments and relationships, closing verified work, or reporting Kata task hygiene."
---

# Kata

Use this skill for [Kata](https://github.com/kenn-io/kata) lifecycle hygiene. Kata is the shared issue ledger; keep issue state true.

Task inventories belong in Kata, not repository commits. When an agent creates an inventory of tasks, first state that the inventory must not be committed to the repository unless the user explicitly asks for repository documentation.

## Start work

- Run `kata agent-instructions` when local Kata command guidance may have changed.
- Search before creating: `kata search "<query>" --json`.
- If no existing issue fits, create one with an idempotency key: `kata create "<title>" --body "<body>" --idempotency-key "<key>" --json`.
- Use `kata ready --json` to find unblocked work unless the user provides an issue.
- Assign active work before implementation: `kata assign <ref> <owner> --json`.
- If work continues from an assigned issue, confirm the issue ref before editing.

## During work

- Add concise comments for blockers, decisions, PRs, validation results, and deferred follow-ups:

```bash
kata comment <ref> --body "<note>" --json
```

- Use relationships when order matters: `kata edit <ref> --blocks <other-ref> --json` or `kata edit <ref> --blocked-by <other-ref> --json`.
- If inventory items are independently actionable, create separate Kata issues. If they are context for the current issue, add them as a Kata comment.
- Do not leave TODO comments in code when the work belongs in Kata.
- Do not use `kata delete` or `kata purge` unless the user explicitly asks for that exact destructive action and issue ref.

## Task Inventories

When creating a task inventory, backlog list, follow-up list, TODO inventory, or remaining-work list, explicitly state that it must not be committed to the repository unless the user asks for repository documentation.

Record task inventories in Kata:

- Create separate Kata issues for independently actionable items.
- Add contextual notes to the current issue with `kata comment <ref> --body "<note>" --json`.

## Finish Work

- Do not close before validation has passed and the relevant change is committed, merged, or intentionally delivered.
- For a concrete issue, write the exact ref in every lifecycle command; do not use `<ref>` once the ref is known.
- Close completed work with substantive prose and typed evidence:

```bash
kata close <ref> --done --message "<validation and delivery evidence>" --commit <sha>
```

- If validation fails or work is incomplete, leave the issue open, label it for review when appropriate, and add a comment naming the failure or blocker and next concrete action:

```bash
kata edit <ref> --label needs-review --json
kata comment <ref> --body "<validation failure or blocker; next concrete action>" --json
```

- Before final response, report each Kata ref and whether it was assigned, left open, closed, or deferred.

For completed issue `skills-abc` after successful validation and commit, use this shape:

```bash
kata assign skills-abc dmvianna --json
kata comment skills-abc --body "Validation passed: <command>. Commit: <sha>." --json
kata close skills-abc --done --message "Validation passed: <command>. Delivered in commit <sha>." --commit <sha>
```

Then report: `Kata issue skills-abc closed`.

## Reject

Reject Kata hygiene that creates or uses an issue but never assigns it, closes unvalidated work, or finishes a task while leaving its completed issue open.

When the issue ref is known, write the exact ref in the corrective commands. Never answer corrective commands with `<ref>` for a report that already names an issue.

For a completed validated issue left open, require this concrete shape with the real issue ref substituted:

```bash
kata assign <real-ref> <owner> --json
kata close <real-ref> --done --message "<validation and commit evidence>" --commit <sha>
```

For any other completed validated work left open, require:

- `kata assign <ref> <owner> --json`
- `kata close <ref> --done --message "<validation and delivery evidence>" --commit <sha>`
- A close message that names the validation result and commit, PR, merge, or delivery evidence.
