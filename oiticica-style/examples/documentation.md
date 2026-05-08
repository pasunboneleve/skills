# Documentation examples

## Setup without locality

Spine:
The instruction tries to get a developer from clone to running app.

Main faults:
- Distance: prerequisites, commands, service, and success condition are not local.

Representative contrast:

Checked via:
Not run

Weak:

> Start the app after installing the dependencies and configuring the required services.

Fault:

`dependencies` and `required services` are names without contents. The instruction sends the reader hunting.

Better:

> Install Node 22 and PostgreSQL 16. Run `bun install`, then `docker compose up db`, then `bun run dev`. The app listens on `http://localhost:5173`.

Why:

The revised version keeps prerequisites, commands, service, and result in one path.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 2/5
- clarity: 2/5
- concision: 3/5
- force: 2/5
- harmony: 2/5
- originality: 3/5
- locality: 1/5

Final version:
Install Node 22 and PostgreSQL 16. Run `bun install`, then `docker compose up db`, then `bun run dev`. The app listens on `http://localhost:5173`.

## Troubleshooting without mechanism

Spine:
The note tries to guide a login investigation.

Main faults:
- Obscurity: the symptom is unnamed.
- Distance: the invariant is not placed near the files or values to inspect.

Representative contrast:

Checked via:
Not run

Weak:

> If login is broken, check the auth setup.

Fault:

`broken` and `auth setup` name no observable symptom, file, log, or boundary.

Better:

> If login returns `401` after redirect, inspect `AUTH_CALLBACK_URL` and the IdP redirect URI. They must match exactly, including scheme and port.

Why:

The revision gives a symptom, two places to inspect, and the invariant that decides success.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 3/5
- clarity: 1/5
- concision: 3/5
- force: 2/5
- harmony: 2/5
- originality: 2/5
- locality: 1/5

Final version:
If login returns `401` after redirect, inspect `AUTH_CALLBACK_URL` and the IdP redirect URI. They must match exactly, including scheme and port.

## Prompt with decorative abstraction

Spine:
The prompt tries to request revision.

Main faults:
- Banality: it asks for taste instead of a mechanism.

Representative contrast:

Checked via:
Not run

Weak:

> Improve this response so it is clearer, stronger, and more polished.

Fault:

The prompt asks for taste. It does not define what failure to find.

Better:

> Identify one sentence where the subject, action, or consequence is hidden. Rewrite it once. Explain which relation became visible.

Why:

The prompt forces a contrast and a mechanism.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 3/5
- clarity: 2/5
- concision: 3/5
- force: 2/5
- harmony: 3/5
- originality: 1/5
- locality: 2/5

Final version:
Identify one sentence where the subject, action, or consequence is hidden. Rewrite it once. Explain which relation became visible.
