---
name: devloop
description: Use when working with the devloop local automation tool, devloop.toml files, watched workflows, managed processes, event endpoints, browser reload hooks, readiness or liveness probes, or devloop environment interpolation.
---

# Devloop

Use this skill for [`devloop`](https://github.com/pasunboneleve/devloop) configuration, troubleshooting, validation plans, and behavior claims.

Prefer devloop's own built-in guidance over remembered behavior or copied docs. Do not tightly couple the answer to the current source documentation when the tool can describe itself.

## Discover the tool

Before teaching, configuring, or troubleshooting devloop:

- Run `devloop` without arguments first and read the output.
- If the output exposes help or docs entry points, run the present entries. Check common candidates such as `--help`, `help`, `docs`, and `--docs`, but do not claim an argument exists until the tool output or command result proves it.
- If `devloop` is not on `PATH`, find the local project command or wrapper, then run the equivalent no-argument invocation before trying help or docs arguments.
- Use built-in help/docs output as the primary source for commands, flags, config shape, and examples.
- Use repository docs or source only to resolve gaps, verify surprising behavior, or investigate implementation details that built-in help does not cover.
- Report which devloop commands were run and what each command proved.

For usage plans, start with:

```markdown
Devloop discovery:
- No-arg command:
- Help/docs commands:
- Built-in guidance used:
- Argument proof rule: Do not claim an argument exists until devloop output or a command result proves it.
- Command report: Report which devloop commands were run and what each proved.
- Remaining source/doc checks:
```

## Runtime validation

Before claiming a devloop workflow works, produce deterministic evidence:

- Identify the config path, root, watched paths, workflow, process, event, and probe involved.
- Start or reuse one devloop session only when runtime behavior must be observed.
- Trigger a specific watched file change, event endpoint call, process restart, or probe request.
- Report the exact command, trigger, expected observation, and actual observation.
- Surface startup, probe, process, watcher, and interpolation failures as failures. Do not replace them with inferred success.

For validation plans, use this shape:

```markdown
Devloop validation:
- Config:
- Environment source:
- Trigger:
- Expected observation:
- Evidence command:
- Pass condition:
- Failure condition:
- Result claim: Do not claim validation passed until the evidence command has produced the expected observation.
```

For reviews, reject plans that rely only on static inspection when the claim is about runtime watcher, process, event, browser reload, readiness, or liveness behavior.

## Boundaries

- Do not push branches or commit changes unless the user explicitly asks.
- Do not bypass repository validation.
- When changing this skill, update `evals/evals.yaml` with positive and negative eval cases.
