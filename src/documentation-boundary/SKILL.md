---
name: documentation-boundary
description: Distinguish README synopsis work from actual documentation updates. Use when README, docs, CLI help text, man pages, GNU info files, changelog prose, or project documentation are changed or reviewed.
---

# Documentation boundary

## Core distinction

`README.md` is a project synopsis, not the full documentation.

Use `README.md` to help a reader decide quickly:

- what the project is
- what problem it addresses
- whether it is relevant to them
- where to go next

Put documentation in:

- `docs/`
- CLI `--help` output
- man pages
- GNU info files
- dedicated reference or guide material

## README rules

When editing `README.md`:

- keep it short
- frontload purpose and relevance
- link to real documentation instead of duplicating it
- avoid turning it into a manual
- move long procedural detail to docs or help text
- reject README-only runbooks, tutorials, troubleshooting catalogs, or command references when those details belong in docs, help text, man pages, info pages, or dedicated references

## Documentation rules

When changing behaviour or adding features, update the real documentation surface:

- `docs/`
- relevant `--help` output
- man pages or info pages, if present

Do not claim documentation is updated if only `README.md` changed.

Do not treat changelog prose, release notes, or commit summaries as the real documentation update for changed behaviour.

When CLI behaviour changes, update the user-facing CLI surface that explains that behaviour, such as `--help`, man pages, or info pages when present. Updating docs alone is not enough when the command itself exposes help for the changed behaviour.

If CLI help or man pages exist for changed CLI behaviour, do not close the task as fully documented until those surfaces are updated. Report that docs and changelog may already be changed, but CLI help and man or info pages still need updates.

For docs-only maintenance, such as README synopsis edits, link fixes, or prose cleanup, do not require feature documentation for unchanged behaviour. Still report which documentation surfaces changed.

Do not apply checklist items mechanically. Require CLI help, man pages, info pages, changelog prose, or docs updates only when the changed behaviour or changed documentation surface makes them relevant.

## Dependency

Before finalising prose changes, load and apply `$oiticica-style`.

Apply it to:

- README synopsis text
- docs prose
- CLI help text
- man or info text
- changelog prose

## Validation

Before completion, report which surfaces changed:

- README synopsis
- docs
- CLI help
- man or info pages
- changelog

If behaviour changed and no documentation surface changed, explicitly say why.
