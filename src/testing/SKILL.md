---
name: testing
description: Select the narrowest deterministic validation for a change by its blast radius. Use when choosing tests, checks, CI gates, or manual validation before claiming work is done.
---

# Testing

Validate the impacted blast radius, not the whole repository by default.

Choose the smallest deterministic check that would fail if the change is wrong:

- README or docs-only change with no upstream dependency: validate Markdown, links, assets, and rendered or source-visible correctness; skip code, API, release, and skill validation unless those surfaces changed.
- Implementation change with unchanged behavior: run the tests that cover that behavior or invariant.
- Behavior change: run tests for the changed behavior at the narrowest useful boundary.
- API or contract change: say the contract changed; required checks include direct API contract tests plus `concentric expansion` to parent systems that consume that API.
- Shared infrastructure, build, config, or cross-cutting change: expand validation to every subsystem that depends on the changed surface.

When focused checks have known names, report those exact commands or test names.

If no deterministic check exists, add a focused test when practical. Otherwise report the static or manual check used and the residual risk.

Do not run a broad validation suite merely because it exists. Reject that as over-broad. Report which broader checks were skipped and why they are outside the blast radius.

When reporting validation scope, always use these exact labels as plain text:

- `Blast radius:` name the changed surface and say when it is docs-only.
- `Required checks:` name the exact focused checks. For API contracts, include `Concentric expansion: direct API contract test -> parent consumer test`.
- `Skipped broad checks:` name skipped suites and why.

For API or contract changes, the `Required checks:` line must include the exact phrase `Concentric expansion:` and show the path from the direct contract test to the parent consumer test.
