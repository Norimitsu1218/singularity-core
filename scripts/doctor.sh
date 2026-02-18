#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

TS="$(date +%Y%m%d_%H%M%S)"
OUT="artifacts/doctor_$TS"
mkdir -p "$OUT"

echo "[1/6] env"
node -v | tee "$OUT/node.txt"
npm -v  | tee "$OUT/npm.txt"

echo "[2/6] who pulls @google/generative-ai"
npm ls @google/generative-ai >"$OUT/npm_ls_google_generative_ai.txt" 2>&1 || true

echo "[3/6] ripgrep hits"
if command -v rg >/dev/null 2>&1; then
  rg -n "@google/generative-ai" -S . >"$OUT/rg_hits.txt" 2>&1 || true
else
  echo "rg not found" >"$OUT/rg_hits.txt"
fi

echo "[4/6] lock/package hits (hard gate evidence)"
( rg -n "@google/generative-ai" package.json package-lock.json 2>/dev/null || true ) >"$OUT/rg_pkg_lock_hits.txt"

echo "[5/6] audit summary"
npm audit --json >"$OUT/npm_audit.json" 2>/dev/null || true

echo "[6/6] summary md"
cat > "$OUT/SUMMARY.md" <<MD
# Doctor Summary ($TS)

## npm ls
- see: npm_ls_google_generative_ai.txt

## rg hits (repo)
- see: rg_hits.txt

## package/lock hits
- see: rg_pkg_lock_hits.txt

## audit
- see: npm_audit.json
MD

echo "[OK] wrote $OUT"
