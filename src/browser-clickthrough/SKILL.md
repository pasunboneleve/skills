---
name: browser-clickthrough
description: Use when verifying that a UI change works end to end by driving the running app in a real browser — confirming a fix, reproducing a reported UI symptom, or proving a wizard/form/flow behaves — with Playwright against the exact code under review.
---

# Browser clickthrough verification

Use this skill to prove a UI change with a scripted browser clickthrough, not with a screenshot claim or a "looks right" assertion. The goal is deterministic evidence that the running app behaves as intended for the code under review.

## Pin the code under test

- Start the app from the EXACT commits under review and drive that running app in a real Playwright browser, without disturbing the working checkouts.
- Verification plans must name the app/server startup from the pinned worktree before Playwright drives the browser; code inspection alone is discovery, not clickthrough validation.
- When the branch is already checked out in the main working copy, add a DETACHED worktree at the commit SHA (`git worktree add --detach <path> <sha>`); a branch checked out elsewhere cannot be added to a second worktree.
- Symlink heavy, branch-independent dependencies (`.venv`, `node_modules`, `.env`) from the main checkout into each worktree instead of reprovisioning them.
- Point the local fullstack runner at the worktree parent. Treat this harness config as ephemeral: use absolute paths for the local run, keep them out of product files, and do not commit machine-specific paths.
- When giving setup steps, explicitly say that runner or harness path changes are local-only and must not be committed.

## Discover before scripting

- Find the target route, the seeded/demo entity ids, and the auth token `localStorage` keys from the app source — do not guess them.
- Confirm any server-side gate (feature flag, capability, permission) is satisfied for the test data before driving the UI, so a blank page is not misread as a bug.

## Drive the browser resiliently

- Seed authentication by writing the session tokens into `localStorage` before app code runs (e.g. Playwright `addInitScript`), then navigate straight to the target route. Do not automate the login form.
- In a single-page app, navigate with `domcontentloaded` plus explicit waits, never `networkidle` — long-poll and websocket traffic never idle.
- At every step, screenshot AND dump the interactive controls (headings, button text with disabled state, file inputs, visible body text), so the true DOM state is visible even when a selector misses.
- Advance through the flow in a loop that re-reads the current step and clicks the next control, so an unexpected intermediate step (a conditional page, a required selection) does not strand the run. Select required inputs before expecting a Next/submit control to enable.

## Assert on state, cross-check deterministically

- Verify from DOM state — a control's `disabled` attribute, row/element counts, the presence or absence of an error banner — not from a screenshot alone. State the concrete numbers observed.
- Cross-check a UI finding against a deterministic non-UI probe (call the same API the UI calls and inspect the response shape). Report the exact trigger and the actual observation, never the plan alone.
- A greyed or blocked control is a finding to EXPLAIN — name which inputs are unsatisfied — not an obstacle to route around or a validation to skip.
