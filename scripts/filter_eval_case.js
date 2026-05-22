#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const [sourceRoot, destRoot, skillRelPath, evalId] = process.argv.slice(2);

if (!sourceRoot || !destRoot || !skillRelPath || !evalId) {
  console.error("usage: filter_eval_case.js <source-root> <dest-root> <skill-relpath> <eval-id>");
  process.exit(1);
}

const sourceSkill = path.join(sourceRoot, skillRelPath);
const destSkill = path.join(destRoot, skillRelPath);
const sourceEvals = path.join(sourceSkill, "evals", "evals.json");
const destEvals = path.join(destSkill, "evals", "evals.json");

if (!fs.existsSync(sourceEvals)) {
  console.error(`error: skill has no evals/evals.json: ${skillRelPath}`);
  process.exit(1);
}

fs.mkdirSync(path.dirname(destSkill), { recursive: true });
fs.cpSync(sourceSkill, destSkill, {
  recursive: true,
  dereference: false,
  force: true,
});

const evals = JSON.parse(fs.readFileSync(sourceEvals, "utf8"));
const selected = Array.isArray(evals.evals)
  ? evals.evals.filter((entry) => entry && entry.id === evalId)
  : [];

if (selected.length !== 1) {
  const available = Array.isArray(evals.evals)
    ? evals.evals.map((entry) => entry && entry.id).filter(Boolean)
    : [];

  console.error(`error: eval id not found for ${skillRelPath}: ${evalId}`);
  if (available.length > 0) {
    console.error(`available eval ids: ${available.join(", ")}`);
  }
  process.exit(1);
}

fs.writeFileSync(
  destEvals,
  `${JSON.stringify({ ...evals, evals: selected }, null, 2)}\n`,
  "utf8"
);
