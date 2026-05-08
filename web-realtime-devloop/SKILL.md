---
name: web-realtime-devloop
description: Use this skill for browser-based, realtime, visual, frontend, WebSocket, Hono, Vite, Bun, Cloudflare-style, or local web application work. It enforces long-lived dev sessions, live browser inspection, layout validation, and deterministic checks.
---

# Web realtime devloop

Use this skill for browser-based realtime apps, visual UIs, WebSocket apps, Cloudflare-style Workers, Hono servers, Vite frontends, Bun workspaces, dashboards, observability views, Canvas/SVG/D3 work, and any task where visual behaviour matters.

Keep the app running, inspect the live result, and iterate from observed behaviour.

Do not rely only on static code inspection, typechecking, or successful builds for frontend work.

## Core workflow

Start a long-lived development session before judging UI behaviour.

Prefer:

```bash
bun run dev
```

Use the project command when it differs, such as `npm run dev`, `pnpm dev`, `vite`, `wrangler dev`, or a documented local server command.

Keep the session open while editing. Watch logs for compile errors, runtime errors, failed requests, and websocket disconnects.

## Browser inspection

Open the running app in a browser and inspect the actual rendered state.

Check:

- the requested workflow, not only the default route
- console errors and warnings
- failed network requests
- realtime connection state and reconnect behaviour
- desktop and mobile viewport layout
- canvas, SVG, chart, animation, or media rendering when present

Use screenshots or DOM inspection when layout, overlap, visibility, or visual state matters.

## Validation

Run the fastest relevant deterministic checks before finishing, such as formatting, linting, typechecking, unit tests, or targeted browser tests.

If a check cannot run, say why and report the live browser inspection you did instead.

## Final report

Report:

- dev server command and URL
- browser workflows inspected
- viewport sizes checked
- validation commands run
- remaining risks or checks not run
