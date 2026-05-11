---
name: web-realtime-devloop
description: Use this skill for browser UI, realtime visualisation, and local web application work. It keeps the app running, inspects rendered behaviour, checks realtime flows, and validates deterministically.
---

# Web realtime devloop

Use this skill for browser UI, realtime visualisation, WebSocket apps, Cloudflare-style Workers, Hono servers, Vite frontends, Bun workspaces, dashboards, observability views, Canvas/SVG/D3 work, and any task where visual behaviour matters.

Keep the app running, inspect the rendered result, and iterate from observed behaviour. Do not rely on static code inspection, typechecking, or successful builds alone.

## Realtime topology answer contract

For realtime topology, observability, token-stream, WebSocket, SSE, SVG, Canvas, or D3 plans and reviews, do not start with a broad overview. Start with the relevant checklist below, then add implementation detail.

For plans, start with `Required realtime architecture` and include:

- Required flow: `event stream -> reducer/domain core -> bounded projection -> latest projection buffer -> requestAnimationFrame render loop -> keyed/persistent SVG/DOM updates`.
- WebSocket, SSE, and message handlers may parse, enqueue events, or store the latest projection; they must not redraw the UI directly.
- Render at browser cadence, not event cadence. Coalesce incoming events or projections into one paint.
- Bound token, log, retrieval, recent-change, error, timeline, and projection collections. Use fixed regions with internal scrolling for streaming text.
- Mock streams must include realistic pacing, burst mode, retries, failed-tool cases, retrieval-heavy cases, duplicate events, and out-of-order events.
- Validation must include deterministic reducer/projection tests and rendered-page inspection under streaming load.

For topology plans, include these exact checklist lines:

- `WebSocket handlers: may parse, enqueue, or store projections; must not redraw the UI directly.`
- `Rendering: browser-cadence rendering with coalesced updates.`
- `Bounds: token, log, retrieval, recent-change, error, timeline, and projection collections stay bounded.`
- `Mock streams: realistic pacing, burst mode, retries, failed-tool cases, retrieval-heavy cases, duplicate events, and out-of-order events.`
- `Tests: deterministic reducer/projection tests plus rendered-page inspection under streaming load.`

For reviews, start with `Required realtime rejections` and include:

- Reject rendering directly in WebSocket `onmessage`.
- Reject rebuilding the whole SVG or DOM on each event.
- Unbounded token/log content is a layout and performance fault.
- Reject claiming visual completion from typechecking alone.
- Require a reducer/domain core and bounded projection separate from rendering.
- Call for deterministic reducer/projection tests.

## Development session

Start one long-lived development session before judging browser behaviour.

Prefer the project command. If none is documented, try:

```bash
bun run dev
```

Use the existing command when it differs, such as `npm run dev`, `pnpm dev`, `vite`, `wrangler dev`, or a documented local server command.

Keep the session open while editing. Read its logs instead of restarting it. Watch for compile errors, runtime errors, failed requests, and websocket disconnects.

Restart only when one of these changes requires it:

- dependency installation
- package manager lockfile change
- bundler configuration change
- environment variable shape change
- startup code that cannot hot reload cleanly
- crashed process or unresolved port conflict

Do not run competing dev servers on the same port. If a port is occupied, identify the process and decide whether to reuse it, stop it, or change the configured port.

After each code change:

1. Let hot reload finish.
2. Read the dev server logs.
3. Inspect the live page.
4. Fix observed problems.
5. Run deterministic checks before claiming completion.

## Rendered-page inspection

For layout, animation, Canvas, SVG, responsive behaviour, and realtime streaming, inspect the rendered app.

Preferred inspection order:

1. Chrome DevTools MCP against the running app.
2. A user-started Chrome or Chromium instance with remote debugging enabled.
3. `xvfb-run` around the browser or MCP process when a headful browser needs an X display.
4. Headless Chromium screenshots and DOM metrics.

If DevTools MCP reports `Missing X server to start the headful browser`, use `xvfb-run -a <browser-or-mcp-command>` or a headless Chromium screenshot path. Do not give up on visual validation.

Do not call the UI visually validated unless the page was inspected through DevTools, screenshots, DOM metrics, or an equivalent rendered-page check.

Check:

- the requested workflow, not only the default route
- console errors and warnings
- failed network requests
- realtime connection state and reconnect behaviour
- desktop and mobile viewport layout
- zoom-equivalent behaviour around 80%, 100%, 125%, and 150%
- loading, connected, reconnecting, error, content-heavy, and empty states where applicable
- canvas, SVG, chart, animation, or media rendering when present

For realtime panels, verify that arriving events do not cause layout jumps, unbounded growth, hidden horizontal overflow, clipped labels, overlapping text, or unreadable animation. Keep scroll regions internal and important state visible.

Rendered collections must be bounded. Totals may grow, but arrays rendered as logs, recent changes, timelines, retrievals, token excerpts, error lists, or tool traces must not grow without limit. Streaming text must stay inside fixed logical regions with internal scrolling; it must not resize the page grid.

For topology or observability UIs, make active, idle, stale, and failed states distinct. The first-glance answer should be clear: where the system is now, what is active, what changed recently, what is stale, and what failed.

## Realtime rendering architecture

For realtime observability apps, this flow is required:

```text
event stream
-> reducer/domain core
-> bounded projection
-> latest projection buffer
-> requestAnimationFrame render loop
-> keyed/persistent SVG/DOM updates
```

WebSocket, SSE, and message handlers may parse, enqueue events, or store the latest projection. They must not render.

Render at browser cadence, not event cadence. Use `requestAnimationFrame` or an equivalent scheduler. Coalesce many events or projections into one paint.

Use this pattern for projection-driven streams:

```ts
let latestProjection: Projection | null = null;
let renderScheduled = false;

socket.onmessage = (message) => {
  latestProjection = parseProjection(message.data);

  if (!renderScheduled) {
    renderScheduled = true;
    requestAnimationFrame(() => {
      renderScheduled = false;
      if (latestProjection) render(latestProjection);
    });
  }
};
```

For event-driven streams, handlers may enqueue validated events. The reducer/core should then produce a bounded projection before rendering.

Keep canonical state out of ad hoc UI components. The browser may own rendering geometry, connection state, hover/focus/selection state, and transient presentation state.

The browser must not become the canonical source of truth for agent phase, topology status, retry or failure accounting, token or usage totals, derived metrics, or event ordering policy.

Put canonical state in a tested core package or reducer module.

## SVG and DOM update discipline

Keep SVG and DOM hot paths persistent and keyed.

Prefer:

- persistent SVG/DOM elements
- keyed joins for nodes, edges, rows, panels, and list items
- attribute, class, and text updates instead of replacing whole containers
- separate create, update, and remove paths
- render-duration measurements when performance is in question

Avoid `innerHTML = ""`, `replaceChildren`, or full redraws in hot paths unless the collection is tiny and intentionally bounded.

For D3/SVG, use keyed joins:

```ts
selection
  .data(nodes, (node) => node.id)
  .join(
    (enter) => enter.append("g"),
    (update) => update,
    (exit) => exit.remove(),
  );
```

For WebSocket or streaming features, validate:

- first connection
- reconnect
- server restart behaviour
- malformed event handling
- slow, bursty, and empty streams
- error frames or failure events
- browser refresh while the stream is active

Prefer a deterministic mock event generator with normal, token-heavy, retry, failed-tool, retrieval-heavy, duplicate-event, and out-of-order scenarios.

Mock streams must support paced and bursty modes. Default demos should feel continuous: token events roughly every 40-100 ms, tool or retrieval events roughly every 300-1200 ms, and usage or latency updates at lower cadence. Use burst mode to verify render coalescing.

## Performance diagnosis

When realtime UI feels slow or stilted, investigate in this order before changing languages or runtimes:

1. render frequency
2. full DOM/SVG rebuilds
3. layout or reflow from growing panels
4. projection payload size
5. event burstiness
6. console or log spam
7. dev-mode overhead
8. reducer or runtime language performance

Do not treat sluggish realtime UI as proof that WASM/Rust is required until the rendering loop, projection bounds, and DOM/SVG update strategy have been inspected.

When performance is in question, add lightweight dev-only counters or equivalent evidence for:

- events received/sec
- projections broadcast/sec
- render calls/sec
- average render duration
- max render duration
- projection payload size
- dropped or coalesced update count, if applicable

## TypeScript and tests

Use strict TypeScript. Prefer explicit schemas at external and event boundaries with `zod`, `valibot`, or an equivalent validator already present in the repo.

For event-driven systems, test:

- valid event parsing
- invalid event rejection
- reducer transitions
- duplicate event policy
- out-of-order event policy
- retry and failure accounting
- bounded log or recent-change output
- projection snapshots from replay fixtures

Do not use framework state as a substitute for a tested reducer.

## Styling and platform constraints

Prefer quiet, readable interfaces over flashy dashboards.

Use CSS variables, relative units, `min()`, `max()`, `clamp()`, Grid, Flexbox, `minmax()`, `auto-fit`, `aspect-ratio`, SVG `viewBox`, and bounded scroll regions where they fit the problem.

For Vite-based frontend work, prefer the current stable Tailwind CSS major when styling speed and responsive layout matter. If the repo already uses Tailwind, follow its installed version and configuration.

For new projects, install the latest stable Tailwind release through the project package manager and document any version choice. Use Tailwind for layout, spacing, typography, status badges, panels, tables, and scroll regions.

Let Tailwind rebuild through the active frontend toolchain, such as Vite. Do not start a separate Tailwind watcher unless the repo documents that workflow.

Do not encode canonical domain state in class strings. Classes should reflect projection state, not compute it.

For SVG/D3 visualisations, use Tailwind around the chart and semantic classes or CSS variables inside it. Do not turn complex geometry into unreadable utility-class chains.

If repeated Tailwind strings become hard to maintain, extract small rendering helpers or semantic CSS classes.

Avoid fixed pixel-heavy layouts, custom app zoom, wheel interception, unbounded logs that change layout, glow effects unless requested, dense labels without hierarchy, and animation that reduces readability.

For Cloudflare Workers or Pages targets, prefer Fetch-style request handling, Web-standard APIs, Hono or similarly portable routing, explicit environment bindings, and no Node-only assumptions in deployable code. Isolate Bun or Node APIs from Worker-bound code.

## Validation

Run the fastest relevant deterministic checks while iterating, then run the repo's full local validation path before finishing.

Prefer local commands such as:

```bash
bun run typecheck
bun run test
bun run build
bun run check
```

Use `bun run check` as the repo's deterministic validation command when present.

Use both deterministic checks and rendered-page inspection before claiming completion.

## Completion checklist

Do not mark realtime web work complete unless:

- rendering is paced through `requestAnimationFrame` or an equivalent scheduler
- WebSocket, SSE, and message handlers do not directly redraw the UI
- SVG/DOM hot paths use keyed or persistent updates
- rendered collections are bounded
- token and log panels do not cause layout jumps
- the live app was inspected under streaming load
- desktop, mobile, and zoom-equivalent checks pass
- performance counters or DevTools evidence were used if the UI felt stilted
- deterministic validation passed

## Final report

Report:

- dev server command and URL
- log errors inspected
- rendered workflows inspected
- desktop, narrow, and zoom-equivalent checks
- realtime, error, and reconnect states checked where applicable
- render scheduling strategy
- projection and rendered collection bounds
- SVG/DOM update strategy
- performance counters or DevTools evidence when performance was relevant
- validation commands run
- remaining risks or checks not run
- unexplained dev server, browser, generated artifact, or lockfile side effects
