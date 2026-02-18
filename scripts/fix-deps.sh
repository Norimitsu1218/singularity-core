#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

PKG="${1:-@google/generative-ai}"

echo "[A] remove direct dep (if present)"
npm rm "$PKG" 2>/dev/null || true

echo "[B] hard reset local install state"
rm -rf node_modules package-lock.json

echo "[C] reinstall"
npm install

echo "[D] verify: must be 0"
if command -v rg >/dev/null 2>&1; then
  if rg -n "$PKG" package.json package-lock.json; then
    echo "[NG] still referenced: $PKG"
    echo "[HINT] run: npm ls $PKG"
    exit 1
  fi
fi

npm ls "$PKG" || true
echo "[OK] dep removed (or not present) and lock regenerated"
