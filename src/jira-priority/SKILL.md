---
name: jira-priority
description: Use when classifying the priority of a Jira issue or creating a Jira issue with the correct priority assigned.
---

Classify the priority of a Jira issue using the scheme below. When asked to create the issue, use the Jira tool with the classified priority.

## Priority scheme

"Customer" means one tenant or organisation, not one individual user within it. "Blocked on all their work" means the customer cannot use any feature of the platform. "Blocked on part of their work" means one or more features are broken while others still work. Base priority is based on the broken functionality's scope — a customer is blocked on part of their work when a feature they use is broken, regardless of whether a workaround exists. Workarounds affect only the escalation rules, not the base classification. Each escalation rule raises the priority by exactly one level.

When assessing scope, consider what the customer's users can currently do — not what a workaround or technical intervention could restore. If every feature of the platform is inaccessible to the customer's users, they are blocked on all their work, even if a support action or admin procedure could fix it.

| Priority | Condition |
|---|---|
| Lowest | Cosmetic defect — orthography or screen positioning — that does not prevent use |
| Low | One customer blocked on part of their work |
| Medium | One customer blocked on all their work, OR many customers blocked on part of their work |
| High | Many customers blocked on all their work, but not a complete outage |
| Highest | Complete outage — no customer can do any work — OR a data or secret leak |

## Escalation rules

After setting the base priority, apply each rule independently. Each satisfied rule raises the priority one level. Rules only raise; they never lower the base. Cap at Highest. When the base priority is already Highest, escalation rules do not change the result.

1. **No workaround**: No known workaround exists for the blocked work.
2. **Critical business process**: The blocked work is payroll (including payroll export), safety compliance (including safety checklists and forms), billing or invoicing (including invoice generation and payment processing), or authentication (including login and password reset).

## Output format

Always respond in this exact order:

1. **Base priority**: [level] — [which condition from the table it satisfies]
2. **Escalation**:
   - No workaround: [Satisfied / Not satisfied] — [reason] → [raises to level / no change]
   - Critical process: [Satisfied / Not satisfied] — [reason] → [raises to level / no change]
3. **Final priority**: [level]
