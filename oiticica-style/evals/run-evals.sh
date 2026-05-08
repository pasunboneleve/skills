#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SKILL="$ROOT/oiticica-style"

required_files=(
  "$SKILL/SKILL.md"
  "$SKILL/rubric.md"
  "$SKILL/examples/prose.md"
  "$SKILL/examples/code.md"
  "$SKILL/examples/documentation.md"
  "$SKILL/examples/architecture.md"
  "$SKILL/evals/cases.yaml"
  "$SKILL/evals/judge_prompt.md"
)

for file in "${required_files[@]}"; do
  test -s "$file"
done

rg -q "Weak:" "$SKILL"
rg -q "Fault:" "$SKILL"
rg -q "Better:" "$SKILL"
rg -q "Why:" "$SKILL"
rg -q "hidden dependency|overloaded unit|vague subject|weak verb|generic abstraction" "$SKILL"
rg -q "compiler|tests|lints|type checks|benchmarks|CI" "$SKILL/SKILL.md"
rg -q "negative_control" "$SKILL/evals/cases.yaml"
rg -q "preserve-domain-language" "$SKILL/evals/cases.yaml"
rg -q "negative-format-evasion" "$SKILL/evals/cases.yaml"
rg -q "prose-false-force" "$SKILL/evals/cases.yaml"
rg -q "harmony-wrong-order" "$SKILL/evals/cases.yaml"
rg -q "positive_perfect" "$SKILL/evals/cases.yaml"
rg -q "mixed-quality-smallest-unit" "$SKILL/evals/cases.yaml"
rg -q "corporate-buzzword-trap" "$SKILL/evals/cases.yaml"
rg -q "behavior-preservation-edge-case" "$SKILL/evals/cases.yaml"
rg -q "perfect-input-bypass" "$SKILL/evals/cases.yaml"
rg -q "code-cross-file-locality" "$SKILL/evals/cases.yaml"
rg -q "prose-subject-action-separation" "$SKILL/evals/cases.yaml"
rg -q "corporate-compliance-trap" "$SKILL/evals/cases.yaml"
rg -q "technical-term-flattening" "$SKILL/evals/cases.yaml"
rg -q "multiple-fault-resolution" "$SKILL/evals/cases.yaml"
rg -q "strict-format-on-code" "$SKILL/evals/cases.yaml"
rg -q "framework-name-preservation" "$SKILL/evals/cases.yaml"
rg -q "final-version-scope" "$SKILL/evals/cases.yaml"
rg -q "contrast-only-request" "$SKILL/evals/cases.yaml"
rg -q "ai-sludge-rejection" "$SKILL/evals/cases.yaml"
rg -q "deterministic-judge-verification" "$SKILL/evals/cases.yaml"
rg -q "invalid-code-priority" "$SKILL/evals/cases.yaml"
rg -q "unresolved-faults-in-contrast" "$SKILL/evals/cases.yaml"
rg -q "Structural highlight" "$SKILL/SKILL.md" "$SKILL/evals/cases.yaml"
rg -q "Strong" "$SKILL/SKILL.md" "$SKILL/evals/cases.yaml"
rg -q "Mechanism" "$SKILL/SKILL.md" "$SKILL/evals/cases.yaml"
rg -q "Checked via" "$SKILL/SKILL.md" "$SKILL/evals/cases.yaml"
rg -q "Faults not resolved in this contrast" "$SKILL/SKILL.md" "$SKILL/evals/cases.yaml"

echo "oiticica-style eval assets passed static checks"
