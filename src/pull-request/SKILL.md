---
name: pull-request
description: Use when working on GitHub pull requests that need PR-ready validation, review-thread replies, reviewer mentions, linked external references, or merge readiness checks.
---

# Pull Request Workflow

Use this skill for GitHub pull request work that is not specifically a release.
Use `$release` for release PRs and `$repo-policy` for repository protection settings.

## PR Readiness

- Do not push, open, update, or merge a PR unless the user explicitly asks.
- Do not merge a PR unless required CI is green.
- Run the validation selected by `$testing` before claiming a PR is ready.
- Summarize the validation command and result in the PR body or update when creating or materially updating a PR.

## Review Comments

When addressing GitHub PR review comments:

- Reply in the specific review thread for each addressed comment.
- Address the commenter by GitHub handle, such as `@octocat`, in the thread reply.
- Resolve the thread only after the fix or explicit deferral is recorded in that same thread.
- Do not replace per-thread replies with a single top-level PR comment or summary.
- If using `gh` to reply to a review thread, use `gh api graphql` with the review thread or review comment node ID. State explicitly that this is an in-thread reply, not a top-level PR comment.
- Do not use `gh pr comment`, `gh pr review --comment`, or REST endpoints for an in-thread review reply.
- When describing a `gh` thread-reply command, include the explicit warning that `gh pr comment` creates a top-level PR comment and must not be used for the thread reply.

## External References

- Turn external references into links when they are available or web-searchable.
- Use full links for Jira issues instead of bare issue keys when the Jira base URL is known or can be inferred from context.
- Link web-searchable libraries, tools, standards, or docs to an authoritative page, such as official documentation, package indexes, or project repositories.
- Do not leave a bare external name when a practical authoritative link can be supplied.

## Closeout

Before reporting PR work complete, state:

- PR URL or number when one exists.
- Commit or branch state.
- Validation run and result.
- CI state when relevant.
- Review-thread replies and resolutions performed, including any deferred threads.
