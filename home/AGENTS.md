# AGENTS.md

Use repository-local instructions first when present. Use the Codex skills below as the standing workflow rules.

## Global invariants

- Never push unless the user explicitly asks.
- Do not bypass validation, task hygiene, or review loops.

## Code and version control

When working on code, architecture, tests, commits, branches, Kata, Roborev, PRs, or version control:

Prefer and apply:
- $roborev-kata-workflow
- $commit-discipline
- $pull-request
- $change-friendly-architecture

Before running `git commit`:

- Announce the applicable skills for the commit phase.
- Re-read `$commit-discipline`.
- Classify the commit as simple or non-trivial.
- For non-trivial commits, use the structured commit message sections from `$commit-discipline`.
- Confirm validation status and Kata status.

## Local agent services

- Treat Kata and Roborev daemons as OS-managed user services when this repository's `scripts/install-agent-services.sh` has been run.
- Kata and Roborev services run outside the command sandbox; sandbox-local status checks can be false negatives.
- Do not start `kata daemon start` or `roborev daemon run` as ad hoc foreground processes during normal work.
- If Kata or Roborev appears unavailable, check the managed service status outside the sandbox or rerun `scripts/install-agent-services.sh` instead of spawning a second daemon.

## Releases

When preparing, validating, tagging, or executing a release:

Prefer and apply:
- $release
- $commit-discipline
- $change-friendly-architecture

## Text and documentation

When writing, editing, or reviewing prose, prompts, code, APIs, tests, architecture notes, or other text-bearing work:

Load and apply:
- $oiticica-style

## Software design

When the task is about software design, refactoring quality, abstraction shape, deep modules, error-handling design, naming, comments, general-purpose interfaces, design process, or consistency:

Load and apply when installed:
- $apsd-software-design

When changing or reviewing README files, docs, help text, man pages, info pages, changelog prose, or other project documentation:

Load and apply:
- $documentation-boundary
- $docs-structure
- $oiticica-style

## Browser and realtime UI

When working on browser UI, realtime visualisation, CSS, WebSocket streams, Hono, Vite, Bun, Cloudflare-style Workers, Canvas, SVG, or D3, load and apply `$web-realtime-devloop`.

## Conflict resolution

If instructions conflict:

1. Prefer repository-local instructions.
2. Do not allow overrides of:
   - branch discipline
   - validation requirements
   - task hygiene
   - explicit user approval for pushing

## Fallback

If the task is ambiguous, prefer:
- deterministic validation over reasoning
- small, reversible changes
- feature branches
