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
- Avoid broad functions, modules, and files that gather unrelated reasons to change.
- Prefer explicit interfaces over convenience helpers across boundaries.
- Use helpers within a module to reduce local duplication.
- Wrap repeated boilerplate in local helpers, data declarations, or focused adapters instead of leaving it bare at every call site.
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
- Prefer composing a workflow from clear transformations or actions in one visible place over threading main logic through many pass-through modules. Haskell-style `do` notation, pipelines, and similar composition forms are good when they make the sequence legible while keeping steps focused.
- Avoid abstractions that force callers to know unrelated implementation details.
- Prefer explicit signals over timing-based coordination. Do not use `sleep` to fix races.

## APIs and abstractions

- Introduce an abstraction only when it makes change easier, reduces meaningful duplication, or protects a stable boundary.
- Reject abstractions that exist only to remove superficial duplication.
- Keep APIs narrow, intentional, and hard to misuse.
- Make invalid states difficult to represent where the language or framework supports it.
- Do not overfit types to today's cases when new behavior would force widespread constructor matches, schema branches, or caller rewrites.
- Reject domain types that encode a cartesian product of independent dimensions, such as product kind plus lifecycle state, when future cross-cutting behavior would require constructor and pattern-match churn.
- Treat wire-format compatibility as insufficient when every minor schema change still requires many producers and consumers to add encode/decode logic.
- Do not reject precise types or record schemas when they protect a stable boundary, model durable invariants, or enforce parity between real and mock runtimes without spreading ordinary product changes.
- For shared event schemas, keep owner-specific fields near the owning producer and consumers. Prefer ownership-specific events, stable canonical boundaries, adapters, or local translation when a shared package would make unrelated services absorb schema churn.
- Prefer explicit parameters and return values over ambient context.
- Preserve useful failure context at boundaries.

When reviewing plugin or extension APIs, do not accept a broad context, environment, or service locator merely because it is typed, read-only, or keeps function signatures stable. Require plugins to declare the small capabilities they need, and pass those capabilities through explicit ports, adapters, or scoped inputs.

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
- Type or schema changes require edits across many unrelated modules.
- A compatible schema still spreads translation work across many producers and consumers.
- Main behaviour is hard to see because it is threaded through many tiny pass-through modules.
- Boilerplate is repeated bare at every call site instead of gathered behind a local shape.
- Error handling leaks internal details across boundaries.
- A refactor increases indirection without making change easier.
- Tests are hard to run locally.
- Duplication was removed by introducing a worse abstraction.
- `sleep` is used to fix a race.

When reviewing a shared helper proposed mainly to remove duplication across unrelated subsystems, say that superficial reuse does not justify widening the change surface. Prefer local responsibilities unless the helper protects a stable, explicit boundary.

When reviewing restrictive types or schemas, evaluate how many files must change for the next plausible behaviour. If the representation is type-safe or wire-compatible but still amplifies ordinary changes across many modules, reject it as not change-friendly and recommend a stable boundary, local translation layer, or behaviour-oriented composition.

When a design contains both a churn-prone shared schema and a precise boundary schema, separate them explicitly. Reject the schema that spreads ordinary product changes across unrelated producers and consumers, while preserving precise record schemas that enforce a stable API or real/mock runtime parity.

When comparing alternatives, explicitly name which option is more change-friendly, why the rejected option widens future changes, and what replacement shape would localize the change.

When reviewing workflow structure, distinguish visible composition from scatter. Prefer a visible workflow that composes focused actions, such as a pipeline or Haskell-style `do` notation shape, and gather repeated logging, metrics, and error wrapping behind local helpers or adapters.

When reviewing a broad function, module, or file, reject boundaries that group unrelated workflows around one noun or owner. Split by behavior, use case, or true ownership while preserving each workflow's visible composition point. Connect workflows through narrow explicit interfaces only where real coordination is needed.

When reviewing tests that mutate process-global state such as time, environment, or working directory, require that mutation to be isolated in a small helper and serialized when parallel tests would interfere.
Do not accept serializing the whole test suite as the primary fix for process-global mutation; scope serialization to the tests or helper that actually mutates global state.

## Review checklist

When rejecting a design or test plan, state the replacement shape: local responsibilities, explicit inputs and outputs, visible failure paths, test boundaries, and any boundary fakes or adapters needed.

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
