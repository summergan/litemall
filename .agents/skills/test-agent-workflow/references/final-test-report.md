# Final Test Report

Read this only when the orchestrator aggregates completed workflow artifacts.

```markdown
## Test Report
- workflow_id:
- requirement:
- design_id_and_version:
- strategy_id:
- overall_result: PASSED | FAILED | BLOCKED | PARTIALLY_PROVEN

## Requirement Traceability
| ac_id | obligation_id | case_id | test_case_ids | execution_ids | result | evidence |
| --- | --- | --- | --- | --- | --- | --- |

## Layer Results
| layer | new_tests | existing_regression | result | evidence |
| --- | ---: | ---: | --- | --- |

## Test Changes
| execution_id | test_case_id | action | file | change |
| --- | --- | --- | --- | --- |

## Unproven and Residual Risk
| ac_id_or_case_id | status | reason | owner | follow_up |
| --- | --- | --- | --- | --- |
```

Separate newly added tests from existing regression. Do not label all existing
regression as impact coverage. Never infer requirement success from a green
aggregate command alone; preserve blockers, skips, stale evidence, and
`NOT_PROVEN` boundaries.
