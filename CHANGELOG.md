# Changelog

All notable changes to this repository are documented in this file.

This project uses SemVer. Version tags use the `vMAJOR.MINOR.PATCH` format.

## [Unreleased]

## [2.2.5] - 2026-07-07

### Changed

- Added the Ousterhout-inspired [`apsd-software-design`](https://github.com/pasunboneleve/a-philosophy-of-software-design-skills) skill set to `home/AGENTS.md` as the standing software-design guidance for design, refactoring, abstraction, error handling, naming, comments, and design-process tasks.
- Added `docs/CONTRIBUTING.md` and moved the detailed local `skill-validator` and `skilpel` validation dependency guidance out of the README synopsis into that contributing guide.
- Added GitHub PR review-thread handling guidance to `home/AGENTS.md`, requiring addressed comments to receive per-thread replies before resolution.

## [2.2.4] - 2026-06-28

### Changed

- Tightened the `skill-project` global-instruction-link eval so the prompt no longer teaches the Pi and `~/.agents` answers directly, improving its skill-ablation quality.

## [2.2.3] - 2026-06-26

### Changed

- Updated `scripts/link_skills.sh` to mirror the shared skill tree into `~/.agents/skills`, link the hosted home instructions into `~/.codex/AGENTS.md`, `~/.claude/CLAUDE.md`, and `pi`'s actual global context path at `~/.pi/agent/AGENTS.md`, and mirror the same `AGENTS.md` into `~/.agents/AGENTS.md`.
- Updated the root `README.md` synopsis to present this repository as a shared skill set for Codex, Claude Code, and Pi, with links to each agent's main site.

## [2.2.2] - 2026-06-20

### Changed

- Removed the hosted `home/AGENTS.md` directive that separately forbade direct pushes to `main`; the remaining workflow still limits pushes to feature branches and requires explicit user approval before any push.

## [2.2.1] - 2026-06-20

### Changed

- Updated `commit-discipline` to stop forbidding pushes to `main`, delegate branch-target policy to higher-level workflow instructions, and add eval coverage for the remaining explicit-user-approval push rule.
- Updated `commit-discipline` to require `git commit -F <message-file>` or equivalent safe shell quoting for non-trivial commit messages instead of passing backtick-bearing bodies through double-quoted `git commit -m` arguments.
- Updated `roborev-kata-workflow` to state that sending repository-derived review content to Roborev's configured external AI provider is intended review behavior, and that DNS and network access to OpenAI, Anthropic, and Google domains is allowed when Roborev needs those providers for review.

## [2.2.0] - 2026-06-19

### Added

- `jira-priority` skill: classifies Jira issue priority from customer impact breadth and depth, with escalation rules for missing workarounds and critical business processes (payroll, safety compliance, billing, authentication).

## [2.1.6] - 2026-05-26

### Changed

- Tightened eval prompts that leaked expected review failures, clarified CI badge and required-check review guidance, made documentation-boundary surface reporting concise and explicit, and clarified change-friendly replacement guidance for overfit product-state types.

## [2.1.5] - 2026-05-25

### Changed

- Converted skill eval definitions from `evals/evals.json` to `evals/evals.yaml`, updated skill creation guidance to use the YAML eval format, ran focused CI skill validation one skill at a time, and tightened validation-facing guidance for documentation structure, changelog release checks, and process-global test isolation.

## [2.1.4] - 2026-05-25

### Changed

- Moved skill notes from `agents/notes.md` to `references/notes.md`, updated `skill-project` guidance to use the new location, and clarified `coding` so edits rewrite existing repeated-call multiline strings into one idiomatic multiline literal.
- Updated skill validation to run `skilpel` directly with its native gates, remove the legacy delta-checking helper, and document the new `scripts/skilpel.yaml` configuration.
- Kept skills CI focused on changed skill directories while validating shell script syntax separately, avoiding full repository skill evals for validation infrastructure edits.

## [2.1.3] - 2026-05-24

### Added

- Added `repo-policy`, a skill for GitHub repository policy configuration covering protected main, PR merge methods, CI gates, and tag-triggered artifact releases.

## [2.1.2] - 2026-05-24

### Changed

- Updated `kata` to keep task inventories, backlog lists, follow-ups, and remaining-work notes in Kata issues or comments instead of repository commits.

## [2.1.1] - 2026-05-24

### Changed

- Tightened `roborev-kata-workflow` so Kata issues stay open until relevant Roborev jobs are complete and green, fixed with a green follow-up, or explicitly deferred.

## [2.1.0] - 2026-05-24

### Added

- Added `ci`, a skill for GitHub Actions workflows and README CI badges for code and skills projects.

## [2.0.3] - 2026-05-24

### Changed

- Updated `coding` to require idiomatic multiline strings instead of composing them through consecutive function calls.

## [2.0.2] - 2026-05-22

### Added

- Added `changelog`, a skill for unreleased changelog entries, revert cleanup, SemVer classification, and release-time version finalization.
- Added changelog eval coverage rejecting diff-only changelog bodies.
- Added `kata`, a skill for Kata issue lifecycle hygiene with positive and negative eval cases.
- Added single-case skill eval validation through `scripts/validate_skills.sh --eval-id`.
- Added eval coverage for `change-friendly-architecture`, `docs-structure`, and `documentation-boundary`.
- Added OpenAI agent metadata for `kata`, `skill-project`, and `testing`.

### Changed

- Centralized changelog and version policy in `changelog`; ordinary implementation changes now update `[Unreleased]`, while release preparation finalizes `VERSION` and dated changelog sections.
- Required changelogs to remain human-readable standalone text files instead of replacing entries with version-control diffs or compare links.
- Updated `commit-discipline`, `roborev-kata-workflow`, `release`, and `create-skill` to delegate changelog policy to `changelog`.
- Updated `roborev-kata-workflow` to use concrete Kata commands instead of legacy Beads commands.
- Updated `roborev-kata-workflow` eval coverage to require `kata assign`, comments, relationships, and `kata close --done` guidance.
- Updated `create-skill` to require `agents/openai.yaml` metadata for new or changed skills.
- Updated `create-skill` eval guidance so assertions test behavior rather than exact phrasing, except when wording or formatting is the behavior under test.
- Expanded `change-friendly-architecture` guidance and eval coverage for change-amplifying types, schemas, broad units, ambient context, scattered workflows, repeated boilerplate, and test boundaries.
- Expanded `documentation-boundary` guidance and eval coverage for README manual sprawl, CLI help surfaces, changelog-only documentation claims, and docs-only maintenance.
- Tightened `testing` validation-scope reports so API contract changes include the exact `Concentric expansion:` path from direct contract tests to parent consumer tests.
- Tightened `testing` unchanged-behavior validation reports to state that behavior is intended to remain unchanged and that full repository suites are not required by default.

## [2.0.1] - 2026-05-21

### Changed

- Linked the README mention of `skill-validator` to its upstream repository.
- Linked the README mention of Codex to the Codex CLI documentation.

## [2.0.0] - 2026-05-21

### Changed

- Updated `create-skill` to reject eval-specific rule patches and require general skill behavior changes when evals fail.

### Removed

- Removed the monolithic `oiticica-style` skill; the replacement router now lives in the standalone `oiticica-style` skill project.

## [1.6.1] - 2026-05-21

### Changed

- Linked the README mention of `agent-skills-eval` to its upstream repository.

## [1.6.0] - 2026-05-18

### Changed

- Updated `coding` to forbid machine-specific filesystem paths in scripts, code, configuration, and documentation unless the user explicitly asks for the exact path.
- Added eval coverage for replacing machine-specific paths with repo-relative paths, source-relative paths, environment variables, or documented placeholders.

## [1.5.0] - 2026-05-15

### Added

- Added `skill-project`, a skill for scaffolding standalone skill-set repositories with shared validation, linking, eval, and agent metadata conventions.
- Added eval coverage for standalone skill-project setup, required repository `AGENTS.md` eval guidance, safe Claude linking, and required Skill CI behavior.

### Changed

- Updated `create-skill`, `skill-project`, and repository `AGENTS.md` to require skill-ablation eval design: with-skill runs should pass near 100%, without-skill runs should fail near 0%, and prompts should not teach the expected answer.
- Updated `scripts/link_skills.sh` so it no longer links hosted Codex instructions into `~/.claude/CLAUDE.md`; Claude receives skill directory links only.

## [1.4.2] - 2026-05-15

### Changed

- Required skill eval workflows to use the committed `scripts/agent-skills-eval.yaml` configuration with target and judge temperature set to `0`.
- Updated `create-skill` evals and validation documentation to preserve the deterministic eval configuration.

## [1.4.1] - 2026-05-13

### Changed

- Tightened `markdown` guidance for first software and organization links, file-list links, repeated prose file references, and literal file references inside fenced code blocks.
- Added `markdown` eval coverage for file lists, repeated same-paragraph file mentions, fenced file references, and first software or organization links.

## [1.4.0] - 2026-05-13

### Added

- Added `testing`, a focused skill for selecting deterministic validation by blast radius and reporting skipped broad checks.
- Added a public-domain README cover image with a linked source caption.

### Changed

- Updated `commit-discipline`, `release`, `roborev-beads-workflow`, and `web-realtime-devloop` to delegate validation scope to the focused `testing` skill.
- Updated `commit-discipline` to format command literals with backticks while leaving proper names unformatted.

## [1.3.0] - 2026-05-12

### Added

- Added `beads`, a focused skill for claiming Beads work, recording lifecycle notes, and closing completed Beads with validation evidence.

### Changed

- Moved repository skills under `src/` and updated validation, CI scope detection, linking, and README references for the new layout.
- Tightened `beads`, `roborev-beads-workflow`, and `shell-script` instructions so full validation remains deterministic after the layout move.
- Tightened `release` CI-gate wording so tag-only releases do not wait for nonexistent post-merge workflows.
- Added the verified upstream link for Beads in the Beads skill.
- Added verified upstream links for RoboRev and Beads in the RoboRev workflow skill.
- Added root `AGENTS.md` guidance requiring every repository skill to be linked from `README.md`.
- Updated `create-skill` to require root `README.md` skill links and focused validation before committing.
- Updated `decompose-skill` to require root `README.md` skill links and focused validation before committing.
- Updated `roborev-beads-workflow` to delegate Beads lifecycle commands to the focused `beads` skill.

## [1.2.0] - 2026-05-12

### Added

- Added `devloop`, a skill that discovers [`devloop`](https://github.com/pasunboneleve/devloop) usage from the tool's built-in guidance and validates watched workflows, managed processes, probes, and events with observable evidence.
- Added `devloop` evals for built-in documentation discovery, rejecting hard-coded docs-first plans, and deterministic runtime validation.

### Changed

- Clarified `release` so protected green PR checks can satisfy the release CI gate when a repository has no separate post-merge `main` workflow.

## [1.1.1] - 2026-05-12

### Changed

- Added a committed `agent-skills-eval` configuration with target and judge temperature set to 0.
- Tightened eval-backed `coding`, `oiticica-style`, and `web-realtime-devloop` behavior so full model-backed validation passes consistently.

## [1.1.0] - 2026-05-11

### Added

- Added `coding`, `markdown`, `create-skill`, `decompose-skill`, and `shell-script` skills with agent metadata.
- Added model-backed eval suites for `coding`, `create-skill`, `markdown`, `oiticica-style`, `shell-script`, and `web-realtime-devloop`.
- Added `agent-skills-eval` discovery files for existing eval fixtures and wired the validation wrapper to run model-backed skill evals when credentials are configured.

### Changed

- Renamed the hosted Codex home directory from `codex-home` to `home`.
- Made validation fail visibly when `agent-skills-eval` fails, while accepting skill eval suites that meet the configured 90% pass-rate and delta gates.
- Tightened `oiticica-style` and `web-realtime-devloop` instructions for their eval-backed behavior.

### Removed

- Removed `strunk-white-style` from the active skill set because its compression-oriented edits can drop useful source information.

## [1.0.1] - 2026-05-11

### Fixed

- Quoted the `oiticica-style` skill description so its frontmatter parses as valid YAML.
- Replaced custom Python frontmatter parsing with `skill-validator` for skill package validation in CI.

## [1.0.0] - 2026-05-09

### Changed

- Renamed `strunk-white-editor` to `strunk-white-style` to match style-manual skill naming.

## [0.3.1] - 2026-05-09

### Changed

- Added an Oiticica inventory test so lists must state each entry's capability, not only its status.
- Restored the `strunk-white-editor` README entry's functional description while keeping its standalone status explicit.

## [0.3.0] - 2026-05-09

### Added

- Added `oiticica-style`, a skill for reviewing prose and code through concrete contrast, diagnosis, correction, and explanation.
- Added `docs-structure`, a skill for keeping README files concise while moving durable documentation into focused `docs/` files.
- Added a repository-hosted Codex-home `AGENTS.md` template and linked it through `scripts/link_skills.sh`.

### Changed

- Made `oiticica-style` the standing writing and documentation skill in the hosted Codex-home `AGENTS.md`.
- Removed `strunk-white-editor` from active documentation guidance while keeping the legacy skill in the repository.
- Tightened Markdown examples and eval rubrics for stronger obligations and correct code contrasts.

## [0.2.2] - 2026-05-08

### Changed

- Strengthened `web-realtime-devloop` guidance for realtime rendering architecture, bounded projections, paced rendering, keyed SVG/DOM updates, and performance diagnosis.

### Added

- Added `web-realtime-devloop` eval fixtures for reviewing realtime browser rendering architecture.

## [0.2.1] - 2026-05-08

### Changed

- Expanded and tightened `web-realtime-devloop` guidance for session handling, rendered-page inspection, realtime state, validation, CSS, and frontend architecture boundaries.
- Clarified `release` workflow handling for tag-only projects without tag-triggered artifact automation.

## [0.2.0] - 2026-05-08

### Added

- Added `web-realtime-devloop`, a skill for live browser development loops in realtime and visual web work.
- Added OpenAI agent metadata for `web-realtime-devloop`.

## [0.1.0] - 2026-05-05

### Added

- Added the initial repository-local Codex skills:
  - `change-friendly-architecture`
  - `commit-discipline`
  - `documentation-boundary`
  - `release`
  - `roborev-beads-workflow`
  - `strunk-white-editor`
- Added skill validation and CI.
- Added a script to link repository skills into `~/.codex/skills`.
- Added the README and GPL-3.0-or-later license.

[Unreleased]: https://github.com/pasunboneleve/skills/compare/v2.2.2...HEAD
[2.2.2]: https://github.com/pasunboneleve/skills/compare/v2.2.1...v2.2.2
[2.2.1]: https://github.com/pasunboneleve/skills/compare/v2.2.0...v2.2.1
[2.2.0]: https://github.com/pasunboneleve/skills/compare/v2.1.6...v2.2.0
[2.1.6]: https://github.com/pasunboneleve/skills/compare/v2.1.5...v2.1.6
[2.1.5]: https://github.com/pasunboneleve/skills/compare/v2.1.4...v2.1.5
[2.1.4]: https://github.com/pasunboneleve/skills/compare/v2.1.3...v2.1.4
[2.1.3]: https://github.com/pasunboneleve/skills/compare/v2.1.2...v2.1.3
[2.1.2]: https://github.com/pasunboneleve/skills/compare/v2.1.1...v2.1.2
[2.1.1]: https://github.com/pasunboneleve/skills/compare/v2.1.0...v2.1.1
[2.1.0]: https://github.com/pasunboneleve/skills/compare/v2.0.3...v2.1.0
[2.0.3]: https://github.com/pasunboneleve/skills/compare/v2.0.2...v2.0.3
[2.0.2]: https://github.com/pasunboneleve/skills/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/pasunboneleve/skills/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/pasunboneleve/skills/compare/v1.6.1...v2.0.0
[1.6.1]: https://github.com/pasunboneleve/skills/compare/v1.6.0...v1.6.1
[1.6.0]: https://github.com/pasunboneleve/skills/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/pasunboneleve/skills/compare/v1.4.2...v1.5.0
[1.4.2]: https://github.com/pasunboneleve/skills/compare/v1.4.1...v1.4.2
[1.4.1]: https://github.com/pasunboneleve/skills/compare/v1.4.0...v1.4.1
[1.4.0]: https://github.com/pasunboneleve/skills/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/pasunboneleve/skills/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/pasunboneleve/skills/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/pasunboneleve/skills/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/pasunboneleve/skills/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/pasunboneleve/skills/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/pasunboneleve/skills/compare/v0.3.1...v1.0.0
[0.3.1]: https://github.com/pasunboneleve/skills/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/pasunboneleve/skills/compare/v0.2.2...v0.3.0
[0.2.2]: https://github.com/pasunboneleve/skills/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/pasunboneleve/skills/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/pasunboneleve/skills/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/pasunboneleve/skills/releases/tag/v0.1.0
