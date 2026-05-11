---
name: change-friendly-architecture
description: Review or design software architecture so changes stay local, explicit, testable, and observable. Use when code structure, module boundaries, interfaces, abstractions, tests, or error handling need architectural judgment.
---

# Change-friendly architecture

## Core aim

Optimise for systems that are easy to change, not just easy to run.

Prefer designs where a future change can be made by understanding one small area, with clear inputs, outputs, tests, and failure paths.

## Design defaults

- Start simple. Add complexity only when real use cases demand it.
- Preserve existing user-visible behaviour unless intentionally changing it.
- Prefer composition over inheritance.
- Prefer small modules with clear responsibilities.
- Prefer explicit interfaces over convenience helpers across boundaries.
- Use helpers within a module to reduce local duplication.
- Apply DRY carefully. Do not introduce shared abstractions that increase coupling.
- Prefer idiomatic constructs over bespoke patterns.

## Boundaries and encapsulation

- Keep responsibilities local and named.
- Hide implementation details behind narrow interfaces.
- Pass meaningful state explicitly.
- Avoid hidden or ambient state.
- Do not rely on implicit coupling through environment, shared globals, or call order.
- Prefer textual or data-shaped interfaces when they reduce coupling.
- Keep architecture legible. If safe use of an abstraction requires reading its internals, the boundary is too leaky.

## Separation of concerns

- Prefer a pure core with an imperative shell.
- Keep business rules, state transitions, and decisions separate from I/O.
- Put side effects at the edges: filesystem, network, subprocesses, clocks, randomness, environment, databases, and user interfaces.
- Make external dependencies replaceable through small ports or adapters.
- Avoid cross-module convenience APIs that hide control flow or ownership.

## Locality and blast radius

- Favour local reasoning over global coordination.
- Prefer decoupling over reuse when reuse would widen the change surface.
- Treat a change that touches many unrelated modules as a design warning.
- Keep changes near the behaviour they affect.
- Avoid abstractions that force callers to know unrelated implementation details.
- Prefer explicit signals over timing-based coordination. Do not use `sleep` to fix races.

## APIs and abstractions

- Introduce an abstraction only when it makes change easier, reduces meaningful duplication, or protects a stable boundary.
- Reject abstractions that exist only to remove superficial duplication.
- Keep APIs narrow, intentional, and hard to misuse.
- Make invalid states difficult to represent where the language or framework supports it.
- Prefer explicit parameters and return values over ambient context.
- Preserve useful failure context at boundaries.

## Testing and mocks

- Design core logic so it can be tested without live external systems.
- Mock or fake external boundaries, not internal implementation details.
- Test behaviour and invariants at the narrowest useful boundary.
- Keep tests easy to run locally.
- Use integration tests where module interactions, external contracts, or failure paths matter.
- If a test needs process-global state, isolate that mutation in a small helper and serialize access.

## Failure and observability

- Silent failure is unacceptable.
- Make failures visible and diagnosable.
- Do not swallow errors without intent.
- Preserve useful context in logs, artifacts, summaries, or returned errors.
- Fail loudly on missing required configuration.
- Prefer loud, non-fatal failures when the system can safely continue.
- Do not expose internal errors, stack traces, or sensitive details in user-facing HTTP responses.

## Smells to question

- A change requires touching many unrelated modules.
- An abstraction requires reading its implementation to use safely.
- Shared helpers introduce hidden coupling.
- Error handling leaks internal details across boundaries.
- A refactor increases indirection without making change easier.
- Tests are hard to run locally.
- Duplication was removed by introducing a worse abstraction.
- `sleep` is used to fix a race.

## Review checklist

- Does this make the system easier to change?
- Is coupling reduced or made explicit?
- Is the abstraction justified by real use?
- Are responsibilities local and clear?
- Are APIs narrow and intentional?
- Is state passed explicitly?
- Are failure paths visible and safe?
- Can the core be tested without live external systems?
- Are mocks placed at real boundaries?
- Is the blast radius of future changes limited?
- Is unfinished work tracked outside the code?
