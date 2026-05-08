# Oiticica rubric

Score each dimension from 1 to 5. Use concrete evidence, not preference.

## Correctness

1. Breaks facts, behavior, invariants, types, or contracts.
2. Preserves the surface claim but drops an important condition or edge case.
3. Preserves the main contract but contains one unverified edge case or relies on one implicit invariant.
4. Correct and explicit about important constraints.
5. Correct under deterministic checks or cites the exact unchecked risk.

## Clarity

1. The reader cannot find the subject, action, or result.
2. The subject exists, but cause, ownership, or effect is distant.
3. The primary subject and action are present, but separated by a long condition, aside, or subordinate clause.
4. Subjects, actions, causes, and effects are visible in order.
5. Every subject, cause, and dependency appears immediately before the action or effect that requires it. No forward reference or backtracking is needed.

## Concision

1. Includes material that changes neither meaning nor behavior.
2. Repeats a claim, branch, helper, or explanation with minor variation.
3. Has removable words, branches, helpers, or examples, but they do not change the main obligation.
4. Each part supports the purpose or a known constraint.
5. Every branch, parameter, noun, and sentence maps to observable behavior, explicit contract, or necessary meaning. No abstraction exists just in case.

## Force

1. Hides the decisive verb, invariant, failure, or user action.
2. Hides the actual mutation or user action behind a generic helper verb such as `handle`, `process`, `manage`, or `improve`.
3. Names the action but buries it among equal details.
4. Places the exact verb at the sentence's main verb. For code, places the mutation at the clearest point of execution, unburied by deep nesting or generic delegates.
5. Makes the strongest relation unavoidable without exaggeration.

## Harmony

1. Primary subject, action, and effect are separated by unrelated conditions, exceptions, or asides.
2. Dependencies, exceptions, or subordinate ideas interrupt the main path.
3. A secondary condition, exception, or dependency appears before the primary subject or action it modifies.
4. Order follows the reader's need: setup, action, consequence.
5. The order exposes contrast, escalation, or state flow without requiring backtracking.

## Originality

Here `originality` means specificity. It does not reward novelty, surprise, or decorative invention.

1. Uses borrowed formulas, generic abstractions, or decorative phrases.
2. Uses categorical labels such as `ConfigurationError` or `optimization` without the exact data, failure, or constraint.
3. Names a specific detail but buries it in boilerplate framing.
4. Names the particular object, behavior, or constraint.
5. Uses domain nouns, exact boundary conditions, and local constraints instead of boilerplate labels such as `Manager`, `Processor`, or `improve outcomes`.

## Locality

1. Requires hunting across the text or code for subject, cause, dependency, invariant, or effect.
2. Important related parts are separated by incidental material.
3. The relation is recoverable but not placed where it is used.
4. Related parts are close enough for local reasoning.
5. The unit can be reviewed, changed, and tested without reconstructing distant context.
