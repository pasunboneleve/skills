# Contributing

This repository packages shared coding-agent skills under `src/`.

## Repository shape

Each skill must include:

- `src/<skill-name>/SKILL.md`
- `src/<skill-name>/agents/openai.yaml`
- `src/<skill-name>/evals/evals.yaml`

Every skill must be linked from the root `README.md`.

Add `src/<skill-name>/references/notes.md` when a skill needs supporting source
notes or reference material.

## Skill rules

- Keep `SKILL.md` concise and operational.
- Put behavior in `SKILL.md`, not in the eval prompt.
- Include positive and negative eval cases for behavior-changing skills.
- Design evals as skill-ablation tests: with-skill runs should pass near 100%, and without-skill runs should fail near 0%.
- Use assertions that test behavior rather than exact wording unless wording is the behavior under test.

## Validation

`scripts/validate_skills.sh` is the main local validation wrapper. It installs
[`skill-validator`](https://github.com/agent-ecosystem/skill-validator) into
`~/.local/bin` when needed, which requires [Go](https://go.dev/). It also uses
the verified [`skilpel`](https://github.com/pasunboneleve/skilpel) release
binary at `~/.local/bin/skilpel` for model-backed evals.

Use focused validation for changed skills:

```bash
direnv exec . bash scripts/validate_skills.sh change-friendly-architecture
```

Run full validation only when shared scripts, CI, or cross-cutting skill infrastructure changes.

For script changes, also run:

```bash
bash -n scripts/*.sh
```

To iterate on one eval case, pass a skill relpath and eval id:

```bash
bash scripts/validate_skills.sh --eval-id reject-overfit-domain-type change-friendly-architecture
```

For local model-backed evals, put `OPENAI_API_KEY` in `.env`. The committed
`.envrc` loads `.env` into the shell with direnv; `.env` is ignored by Git.
