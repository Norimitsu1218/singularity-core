#!/usr/bin/env bash
set -euo pipefail
# policy: fail if high/critical exist
json="$(npm audit --json || true)"

# jq が無い環境もあるので node で判定
node - <<'JS' <<<"$json"
const input = require('fs').readFileSync(0,'utf8');
if (!input.trim()) process.exit(0);
let j; try { j = JSON.parse(input); } catch { process.exit(0); }
const meta = j.metadata?.vulnerabilities || {};
const high = meta.high || 0;
const critical = meta.critical || 0;
if (high > 0 || critical > 0) {
  console.error(`[NG] audit policy: high=${high} critical=${critical}`);
  process.exit(1);
}
console.log(`[OK] audit policy: high=${high} critical=${critical} (moderate/low allowed)`);
JS
