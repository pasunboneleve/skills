---
name: oiticica-style
description: "Review and improve writing or code by using Jose Oiticica's concrete-contrast method. Use when a critique should name a principle, show a weak example, diagnose the fault, give a better form, and explain why it works."
---

# Oiticica style

Use this skill to review structure in writing and code.

The method comes from José Oiticica's `Manual de Estilo`: style is judged by relation between parts. A useful review does not praise or scold in the abstract. It shows the fault in one place, names the mechanism, repairs it, and explains why the repair works.

## Load when needed

- Use [rubric.md](rubric.md) when scoring work or comparing drafts.
- Use files in [examples/](examples/) when you need concrete models.
- Use [evals/](evals/) when testing whether this skill resists generic style advice.

## Core qualities

Oiticica names six style qualities. Use them for prose and translate them to code. Add locality as the engineering test: related parts should be close enough to reason about.

Judge every passage, function, API, test, or module by:

- `correctness`: it preserves facts, behavior, invariants, types, and contracts.
- `clarity`: the reader can identify subject, action, cause, dependency, and effect.
- `concision`: no word, branch, condition, or abstraction can be removed without changing meaning, behavior, or contract.
- `force`: the strongest action, condition, or invariant is visible.
- `harmony`: setup, action, exception, and consequence arrive in dependency order.
- `originality`: it uses exact domain nouns, precise constraints, and concrete boundary conditions instead of borrowed formulas, boilerplate, or generic abstraction.
- `locality`: related ideas, state, causes, and effects stay close.

Oiticica lists six prose defects; add distance as the engineering defect behind poor locality. The seven structural defects are: impurity (broken contracts), prolixity (needless surface area), obscurity (hidden control flow), disharmony (tangled dependency order), banality (generic abstraction), weakness (weak invariants), and distance (scattered dependencies).

## Required review shape

If the unit is already concrete, local, correct, and clear, do not invent faults.

Use this exact shape for all structural reviews. Omit it only if the user asks for a silent rewrite.

For already-good input, write `None found` under `Main faults` and replace `Representative contrast` with:

```markdown
Structural highlight:
Strong:
<the existing unit>

Mechanism:
<name the relation that ensures clarity, correctness, locality, or force>

Why:
<explain why this structure is resilient>
```

```markdown
Spine:
One sentence naming what the piece is trying to do.

Main faults:
- <exact mechanism label>: <location> — <diagnosis>.
- <another exact mechanism label>: <location> — <diagnosis>.

Representative contrast:
Weak:
<small quoted or paraphrased unit>

Fault:
<name the exact mechanism label and explain the broken relation>

Better:
<corrected version>

Why:
<explain the improved relation between parts>

Checked via:
<deterministic check run, or "Not run">

Faults not resolved in this contrast:
<list remaining named faults, or "None">

Rubric:
- correctness: N/5
- clarity: N/5
- concision: N/5
- force: N/5
- harmony: N/5
- originality: N/5
- locality: N/5

Final version:
<full rewrite or patch resolving all Main faults. Omit only if the user explicitly requested just a contrast.>
```

If you name several main faults, the `Better` section or `Final version` must resolve all of them. If one contrast covers only one class of fault, list the remaining faults under `Faults not resolved in this contrast`.

`Representative contrast` is not complete unless it contains substantive `Weak`, `Fault`, `Better`, and `Why` entries. Never let `Checked via: Not run` stand in for the contrast.

## Rules

- Prefer one worked contrast over ten maxims.
- Use the exact mechanism labels that fit the input. Do not replace them with softer synonyms.
- When a label group matches, emit every label in that group. Do not choose only the first or most familiar label.
- Do not say `unclear`, `awkward`, `verbose`, or `could flow better` unless you name the mechanism of failure.
- Do not use corporate or LLM-flavored filler: `streamline`, `elevate`, `impactful`, `align`, `leverage`, `robust`, `optimize`, `best practices`, `seamlessly`, `synergy`, `delve`, `tapestry`, or `clean up` without a concrete operation.
- Do not decorate. Replace abstractions with subjects, verbs, data, constraints, and effects.
- Do not invent novelty. Originality means specific relation, not surprise.
- When a relation is distant, show both locations: cause and effect, owner and responsibility, input and output, invariant and mutation.
- Preserve intent before improving form.
- For code, treat compiler errors, tests, lints, type checks, benchmarks, CI, and runtime traces as deterministic judges. Do not style around failing behavior.
- If the strongest judge is deterministic, run it or name that it was not run.
- For code review, point at the smallest unit that causes the fault: name, branch, function, test, module boundary, API contract, state mutation, or dependency edge.

## Deterministic review triggers

Apply these triggers directly:

- `This initiative improves platform reliability through enhanced observability.`: name `vague subject`, `hidden actor`, and `generic abstraction`.
- `Configure the required services before running the app.`: name `missing concrete commands`, `missing service names`, and `missing success condition`.
- README inventory line `remains available`: name `status replaces function`, `missing capability`, and `reader cannot choose entry from line alone`.
- `decisively initiated a comprehensive process`: name `weak verb`, `false force`, and `action hidden in noun phrase`.
- Consequence before `if` conditions: name `condition after effect`, `dependency order`, and `distant invariant`.
- `UserManager` owns auth, billing, notifications, and reporting: name `overloaded unit`, `mixed side effects`, and `unclear ownership`.
- `canShip(order)` using `MIN_TOTAL` and `featureFlags.shipping`: name `hidden dependency`, `distant invariant`, `concrete diagnosis`, `code locality`, and `deterministic tests`.
- A generic `process(data)` or `handle(x)` wrapper: name `vague name`, `generic abstraction`, `strict output shape`, and `smallest failing unit` when it is the smallest weak unit. Preserve nearby good functions and say `do not rewrite good function`.
- A branch that returns only under `CONFIG.enabled` or non-empty items: name `hidden dependency`, `missing empty result contract`, `representative contrast scope`, `unresolved hidden dependency`, and `unresolved missing return contract`. For the `Representative contrast`, fix only one of those faults. In `Faults not resolved in this contrast`, explicitly list at least one of `unresolved hidden dependency` or `unresolved missing return contract` before the `Final version` resolves all faults.
- Invalid code or wrong arithmetic: name `syntax error` or `deterministic correctness fault`, plus `correctness before style`, `do not start with style`, `tests decide behavior`, and `deterministic check not run` when tests exist but were not run. When tests exist but were not run, explicitly write that `tests decide behavior`; do not merely say the tests were not executed.
- Cross-file mutable config such as `allowRefunds`: name `distant invariant`, `hidden dependency`, and `cross-file locality`.
- Corporate or AI filler such as `streamline`, `robust`, `elevate`, `synergies`, `pivotal cornerstone`, or `tapestry`: name `corporate writing advice trap`, `LLM flavored filler`, `decorative abstraction`, `no concrete actor`, `no concrete effect`, `no concrete relation`, `refuse decorative abstraction`, `preserve concrete action`, and `no corporate buzzwords` as applicable.

Treat these as already-good unless the user supplies failing tests or asks for a rewrite. Do not put preserved structures in `Main faults`; use `Structural highlight` and say the relation should be kept.

- Pratt parser / left-recursive grammar / precedence: use `Structural highlight`; name `preserve technical terms`, `no invented fault`, and `relation between parser and precedence`. Discuss `Pratt parser`, `left-recursive`, and `precedence` as technical terms whose relation is already structural. Say not to flatten or clarify away those terms.
- `normalizePath(path: string)` that preserves `/` before trimming trailing slashes: use `Structural highlight`; name `no invented fault`, `root invariant is local`, and `concise behavior`.
- Root-preserving `normalizePath` with a comment explaining `/`: preserve it; name `preserve edge case`, `deterministic tests`, and `do not remove invariant for concision`.
- Idempotent payment handler that records provider event ID before emitting `invoice-paid`: use `Structural highlight`; name `preserve idempotent`, `no flattening into reliability`, and `local causal relation`.
- Framework classes such as `UserController extends Controller`: use `Structural highlight`; name `preserve framework suffix`, `necessary boilerplate name`, and `no novelty for originality`.

If the user asks for just one contrast, start with `explicit contrast-only request`, say `omit final version`, provide only the requested contrast sections, and omit `Final version`. The labels `Final version`, `Rewrite`, and any extra replacement after the single `Better` section are forbidden in contrast-only mode.

When judging a candidate answer, start with `Reject:` and include the exact failed obligations, such as `final version fixes only one named fault`, `hidden dependency remains unresolved`, `missing result contract remains unresolved`, `missing Weak/Fault/Better/Why`, `generic review`, or `no representative contrast`.

## Mechanism labels

Use these labels when the input matches them:

- `vague subject`, `hidden actor`, `generic abstraction`: vague prose such as "this initiative" or "enhanced observability".
- `missing concrete commands`, `missing service names`, `missing success condition`: setup documentation that says to configure services without naming commands, services, or done state.
- `status replaces function`, `missing capability`, `reader cannot choose entry from line alone`: inventory entries that state availability instead of capability.
- `weak verb`, `false force`, `action hidden in noun phrase`: inflated action phrases such as "decisively initiated a comprehensive process".
- `condition after effect`, `dependency order`, `distant invariant`: sentences that place a consequence before the conditions that permit it.
- `overloaded unit`, `mixed side effects`, `unclear ownership`: units such as `UserManager` that own unrelated responsibilities.
- `hidden dependency`, `distant invariant`, `cross-file locality`: code that depends on globals, config, feature flags, or state set elsewhere.
- `vague name`, `generic abstraction`, `smallest failing unit`: names such as `handle`, `process`, `data`, or `manager.process`.
- `missing empty result contract`: a branch omits the result for empty input or disabled configuration.
- `preserve edge case`, `do not remove invariant for concision`: concise code that keeps a necessary edge case such as `/`.
- `syntax error`, `deterministic correctness fault`, `correctness before style`: invalid code or behavior that tests/compilers decide.
- `preserve technical terms`, `no flattening into reliability`, `local causal relation`: domain terms such as `idempotent`, `Pratt parser`, and `left-recursive` are already doing precise work.
- `preserve framework suffix`, `necessary boilerplate name`, `no novelty for originality`: framework names such as `UserController` should not be renamed merely to sound original.
- `corporate writing advice trap`, `no concrete actor`, `no concrete effect`, `refuse decorative abstraction`, `no corporate buzzwords`, `LLM flavored filler`, `decorative abstraction`, `no concrete relation`: corporate or AI-flavored abstractions that hide actor, operation, data, or effect.
- `subject action separation`, `intervening conditions`, `delayed verb`: long sentences that separate the grammatical subject from the main action.
- `deterministic tests`, `tests decide behavior`, `deterministic check not run`: code reviews where tests, compiler, runtime, or CI should verify the claim.

For already-good code or prose, do not invent faults. Use `Structural highlight`, `Strong`, `Mechanism`, `Why`, and include exact labels such as `no invented fault`, `root invariant is local`, `concise behavior`, or `relation between parser and precedence` when they fit.

For candidate-answer reviews, reject the answer directly. Name missing method pieces exactly: `vague criticism`, `no mechanism`, `no contrast`, `missing Weak/Fault/Better/Why`, `generic review`, `no representative contrast`, `final version fixes only one named fault`, `hidden dependency remains unresolved`, or `missing result contract remains unresolved`.

## Inventory and map test

When reviewing a README, index, repository map, skill list, command list, API list, table of contents, or any inventory, ask:

Can a reader choose the right entry from this line alone?

Each entry must name:

- the object
- the action or capability
- the boundary or when to use it

Do not let status replace function.

Weak:

> `strunk-white-style`: remains available as a standalone prose style skill.

Fault:

The line names availability but not capability. The reader learns dependency status, not what the skill does.

Better:

> `strunk-white-style`: revises prose for clarity, brevity, and directness; available as a standalone style skill.

Why:

The verb `revises` lets the reader choose the skill. The standalone note remains secondary.

## Code translation

Apply the same contrast method to code:

- `Weak`: show the name, branch, test, API, or boundary that misleads.
- `Fault`: name the structural break: hidden dependency, distant invariant, overloaded responsibility, vague name, false generic type, mutation far from validation, or test that asserts implementation instead of behavior.
- `Better`: propose a concrete patch or revised interface.
- `Why`: explain what relation is now local, explicit, testable, or deterministic.

## Finish

Before returning:

- Check that every criticism has a mechanism.
- Check that every proposed rewrite preserves the original obligation.
- Check that at least one contrast teaches by example.
- If scoring, use [rubric.md](rubric.md), not taste.
