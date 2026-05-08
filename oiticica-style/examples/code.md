# Code examples

## Function name hides the effect

Spine:
The function mutates draft invoices for one user.

Main faults:
- Obscurity: the name hides the mutation.
- Prolixity: the function accepts a whole `User` while using only `id`.

Representative contrast:

Checked via:
Not run

Weak:

```ts
async function handle(user: User) {
  await db.invoice.updateMany({
    where: { userId: user.id, status: "draft" },
    data: { status: "void" },
  });
}
```

Fault:

`handle` hides the effect. A caller cannot predict that drafts are voided.

Better:

```ts
async function voidDraftInvoicesForUser(userId: string) {
  await db.invoice.updateMany({
    where: { userId, status: "draft" },
    data: { status: "void" },
  });
}
```

Why:

The name now carries the object, scope, and mutation. The parameter narrows the function to the data it needs.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 4/5
- clarity: 2/5
- concision: 3/5
- force: 2/5
- harmony: 3/5
- originality: 2/5
- locality: 3/5

Final version:

```ts
async function voidDraftInvoicesForUser(userId: string) {
  await db.invoice.updateMany({
    where: { userId, status: "draft" },
    data: { status: "void" },
  });
}
```

## Hidden dependency

Spine:
The function calculates a total with tax.

Main faults:
- Distance: `TAX_RATE` controls behavior from outside the call.

Representative contrast:

Checked via:
Not run

Weak:

```ts
export function priceTotal(items: Item[]) {
  return items.reduce((sum, item) => sum + item.price * TAX_RATE, 0);
}
```

Fault:

`TAX_RATE` is a distant dependency. Tests must know ambient state instead of the function contract.

Better:

```ts
export function priceTotal(items: Item[], taxRate: number) {
  return items.reduce((sum, item) => sum + item.price * taxRate, 0);
}
```

Why:

The dependency is local to the call. Tests can vary tax behavior without patching module state.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 3/5
- clarity: 3/5
- concision: 4/5
- force: 3/5
- harmony: 3/5
- originality: 3/5
- locality: 2/5

Final version:

```ts
export function priceTotal(items: Item[], taxRate: number) {
  return items.reduce((sum, item) => sum + item.price * taxRate, 0);
}
```

## Distant invariant

Spine:
The code decides whether a refund may run.

Main faults:
- Distance: the refund invariant is set in another file.
- Obscurity: the mutation site does not show the policy input.

Representative contrast:

Checked via:
Not run

Weak:

```ts
// config.ts
export let allowRefunds = false;

export function initRuntime(env: Env) {
  allowRefunds = env.region !== "BR";
}

// refunds.ts
export function refund(order: Order) {
  if (!allowRefunds) return { status: "blocked" };
  return gateway.refund(order.paymentId);
}
```

Fault:

The refund invariant lives in `initRuntime`, but the mutation happens in `refund`. A reviewer must read two files to know when refunds are legal.

Better:

```ts
export function refund(order: Order, policy: RefundPolicy) {
  if (!policy.allowRefundsFor(order.region)) return { status: "blocked" };
  return gateway.refund(order.paymentId);
}
```

Why:

The policy dependency is local to the mutation. Tests can state the regional invariant at the call boundary.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 3/5
- clarity: 2/5
- concision: 3/5
- force: 3/5
- harmony: 2/5
- originality: 3/5
- locality: 1/5

Final version:

```ts
export function refund(order: Order, policy: RefundPolicy) {
  if (!policy.allowRefundsFor(order.region)) return { status: "blocked" };
  return gateway.refund(order.paymentId);
}
```

## Test names the implementation

Spine:
The test tries to prove email normalization.

Main faults:
- Impurity: it asserts helper usage instead of observable behavior.

Representative contrast:

Checked via:
Not run

Weak:

```ts
it("calls normalizeEmail", () => {
  saveUser({ email: " A@EXAMPLE.COM " });
  expect(normalizeEmail).toHaveBeenCalled();
});
```

Fault:

The test asserts a helper call, not the behavior the user relies on.

Better:

```ts
it("stores email in lowercase without surrounding spaces", () => {
  saveUser({ email: " A@EXAMPLE.COM " });
  expect(savedUser.email).toBe("a@example.com");
});
```

Why:

The assertion moves from implementation to observable contract.

Faults not resolved in this contrast:
None

Rubric:
- correctness: 2/5
- clarity: 3/5
- concision: 3/5
- force: 2/5
- harmony: 3/5
- originality: 3/5
- locality: 2/5

Final version:

```ts
it("stores email in lowercase without surrounding spaces", () => {
  saveUser({ email: " A@EXAMPLE.COM " });
  expect(savedUser.email).toBe("a@example.com");
});
```
