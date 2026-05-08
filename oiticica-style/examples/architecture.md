# Architecture examples

## Boundary without ownership

Spine:
The note tries to define responsibilities in a sync design.

Main faults:
- Banality: `coordinates` hides ownership.
- Distance: retry, validation, persistence, and delivery are not assigned to boundaries.

Representative contrast:

Checked via:
Not run

Weak:

> The sync layer coordinates data between the API, queue, and database.

Fault:

`coordinates` hides ownership. The sentence does not say which component validates, persists, retries, or emits.

Better:

> `SyncWorker` owns retries and idempotency for inbound account events. The API validates shape and enqueues events. The database owns processed-event IDs. The queue owns delivery attempts, not business state.

Why:

Each boundary owns one obligation. A future change can locate retry policy without reading every participant.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 3/5
- clarity: 2/5
- concision: 3/5
- force: 2/5
- harmony: 3/5
- originality: 2/5
- locality: 1/5

Final version:
`SyncWorker` owns retries and idempotency for inbound account events. The API validates shape and enqueues events. The database owns processed-event IDs. The queue owns delivery attempts, not business state.

## Overloaded module

Spine:
The note tries to define a billing boundary.

Main faults:
- Prolixity: one service owns unrelated reasons to change.
- Disharmony: pure calculation, side effects, retry policy, and reporting are interleaved.

Representative contrast:

Checked via:
Not run

Weak:

> `BillingService` calculates invoices, sends receipts, retries failed payments, and reports revenue metrics.

Fault:

The unit mixes pure calculation, external side effects, retry policy, and analytics. Tests and failures will cross unrelated concerns.

Better:

> `InvoiceCalculator` computes line items. `PaymentRetryPolicy` decides the next attempt. `ReceiptMailer` sends receipts after payment success. `RevenueReporter` consumes invoice-paid events.

Why:

State changes move through named boundaries. Each unit can be tested at the narrowest useful surface.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 3/5
- clarity: 2/5
- concision: 2/5
- force: 2/5
- harmony: 1/5
- originality: 2/5
- locality: 1/5

Final version:
`InvoiceCalculator` computes line items. `PaymentRetryPolicy` decides the next attempt. `ReceiptMailer` sends receipts after payment success. `RevenueReporter` consumes invoice-paid events.

## Decision without consequence

Spine:
The decision tries to justify Redis.

Main faults:
- Banality: `fast and widely used` is a product slogan.
- Obscurity: the source of truth and failure mode are missing.

Representative contrast:

Checked via:
Not run

Weak:

> We will use Redis because it is fast and widely used.

Fault:

The decision gives a product slogan, not the relation that must stay true.

Better:

> We will use Redis only for expiring session lookups. PostgreSQL remains the source of truth. Losing Redis logs users out but does not lose account data.

Why:

The decision names scope, source of truth, and failure mode.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 2/5
- clarity: 2/5
- concision: 3/5
- force: 2/5
- harmony: 3/5
- originality: 1/5
- locality: 2/5

Final version:
We will use Redis only for expiring session lookups. PostgreSQL remains the source of truth. Losing Redis logs users out but does not lose account data.
