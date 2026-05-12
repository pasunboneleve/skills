---
name: beads
description: "Use when tracking work with Beads or bd: creating issues, claiming ready work, updating issue notes, managing dependencies, closing completed work, or reporting Beads task hygiene."
---

# Beads

Use this skill for [Beads](https://github.com/gastownhall/beads) lifecycle hygiene. Beads track work; keep their state true.

## Start work

- Use `bd ready` to find unblocked work unless the user provides a Bead.
- Use `bd create` for new discovered work that is real and out of scope for the current Bead.
- Before implementation, run `bd update <id> --claim`. This claims the Bead and sets it `in_progress`.
- If work continues from an existing `in_progress` Bead, confirm the Bead ID before editing.

## During work

- Add concise notes for blockers, decisions, PRs, validation results, and deferred follow-ups:

```bash
bd update <id> --append-notes "<note>"
```

- Use dependencies when order matters: `bd dep add <blocked> <blocker>`.
- Do not leave TODO comments in code when the work belongs in a Bead.

## Finish work

- Do not close before validation has passed and the relevant change is committed, merged, or intentionally delivered.
- For a concrete Bead ID, write the exact ID in every lifecycle command; do not use `<id>` once the ID is known.
- Before closing completed work, record validation and delivery evidence:

```bash
bd update <id> --append-notes "<validation and commit or delivery evidence>"
```

- Close completed work with evidence:

```bash
bd close <id> --reason "<validation and delivery evidence>"
```

- If validation fails or work is incomplete, leave the Bead open and run `bd update <id> --append-notes "<validation failure or blocker; next concrete action>"`. The note must explicitly name the validation failure or blocker and the next concrete action.
- Before final response, report the Bead ID and whether it was claimed, left open, closed, or deferred.

For completed Bead `skills-abc` after successful validation and commit, use this shape:

```bash
bd update skills-abc --claim
bd update skills-abc --append-notes "Validation passed: <command>. Commit: <hash or message>."
bd close skills-abc --reason "Validation passed: <command>. Delivered in commit <hash or message>."
```

Then report: `Bead skills-abc closed`.

## Reject

Reject Beads hygiene that creates or uses a Bead but never claims it, closes unvalidated work, or finishes a task while leaving its completed Bead open.

For completed validated work left open, require:

- `bd update <id> --claim`
- `bd close <id> --reason "<validation and commit or delivery evidence>"`
- A close reason that names the validation result and commit, PR, merge, or delivery evidence.
