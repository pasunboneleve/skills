---
name: strunk-white-style
description: Apply Strunk and White-style editing to drafts, documentation, emails, commit messages, UI copy, and other prose. Use when Codex is asked to revise, tighten, simplify, proofread, enforce concise writing, improve clarity, cut verbosity, or make text direct while preserving meaning and intent.
---

# Strunk and White style

## Purpose

Revise prose for clarity, brevity, force, and coherence. Preserve meaning, facts, voice, audience, and required terms.

## Revision workflow

1. Identify the audience, purpose, medium, and constraints.
2. Read the whole passage before editing. Do not optimise one sentence in a way that weakens the argument.
3. Make the smallest edits that improve clarity.
4. Keep necessary nuance. Do not flatten technical, legal, medical, or policy meaning for style.
5. Return the revised text first when the user asks for an edit. Add notes only when they help review.

## Editing rules

- Use Australian-style headings: capitalise only the first word and any proper nouns or acronyms.
- Prefer concrete nouns and strong verbs.
- Prefer active voice unless passive voice improves emphasis, tact, or accuracy.
- Cut needless words, throat-clearing, hedges, filler, and repetition.
- Replace vague abstractions with specific claims.
- Keep related words together. Put modifiers near what they modify.
- Put emphatic words at the end of a sentence or paragraph when useful.
- Vary sentence length only to aid rhythm and comprehension.
- Use parallel structure for parallel ideas.
- Break long sentences when structure obscures the main point.
- Prefer plain words over ornate or fashionable ones.
- Use positive form where it is clearer than negative form.
- Keep paragraphs focused on one point.
- Make headings concrete and short.

## Checks before returning

- Preserve facts, sequence, names, numbers, and commitments.
- Keep the tone fit for the context.
- Remove accidental new claims.
- Remove unexplained jargon only when the audience does not need it.
- Keep accepted domain terms when changing them would reduce precision.

## Output patterns

For a direct rewrite, return only the revised text unless the user asks for explanation.

When the user asks for review or coaching, use this structure:

- `Revised:` followed by the edited text.
- `Notes:` with short bullets for material changes or unresolved choices.

When editing a file, change it directly and summarise the main style decisions.

## Boundaries

Do not invent facts to make prose smoother. Do not remove required caveats. Do not turn precise technical text into generic advice. Do not expose private editing rationale when the user asked only for final copy.
