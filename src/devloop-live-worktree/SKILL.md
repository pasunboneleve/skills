---
name: devloop-live-worktree
description: Use when changing what a running devloop harness serves — pointing it at a different directory or worktree, or making the live harness serve newer or different code (a newer commit, another branch, or in-progress edits) without a wasteful restart.
---

# Devloop live worktree

Use this skill to decide whether a change to what a running devloop harness serves needs a restart, a path change, or neither. Change the least that produces the intended code in the running harness.

## Know when devloop rereads config

- Devloop resolves `root` and each process `cwd` only at STARTUP; it does NOT hot-apply config edits. Its config-change watch only logs "restart devloop to reload".
- A running process holds the working directory and file-watchers that were resolved when devloop spawned it.

## Change the DIRECTORY devloop serves — restart

- To point devloop at a DIFFERENT directory (edit `root`/`cwd` in the `devloop.*.toml`), you MUST restart devloop: stop it, then re-run it.
- A symlink relink does NOT redirect an already-running process — it holds the resolved real path, so a relink affects only the next spawn and cannot avoid the restart.

## Serve NEWER or DIFFERENT code from the SAME directory — no restart

- To serve newer or different code from the directory devloop already points at, do NOT change paths and do NOT restart. `git checkout <sha|branch>` inside that directory, or just edit files there.
- A dev server with hot reload (e.g. Vite HMR) and an autoreloading app server (e.g. Django `runserver`) recompile in place, so the running harness serves the new code immediately.
- When the harness points at a DETACHED git worktree pinned to a commit, advance it to newer code with `git checkout <newer-sha>` inside that worktree — still no restart.

## Respect the one-branch-per-worktree constraint

- Git refuses to check out the same branch in two worktrees. A branch checked out in the main working copy cannot also be checked out in a second worktree.
- So a harness worktree that must reflect such a branch is created DETACHED at the commit SHA (`git worktree add --detach <path> <sha>`) and advanced per commit; OR point the harness at the main checkout itself, which reflects live (even uncommitted) edits via hot reload.

## Choose the harness target by intent

- Point the harness at a pinned/detached worktree to verify a FROZEN commit without disturbing the working checkout.
- Point the harness at the MAIN checkout when ITERATING, so live edits show via hot reload with no per-commit checkout dance.

## Do not split serving from working just to iterate

- To iterate, point devloop at the SINGLE tree you actually edit. Hot reload reflects every save with no sync step, so a second "serving" worktree adds a sync step and buys nothing.
- A dedicated serving worktree pays off ONLY for ISOLATION: keeping the harness on a frozen commit, or serving one branch while you edit another.
- Because the same branch cannot be checked out in two worktrees, that serving worktree must be DETACHED and advanced with `git checkout <sha>` after each commit. It therefore inherently lags to COMMITTED code and cannot show uncommitted edits — it is not a `git pull` of the work branch.
- Treat the two-worktree split as isolation-only, never the default for iterating.
- When rejecting a two-worktree iteration plan, explicitly say the detached serving worktree advances only to committed code by checkout and cannot reflect uncommitted edits.
