# Runbook

## Daily Start

```bash
cd /Users/norimitsu/codex_work/singularity-core
git pull --ff-only
./cmdbox.sh status
./cmdbox.sh gate
./cmdbox.sh diff
```

If you are opening a PR:

```bash
./cmdbox.sh pr
```

## Recovery

Stash current work safely:

```bash
./cmdbox.sh stash-safe
```

Reset current branch to remote state:

```bash
./cmdbox.sh rollback
./cmdbox.sh status
```

## Rules

- Run `status -> gate -> diff` in this order.
- Do not skip `diff` before opening a PR.
- If `gate` fails, fix first; do not force through.
