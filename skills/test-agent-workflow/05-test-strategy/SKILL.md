---
name: test-strategy
description: Convert an approved, layer-neutral Test Case Design into an executable strategy by selecting cases, evidence layers, implementation actions, project targets, commands, runtimes, ordering, gates, and residual-risk ownership.
---

# Test Strategy

## Purpose

Decide **how, where, and when approved business cases will be tested**.
This is the sole owner of test-layer selection and execution planning.

Do not invent a business case, change an oracle, or add a test-design technique.
Return design gaps to `test-case-design` through quality review.

## Required Context

- Passing Test Case Quality Review
- Approved Test Case Design and `case_id` values
- Changed files or feature scope and affected contracts
- `Tests/test-index.yml`, `Tests/README.md`, and the project runner
- Available runtimes and requested delivery profile

Read `references/layer-capabilities.md` when selecting evidence layers. Read
only project inventory and runner entries relevant to candidate layers.

## Strategy Workflow

1. Confirm the exact approved `design_id` and `design_version`.
2. Select the smallest case set required by the requested profile and risks.
3. For each selected `case_id`, choose one or more evidence layers only when
   each layer proves a distinct property.
4. Assign a stable, layer-specific `test_case_id` to every case-layer variant,
   using the project format. Preserve an existing `test_case_id` when reusing
   or extending the same executable test.
5. Assign an `execution_id` to every row in this Strategy run. The business
   `case_id` and executable `test_case_id` remain distinct.
6. Choose one implementation action:
   - `run-existing`
   - `extend-existing`
   - `create-new`
   - `repair-test`
   - `defer`
7. Resolve the layer Skill, target asset, exact command, runtime, prerequisites,
   and expected evidence from the project test inventory and runner. Never
   infer a command from a layer name.
8. Order focused, deterministic checks before infrastructure and browser
   checks while preserving real prerequisites.
9. Record gates, deferred cases, owners, and residual risk.

## Output: Test Strategy

```markdown
## Test Strategy
- strategy_id:
- design_id:
- design_version:
- execution_profile:
- selection_basis:
- gates:

## Execution Plan
| order | execution_id | case_id | test_case_id | layer | layer_skill | action | existing_test | target | command | command_source | runtime | expected_evidence |
| ---: | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## Deferred Cases
| case_id | reason | residual_risk | owner | follow_up |
| --- | --- | --- | --- | --- |

## Strategy Gate
- all_execution_items_reference_approved_cases:
- distinct_evidence_claim_per_added_layer:
- commands_resolved_from_project_sources:
- runtimes_available_or_explicitly_blocked:
- decision: READY | REVISE | BLOCKED

## Handoff
- next_skill: test-execution
```

## Completion Gate

- Every execution item references an approved `case_id`, one stable
  layer-specific `test_case_id`, and exactly one layer.
- Every added layer has a distinct evidence claim.
- Every non-deferred item has one action, layer Skill, target, exact command,
  command source, runtime, order, and expected evidence.
- Every skipped or deferred case has a reason, owner, and residual risk.
- The strategy contains no new business case or changed oracle.
