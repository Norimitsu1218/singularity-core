#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# approved: used by app
DENYLIST=(
  # "@google/generative-ai"
)

fail=0
for dep in "${DENYLIST[@]}"; do
  if command -v rg >/dev/null 2>&1; then
    if rg -n "$dep" package.json package-lock.json >/dev/null 2>&1; then
      echo "[NG] denylisted dep referenced: $dep"
      fail=1
    fi
  else
    if grep -R "$dep" package.json package-lock.json >/dev/null 2>&1; then
      echo "[NG] denylisted dep referenced: $dep"
      fail=1
    fi
  fi
done

if [ "$fail" -eq 1 ]; then
  echo "[NG] dependency gate failed"
  exit 1
fi
echo "[OK] dependency gate passed"
