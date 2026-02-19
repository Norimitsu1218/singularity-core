#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

open_url() {
  if command -v open >/dev/null 2>&1; then
    open "$1"
  else
    echo "open command is unavailable: $1" >&2
    exit 1
  fi
}

ensure_git_repo() {
  git rev-parse --show-toplevel >/dev/null 2>&1 || {
    echo "[NG] not a git repository: $PWD" >&2
    exit 1
  }
}

cmd="${1:-}"

case "$cmd" in
  status)
    ensure_git_repo
    pwd
    git rev-parse --show-toplevel
    git status -sb
    ;;
  gate)
    ensure_git_repo
    ./scripts/gate-deps.sh
    ;;
  diff)
    ensure_git_repo
    git status -sb
    git diff --stat
    ;;
  pr)
    ensure_git_repo
    branch="$(git branch --show-current)"
    owner_repo="$(git config --get remote.origin.url | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##')"
    open_url "https://github.com/${owner_repo}/pull/new/${branch}"
    ;;
  rollback)
    ensure_git_repo
    branch="$(git branch --show-current)"
    git fetch origin
    git reset --hard "origin/${branch}"
    ;;
  stash-safe)
    ensure_git_repo
    if [ -n "$(git status --porcelain)" ]; then
      git stash -u
    fi
    git stash list | head -n 5
    ;;
  *)
    echo "usage: ./cmdbox.sh {status|gate|diff|pr|rollback|stash-safe}" >&2
    exit 2
    ;;
esac
