---
name: test-execution
description: Implement and run an approved Test Strategy through only its selected project layer Skills, project test inventory, and CLI; preserve case identity and produce auditable evidence without redesigning cases or changing layer choices.
---

# Test Execution

## Purpose

Consume a `READY` Test Strategy and turn its Execution Plan into test code,
commands, and evidence. Do not select layers, change an oracle, add business
cases, or load unselected layer Skills.

## Required Input

- Approved Test Case Design and exact `design_version`
- `READY` Test Strategy
- Execution Plan rows containing `execution_id`, `case_id`, `test_case_id`, `layer`,
  `layer_skill`, `action`, target, command, runtime, and expected evidence
- Project `Tests/test-index.yml`, test README, and runner

## Selected Layer Skills

Load only Skills named by the Execution Plan:

| Strategy layer | Skill |
| --- | --- |
| `backend-ut` | `01-backend-ut/SKILL.md` |
| `frontend-ut` | `02-frontend-ut/SKILL.md` |
| `contract` | `03-contract-test/SKILL.md` |
| `frontend-it` | `04-frontend-it/SKILL.md` |
| `backend-it` | `05-backend-it-testcontainers/SKILL.md` |
| `e2e` | `06-e2e-smoke/SKILL.md` |

The project CLI is the execution authority. A layer Skill explains how to
implement and verify that layer; it does not replace `Tests/test-index.yml` or
invent commands.

## Execution Workflow

For each Execution Plan row in order:

1. Verify the `case_id` exists in the approved design, `test_case_id` matches
   the selected layer and project format, and the row has exactly one layer.
2. Load only the selected layer Skill and inspect the target source, existing
   tests, fixtures, and project runner entry.
3. Apply the planned action:
   - `run-existing`: do not generate a duplicate test.
   - `extend-existing`: make the smallest assertion, data, or case extension.
   - `create-new`: create one focused executable test for the approved case.
   - `repair-test`: repair setup or assertion without changing the oracle.
   - `defer`: do not implement or run; preserve owner and residual risk.
4. For changed tests, run the narrowest available focused command first.
5. Run the Strategy command or declared layer gate.
6. Prove the intended current-source test ran; zero selected tests, stale
   artifacts, swallowed setup failures, or undeclared skips are not passing.
7. Record runtime, fixture/reset state, exit status, report paths, and the
   observation that satisfies or falsifies the approved oracle.

Shared implementation rules:

- Test observable behavior rather than private methods or incidental calls.
- Keep data deterministic and reset mutable state.
- Mock only outside the behavior the selected layer must prove.
- Fail loudly on missing dependencies, setup errors, and selector mismatch.
- Do not modify production behavior unless the user explicitly authorized an
  implementation or defect fix.

## Result Status

| Status | Meaning |
| --- | --- |
| `PASSED` | intended current-source test ran and satisfied the oracle |
| `FAILED` | intended test ran and falsified the oracle |
| `BLOCKED` | requirement, dependency, runtime, or environment prevented evidence |
| `SKIPPED` | Strategy explicitly deferred or skipped the execution item |
| `NOT_PROVEN` | available evidence cannot prove the Case claim |
| `INCOMPLETE` | setup, selector, stale artifact, or partial run invalidated the result |

## Output

```markdown
## Test Execution Report
| execution_id | case_id | test_case_id | layer | action | test_file | command | runtime | result | oracle_observation | artifacts |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## Changed Test Assets
| execution_id | file | change | reason |
| --- | --- | --- | --- |

## Unproven or Deferred
| execution_id | case_id | test_case_id | status | reason | residual_risk | owner |
| --- | --- | --- | --- | --- | --- | --- |
```

Send implementation, fixture, runner, or environment failures to
`failure-repair-loop`. Return a wrong case or oracle to Case Design review and
a wrong layer, command, target, runtime, or order to Test Strategy.
