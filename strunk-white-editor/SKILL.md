---
name: strunk-white-editor
description: Apply Strunk and White-style editing to drafts, documentation, emails, commit messages, UI copy, and other prose. Use when Codex is asked to revise, tighten, simplify, proofread, enforce concise writing conventions, improve clarity, reduce verbosity, or make text more direct while preserving meaning and intent.
---

# Strunk and White editor

## Purpose

Revise prose for clarity, brevity, force, and coherence. Preserve the writer's meaning, facts, voice, audience, and required terminology.

## Revision workflow

1. Identify the audience, purpose, medium, and any constraints from the surrounding task.
2. Read the whole passage before editing. Do not optimise one sentence in a way that weakens the argument.
3. Make the smallest edits that improve clarity and force.
4. Keep necessary nuance. Do not flatten technical, legal, medical, or policy meaning for style.
5. Return the revised text first when the user asks for an edit. Add brief notes only when they help the user review the change.

## Editing rules

- Prefer concrete nouns and strong verbs.
- Prefer active voice unless passive voice better serves emphasis, tact, or accuracy.
- Cut needless words, throat-clearing, hedges, filler, and repetition.
- Replace vague abstractions with specific claims.
- Keep related words together. Put modifiers near what they modify.
- Put emphatic words at the end of a sentence or paragraph when useful.
- Vary sentence length only to aid rhythm and comprehension.
- Use parallel structure for parallel ideas.
- Break long sentences when coordination or subordination obscures the main point.
- Prefer plain words over ornate or fashionable ones.
- Use positive form where it is clearer than negative form.
- Keep paragraphs focused on one point.
- Make headings concrete and short.

## Checks before returning

- Confirm the revision preserves facts, sequence, names, numbers, and commitments.
- Confirm the tone still fits the context.
- Remove accidental new claims.
- Remove unexplained jargon only when the audience does not need it.
- Keep accepted domain terms when changing them would reduce precision.

## Output patterns

When the user asks for a direct rewrite, return only the revised text unless they request explanation.

When the user asks for review or coaching, use this structure:

- `Revised:` followed by the edited text.
- `Notes:` with short bullets for material changes or unresolved choices.

When editing a file, make changes directly and summarise the main style decisions in the final response.

## Boundaries

Do not invent facts to make prose smoother. Do not remove required caveats. Do not turn precise technical text into generic advice. Do not expose private editing rationale when the user asked only for final copy.
