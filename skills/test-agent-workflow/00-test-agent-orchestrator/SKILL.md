---
name: test-agent-orchestrator
description: Coordinate an auditable project testing workflow, enforce artifact gates and repair routing, and aggregate final requirement-to-evidence reporting without performing child-stage decisions.
---

# Test Agent Orchestrator

## Purpose

Select the next lifecycle Skill, enforce handoff contracts, and produce the
final report. Do not design Cases, choose test layers, write tests, or replace
project commands.

## Main Flow

| Stage | Skill | Input | Output | Gate |
| --- | --- | --- | --- | --- |
| Requirement | `user-story-intake` when needed | request/source | Story Card | scope and source clear |
| Acceptance | `acceptance-criteria` when needed | Story Card | AC, rules, oracles | conflicts resolved |
| Case Design | `test-case-design` | approved AC and sources | layer-neutral Case Design | P0/P1 covered or blocked |
| Design Review | `test-case-quality-review` | Case Design | approved design version | `PASS` or accepted residual risk |
| Strategy | `test-strategy` | approved design | Execution Plan | `READY` |
| Execution | `test-execution` | READY Strategy | code, results, evidence | intended current-source tests ran |
| Repair | `failure-repair-loop` when red | failure evidence | classified repair and rerun | correct return path used |
| Report | orchestrator | all artifacts | final Test Report | every AC has a verdict |

Existing-case discovery is a procedure inside Case Design. Execution-layer
Skills are adapters selected by Strategy, not lifecycle stages.

## Routing Rules

- Skip Story/AC stages when approved equivalent artifacts already exist.
- Send missing Cases or wrong oracles to Case Design and repeat review.
- Send wrong layers, targets, commands, runtimes, or ordering to Strategy.
- Send test implementation, fixture, runner, or environment defects to Repair
  and targeted Execution.
- Report a product defect unless the request explicitly authorizes product-code
  implementation or repair.
- Run CI, KB, benchmark, and Skill optimization only when their trigger applies.

## Final Test Report

```markdown
## Test Report
- workflow_id:
- requirement:
- design_id_and_version:
- strategy_id:
- overall_result: PASSED | FAILED | BLOCKED | PARTIALLY_PROVEN

## Requirement Traceability
| ac_id | obligation_id | case_id | test_case_ids | execution_ids | results | evidence |
| --- | --- | --- | --- | --- | --- | --- |

## Test Changes
| execution_id | test_case_id | action | file | change |
| --- | --- | --- | --- | --- |

## Execution Summary
| execution_id | layer | command | runtime | result | artifacts |
| --- | --- | --- | --- | --- | --- |

## Unproven and Residual Risk
| ac_id_or_case_id | status | reason | owner | follow_up |
| --- | --- | --- | --- | --- |
```

Never infer requirement success from a green aggregate command alone. Preserve
`NOT_PROVEN`, `INCOMPLETE`, skips, blockers, and evidence boundaries.
