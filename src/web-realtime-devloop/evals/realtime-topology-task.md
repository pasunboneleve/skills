# Realtime topology task

Use this fixture to evaluate whether an agent plans and implements realtime browser rendering with clear boundaries.

## Task

Build a live topology map fed by WebSocket events, with a token stream, tool events, retries, failures, and retrieval traces.

The UI must show:

- active, idle, stale, and failed nodes
- edges between agents, tools, retrieval sources, and model calls
- recent topology changes
- token stream excerpts
- tool calls and results
- retry and failure state
- retrieval traces
- usage and latency summaries

## Expected answer

The plan or implementation must use this flow:

```text
event stream
-> reducer/domain core
-> bounded projection
-> latest projection buffer
-> requestAnimationFrame render loop
-> keyed/persistent SVG/DOM updates
```

WebSocket handlers may parse and enqueue events or store the latest projection. They must not redraw the UI.

The renderer must:

- render at browser cadence, not event cadence
- coalesce many events or projections into one paint
- update keyed SVG nodes and edges instead of replacing the whole map
- keep token, log, retrieval, and recent-change panels bounded
- keep text panels in fixed regions with internal scrolling
- avoid unbounded projections over the wire and in rendered arrays

The mock stream must include:

- paced token events roughly every 40-100 ms
- paced tool or retrieval events roughly every 300-1200 ms
- lower-cadence usage and latency updates
- bursty mode for coalescing tests
- retry, failed-tool, retrieval-heavy, duplicate-event, and out-of-order scenarios

The validation plan must include:

- deterministic reducer/projection tests
- bounded-output tests
- rendered-page inspection under streaming load
- desktop, narrow/mobile, and zoom-equivalent checks
- performance counters or DevTools evidence if the UI feels stilted

The answer must reject plans that:

- render directly inside WebSocket `onmessage`
- rebuild the whole SVG or DOM on each event
- append unbounded token/log content into layout
- send or render unbounded projections
- treat poor UI performance as evidence that Rust/WASM is required before inspecting render cadence, projection bounds, and update strategy
- make the browser infer canonical domain state from presentation state
