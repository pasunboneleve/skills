# Changelog

All notable changes to this repository are documented in this file.

This project uses SemVer. Version tags use the `vMAJOR.MINOR.PATCH` format.

## [Unreleased]

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

[Unreleased]: https://github.com/pasunboneleve/skills/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/pasunboneleve/skills/compare/v0.3.1...v1.0.0
[0.3.1]: https://github.com/pasunboneleve/skills/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/pasunboneleve/skills/compare/v0.2.2...v0.3.0
[0.2.2]: https://github.com/pasunboneleve/skills/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/pasunboneleve/skills/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/pasunboneleve/skills/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/pasunboneleve/skills/releases/tag/v0.1.0
