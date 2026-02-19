# Definition Of Done

## Operating Policy

- Gate-First is the governing policy.
- Do not run dual definitions at once:
  - `Gate-First (denylist strict)` and
  - `Allow forbidden SDK usage`
- Pick one policy and keep it consistent through the task.

## Completion Checklist

- Intended files are created/updated.
- `./cmdbox.sh status` confirms correct repo/branch.
- `./cmdbox.sh gate` passes.
- `./cmdbox.sh diff` matches intended scope only.
- PR is opened via `./cmdbox.sh pr` when ready.

## Safety Checklist

- Before destructive recovery, confirm branch:

```bash
git branch --show-current
```

- Optional safe stash before rollback:

```bash
./cmdbox.sh stash-safe
```

- Rollback command:

```bash
./cmdbox.sh rollback
```
