# Prompt Template

Use this template when starting a new task.

```text
Goal:
- [What you want to create in one sentence]

Output format:
- [e.g. checklist / markdown guide / JSON / code files]

Constraints:
- Gate-First policy must be kept.
- Keep implementation practical and executable.
- Avoid ambiguous suggestions.

Definition of done:
- Files are created or updated in this repo.
- `./cmdbox.sh gate` passes.
- `./cmdbox.sh diff` reflects only intended changes.
```

## Examples

```text
Goal:
- Create a 30-day note monetization execution plan.

Output format:
- Markdown checklist with daily actions and KPI fields.
```

```text
Goal:
- Generate 20 post title candidates with A/B test tags.

Output format:
- CSV file with columns: title, angle, audience, hypothesis.
```
