---
name: docs-structure
description: Use this skill when creating or reorganising project documentation, especially deciding what belongs in README.md versus docs/. It keeps README concise and moves durable detail into focused docs.
---

# Docs structure

Use this skill when editing repository documentation.

Keep documentation useful at a glance without turning README.md into a dumping ground.

## Core rule

README.md is the synopsis. docs/ is the memory.

Do not put every design decision, tutorial, runbook, or architecture explanation in README.md. Do not hide essential first-run information deep in docs/.

When moving detailed setup or validation material out of README.md, explicitly keep
minimal first-run and validation commands in README.md and link from those short
sections to the detailed docs.

## README.md owns

README.md should answer, quickly:

- What is this?
- Why does it exist?
- What is the current shape?
- How do I run it locally?
- How do I validate it?
- Where do I go next?

Keep README.md short enough to scan in a few minutes.

Preferred README structure:

```markdown
# Project name

One-paragraph description.

## Why this exists

Short motivation.

## Architecture at a glance

Small diagram or bullet summary.

## Quick start

Minimal commands.

Link to `docs/development/local-dev.md` or the equivalent setup guide.

## Validation

Commands required before claiming work is done.

## Repository map

Short directory overview.

## Documentation

Links to docs/*.

## Status

Current maturity, known constraints, next work.
```

## README.md must not own

Move these to docs/:

- long architecture explanations
- design histories
- detailed runbooks
- detailed dependency installation notes
- detailed instructions for starting the program
- provider-specific deployment guides
- observability details
- ADRs
- tutorials
- troubleshooting catalogues
- contribution process details
- visual/design rationale
- large command references
- implementation notes that will grow

README may link to these docs.

## docs/ owns

docs/ stores durable detail in focused files with clear names.

Suggested structure:

```text
docs/
  architecture/
    overview.md
    content-events-visualisations.md
    observability.md
    rendering.md

  development/
    local-dev.md
    validation.md
    browser-inspection.md

  operations/
    deployment.md
    observability-runbook.md
    failure-drills.md

  decisions/
    0001-content-events-visualisations.md
    0002-local-observability-contract.md

  design/
    visual-language.md
    marginalia-navigation.md
```

Do not create empty directories speculatively.

Create docs only when there is real content.

When a documentation plan asks whether to create directories for possible
future content, answer that part directly. Reject future-only directories
until there is a concrete file to place in them.

If asked whether to create `docs/design/`, `docs/research/`, or any other docs
directory for possible future content, reject each future-only directory by name.

## Architecture docs

Architecture docs explain boundaries.

Prefer:

- ownership
- data flow
- replaceability
- failure modes
- validation

Avoid vague claims.

A good architecture doc says:

```text
This component owns X.
It does not own Y.
It receives A.
It emits B.
It can be replaced if C stays stable.
```

## ADRs / decisions

Use `docs/decisions/` for durable decisions.

Use this shape:

```markdown
# 0001 Decision title

## Status

Accepted | Superseded | Proposed

## Context

What forced the decision?

## Decision

What are we doing?

## Consequences

What improves?
What gets harder?
What must future changes preserve?
```

Do not write ADRs for trivial implementation details.

Do write ADRs for architectural boundaries.

## Runbooks

Use `docs/operations/` for runbooks.

Runbooks should be procedural.

They should answer:

- How do I know something is broken?
- Where do I look first?
- What IDs/logs/events matter?
- What command do I run?
- What does success look like?
- What should I not do?

## Development docs

Use `docs/development/` for workflow details.

Examples:

- required system and language dependencies
- dependency installation and version constraints
- environment variables and local configuration
- detailed instructions to start the program
- expected ports, URLs, services, and long-running processes
- local dev loop
- long-lived `bun run dev`
- browser inspection
- DevTools MCP / xvfb fallback
- validation commands
- failure drills
- test fixtures

README should contain only the shortest quick-start path.

README must link to detailed dependency and startup instructions in `docs/development/local-dev.md` or an equivalent focused file. If the project needs more than a few commands to install dependencies or start, keep the canonical explanation in docs/ and link to it from README.

## Documentation style

Write documentation as a map, not a diary.

Prefer:

- short sections
- explicit ownership
- concrete commands
- diagrams where they clarify flow
- links between related docs

Avoid:

- long narrative in README
- duplicated instructions
- unexplained acronyms
- stale "future plans" mixed with current behaviour
- marketing language inside technical docs

## When moving content

When documentation grows too large:

1. Keep the short version in README.md.
2. Move the full explanation to docs/.
3. Add a link from README.md.
4. Remove duplication.
5. Keep commands canonical in one place where possible.

## Validation

After documentation changes:

- Check links.
- Check commands still match package scripts.
- Check dependency and startup docs match package scripts, lockfiles, compose files, and declared runtime versions.
- Check README remains scannable.
- Check docs/ has no orphaned or needlessly duplicated explanations.
- Run formatting or markdown checks if available.

## Completion checklist

Before marking documentation work complete:

- README explains the project at a glance.
- README has quick start and validation commands.
- README links to detailed dependency and startup instructions in docs/.
- Detailed material lives in docs/.
- Architecture docs explain boundaries and ownership.
- Runbooks are procedural.
- Decisions are captured as decisions, not buried in prose.
- Links from README to docs/ work.
- No major content is duplicated without reason.
