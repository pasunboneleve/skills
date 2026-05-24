---
name: repo-policy
description: Configure GitHub repository policy for protected main, PR merge methods, CI-required merges, and tag-triggered artifact releases.
---

# Repo Policy

Use this skill when creating a new GitHub repository, configuring remote repository settings, branch protection, rulesets, pull request merge methods, required status checks, or release artifact workflows.

## Main Protection

- Configure `main` so direct pushes are blocked.
- Require changes to reach `main` through pull requests.
- The only direct-push-to-`main` exception is the initial push while creating a fresh new repository before remote policy can exist.
- When configuring an existing repository, explicitly state that the fresh-repository initial push is the only direct-push exception.
- After the fresh repository exists on GitHub, configure protection immediately so `main` rejects direct pushes.

## Pull Request Policy

- Disable squash merging in repository merge settings.
- Enable a non-squash merge strategy, such as merge commits, unless the repository explicitly requires another non-squash strategy.
- For repositories with CI, configure branch protection or rulesets so pull requests cannot merge until required CI checks pass.
- Make required CI checks explicit and stable so pending, failing, missing, or ambiguous CI blocks the merge.

## Artifact Releases

- If a repository builds release artifacts, configure artifact builds to trigger from version tags.
- Use version tags that match the repository convention, such as `vMAJOR.MINOR.PATCH` when no other convention exists.
- Do not configure ordinary branch pushes or pull request merges to publish release artifacts.
- For artifact releases, require tag-triggered workflows to pass before the release is considered complete.
