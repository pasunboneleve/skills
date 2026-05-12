# Rendering architecture rubric

Use this rubric to evaluate plans or implementations for realtime browser UI, especially WebSocket/SSE, observability, topology maps, dashboards, SVG, Canvas, D3, Hono, Vite, Bun, or Cloudflare-style apps.

Score each item:

- 0 = absent, wrong, or contradicted
- 1 = partially present but weak or unenforced
- 2 = clearly present, enforced, and reflected in the implementation

Maximum score: 30

## 1. Long-lived dev loop

The implementation uses a persistent local dev session, such as `bun run dev`.

It does not repeatedly start and stop the dev server on every iteration.

Dev server logs are inspected during work.

Score: 0 / 1 / 2

## 2. Rendered-page inspection

The UI is inspected as a rendered page, not merely typechecked.

Acceptable inspection includes Chrome DevTools MCP, a user-started browser with remote debugging, `xvfb-run`, headless screenshots, DOM metrics, or equivalent rendered-page evidence.

Score: 0 / 1 / 2

## 3. Event/reducer/projection/renderer separation

The architecture separates:

```text
event stream
-> reducer/domain core
-> projection
-> renderer
```

Canonical state is not scattered through UI components.

The browser may own rendering geometry and local connection state, but not canonical domain state.

Score: 0 / 1 / 2

## 4. Message handlers do not render directly

WebSocket/SSE/message handlers do not directly redraw the UI.

They parse or store the latest projection, enqueue events, or update a small buffer.

Rendering is scheduled separately.

Score: 0 / 1 / 2

## 5. Rendering is paced

Rendering is paced with `requestAnimationFrame` or an equivalent scheduling strategy.

The app renders at browser cadence, not event cadence.

Multiple incoming events or projections can be coalesced into one paint.

Score: 0 / 1 / 2

## 6. SVG/DOM hot paths are persistent/keyed

Hot rendering paths avoid full DOM/SVG rebuilds.

The implementation uses persistent elements, keyed joins, stable node identity, or an equivalent update strategy.

It updates attributes, classes, and text rather than replacing whole containers on every event.

Score: 0 / 1 / 2

## 7. Projections are bounded

Rendered projection collections are bounded.

Examples:

- recent changes
- logs
- retrievals
- timeline points
- token excerpts
- error lists

Totals may grow, but rendered arrays must not grow without limit.

Score: 0 / 1 / 2

## 8. Text/log panels are bounded and layout-stable

Token streams, logs, tools, retrievals, and event panels have fixed logical regions.

They use internal scrolling or bounded excerpts.

Streaming text does not resize the page grid or cause layout jumps.

Score: 0 / 1 / 2

## 9. Mock stream pacing is realistic

The mock event generator avoids accidental burst-only behaviour.

Default demo streams feel continuous.

Burst mode may exist for stress testing, but the UI must coalesce and remain responsive.

Score: 0 / 1 / 2

## 10. Performance diagnosis order is followed

If the UI feels stilted or slow, the implementation investigates, roughly in this order:

1. render frequency
2. full DOM/SVG rebuilds
3. layout/reflow from growing panels
4. projection payload size
5. event burstiness
6. console/log spam
7. dev-mode overhead
8. reducer/runtime language performance

It does not prematurely blame TypeScript, Node, Bun, or the lack of WASM/Rust.

Score: 0 / 1 / 2

## 11. Performance counters exist when needed

When realtime behaviour is under investigation, the implementation provides lightweight dev-only counters or equivalent evidence for:

- events received/sec
- projections broadcast/sec
- render calls/sec
- average render duration
- max render duration
- projection payload size
- coalesced/dropped update count, if applicable

Score: 0 / 1 / 2

## 12. Deterministic reducer/projection tests

The implementation includes deterministic tests for reducer and projection behaviour.

Relevant tests may include:

- schema validation
- valid event parsing
- invalid event rejection
- duplicate event policy
- out-of-order event policy
- retry accounting
- failure accounting
- token/usage aggregation
- bounded output
- replay fixtures
- golden projection snapshots

Score: 0 / 1 / 2

## 13. Responsive layout and zoom validation

The rendered UI is checked at:

- desktop width
- narrow/mobile width
- zoom-equivalent states around 80%, 100%, 125%, and 150%

Acceptance requires:

- no overlapping text
- no unexpected horizontal overflow
- no hidden critical state
- scroll regions stay internal
- topology/visualisation remains readable

Score: 0 / 1 / 2

## 14. Visual readability over dashboard flash

The UI prioritises legibility and first-glance understanding.

It avoids unnecessary glow effects, gradient-heavy backgrounds, oversized bubbles, and dense labels unless explicitly required.

For observability views, the UI answers:

```text
Where is the system now?
What is active?
What recently changed?
What is stale?
What failed?
```

Score: 0 / 1 / 2

## 15. Completion evidence is explicit

The final report names:

- validation commands run
- rendered-page inspection method
- viewport/zoom checks performed
- any remaining uncertainty
- any performance measurements gathered if performance was relevant

Score: 0 / 1 / 2

## Scoring

- 24-30: acceptable
- 18-23: needs targeted fixes before merge
- below 18: reject and rework before implementation or merge

## Hard rejection conditions

Reject regardless of score if any of these are true:

- message handlers directly rebuild the UI on each event
- topology/log/token panels grow without bound
- the implementation claims visual completion without rendered-page inspection
- sluggish UI is used as justification to reintroduce Rust/WASM before inspecting render architecture
- canonical domain state is computed ad hoc inside frontend rendering code
