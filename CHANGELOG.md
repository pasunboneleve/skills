# Changelog

All notable changes to this repository are documented in this file.

This project uses SemVer. Version tags use the `vMAJOR.MINOR.PATCH` format.

## [Unreleased]

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

[Unreleased]: https://github.com/pasunboneleve/skills/compare/v1.4.2...HEAD
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
