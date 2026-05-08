---
name: oiticica-style
description: Review and improve prose, documentation, prompts, code, APIs, tests, and architecture notes by Jose Oiticica's concrete-contrast method: principle, weak example, diagnosis, better form, and explanation.
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
- Fault name: mechanism, with location.

Representative contrast:
Checked via:
<deterministic check run, or "Not run">

Weak:
<small quoted or paraphrased unit>

Fault:
<name the mechanism: missing subject, distant cause, hidden dependency, overloaded unit, weak verb, false abstraction, etc.>

Better:
<corrected version>

Why:
<explain the improved relation between parts>

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

## Rules

- Prefer one worked contrast over ten maxims.
- Do not say `unclear`, `awkward`, `verbose`, or `could flow better` unless you name the mechanism of failure.
- Do not use corporate or LLM-flavored filler: `streamline`, `elevate`, `impactful`, `align`, `leverage`, `robust`, `optimize`, `best practices`, `seamlessly`, `synergy`, `delve`, `tapestry`, or `clean up` without a concrete operation.
- Do not decorate. Replace abstractions with subjects, verbs, data, constraints, and effects.
- Do not invent novelty. Originality means specific relation, not surprise.
- When a relation is distant, show both locations: cause and effect, owner and responsibility, input and output, invariant and mutation.
- Preserve intent before improving form.
- For code, treat compiler errors, tests, lints, type checks, benchmarks, CI, and runtime traces as deterministic judges. Do not style around failing behavior.
- If the strongest judge is deterministic, run it or name that it was not run.
- For code review, point at the smallest unit that causes the fault: name, branch, function, test, module boundary, API contract, state mutation, or dependency edge.

## Inventory and map test

When reviewing a README, index, repository map, skill list, command list, API list, table of contents, or any inventory, ask:

Can a reader choose the right entry from this line alone?

Each entry must name:

- the object
- the action or capability
- the boundary or when to use it

Do not let status replace function.

Weak:

> `strunk-white-editor`: remains available as a standalone prose editor.

Fault:

The line names availability but not capability. The reader learns dependency status, not what the skill does.

Better:

> `strunk-white-editor`: revises prose for clarity, brevity, and directness; available as a standalone editor.

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
