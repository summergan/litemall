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

## HTML Review Template

When the final report is rendered as HTML, use a review-first structure:

1. Put the final result on the first visible line:
   `PASS`, `BLOCK`, or `NEEDS_VERIFY`.
2. Render `01 · LAYER RESULTS` as a native disclosure section that is closed
   by default. Do not add an `open` attribute. Its closed summary must show
   the section name and a short hint that the layer execution details can be
   expanded.
3. Inside the expanded layer section, show each layer's command, new tests,
   existing regression, last evidence result, current run status, and coverage
   judgment.
4. Show the Test Strategy to Test Case mapping before the detailed Case list.
5. Render each Case as a separate disclosure section, also closed by default.
   The expanded content must include purpose, strategy layer, preconditions,
   steps, oracle, evidence, and unresolved gap.
6. Keep the final review decision and residual-risk table outside the collapsed
   layer section so the release reviewer can see the decision without opening
   every detail.

Canonical HTML shape:

```html
<div class="status">PASS | BLOCK | NEEDS_VERIFY</div>
<details class="layer-report">
  <summary>01 · LAYER RESULTS · 分层测试执行结果</summary>
  <!-- layer result table -->
</details>
<section id="strategy">Strategy → Case mapping</section>
<details class="case">
  <summary>case_id · result · purpose</summary>
  <!-- case detail and evidence -->
</details>
<section id="review-decision">Residual risks and decision</section>
```

The report generator must preserve the distinction between historical
successful evidence and the current run. A blocked current run is
`NEEDS_VERIFY`, even when the previous evidence package was green.
