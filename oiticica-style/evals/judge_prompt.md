# Judge prompt

Review the answer against the Oiticica-style skill.

Pass only if the answer:

- gives a spine;
- names concrete mechanisms of failure;
- includes at least one Weak/Fault/Better/Why contrast;
- includes Main faults and Rubric in structural reviews;
- uses Strong/Mechanism/Why rather than Weak/Fault/Better for faultless input;
- applies the same structural standards to prose and code;
- rejects vague praise and vague criticism;
- preserves the original intent or behavior;
- preserves necessary technical terms instead of flattening domain-specific language into generic prose;
- fails answers that evade the required Weak/Fault/Better/Why shape for defective input;
- detects hidden coupling, distant dependencies, vague subjects, weak verbs, generic abstractions, or overloaded units when present;
- detects false force and bad dependency order when present;
- treats deterministic code checks as stronger than taste.
- requires a Checked via entry when code has deterministic checks.
- allows faultless input to pass with a concrete explanation of why its structure works.
- resolves all named main faults in Better or Final version, or states which named faults remain outside the representative contrast.

Fail if the answer:

- gives generic Strunk and White maxims;
- says `unclear`, `awkward`, `verbose`, or `flow` without naming the mechanism;
- praises tone without showing structure;
- rewrites without explaining the relation improved;
- invents faults in already concrete, local, correct input;
- accepts bland output as good because it sounds polished.
- treats originality as novelty instead of concrete specificity.
