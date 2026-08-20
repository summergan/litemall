---
name: test-case-design
description: Design traceable, implementation-neutral business test cases from approved acceptance criteria, business rules, contracts, risks, and existing coverage. Use before test strategy; do not select test layers, frameworks, commands, runtimes, or execution profiles.
---

# Test Case Design

## Purpose

Define **what must be tested** without deciding how or where it will run.
Produce business test cases that `test-case-quality-review` can approve and
`test-strategy` can later map to one or more evidence layers.

Do not write test code, select Unit/Contract/Integration/E2E, resolve commands,
or define an execution profile.

## Required Context

- Story Card or authoritative requirement
- Approved Acceptance Criteria and Business Rule Table
- Relevant API, schema, event, state, and interface contracts
- Changed surface or stated feature scope
- Existing tests and `Tests/test-index.yml` when available

If the requirement, rule, contract, or oracle conflicts, return `BLOCKED` with
the conflict and owner. Existing behavior is not an oracle unless it is an
approved requirement.

## Workflow

### 1. Establish the test basis

Create coverage obligations from AC, business rules, contracts, invariants,
accepted incident evidence, and applicable risks. Give each obligation an
observable oracle and priority.

### 2. Discover existing coverage

Search by feature, AC terms, business objects, routes, state transitions,
events, fixtures, and changed modules. Inspect assertions rather than relying
on filenames. Read `references/existing-case-discovery.md` when the repository
is large, coverage is unclear, or reuse decisions are contested.

Classify relevant existing cases as:

| decision | meaning |
| --- | --- |
| `reuse` | already proves the same obligation, data condition, and oracle |
| `extend` | useful coverage exists but a case, boundary, or assertion is missing |
| `new` | no credible existing case proves the obligation |
| `repair` | the case is valuable but its setup or assertion is defective |
| `retire` | it proves obsolete behavior; human approval is required |
| `needs-clarification` | intended behavior conflicts or is undefined |

Do not create a duplicate replacement when reuse or a small extension is
sufficient.

### 3. Design cases

Design the smallest complete business case set. Use a technique only when it
materially shapes case selection. Read at most the relevant references:

- `references/test-design-techniques.md` for equivalence classes, boundaries,
  decision tables, state transitions, pairwise, and related techniques
- `references/cause-effect-graph.md` for interacting rules and constraints

Technique artifacts belong to Case Design because they explain how cases were
derived. Test layers and implementation patterns do not.

### 4. Consolidate and specify

Merge reused, extended, repaired, and new coverage into one case catalog.
Deduplicate by obligation + data condition + action + oracle. Preserve an
existing case identity when it still represents the approved business case.

Each `case_id` is a stable, layer-neutral business identity. State purpose,
preconditions, data, action or ordered steps, expected result, oracle,
priority, and source. Do not create an execution or layer-specific ID here.

## Output: Test Case Design

```markdown
## Test Case Design
- design_id:
- design_version:
- feature_scope:

## Coverage Obligations
| obligation_id | source | risk | oracle | priority | status |
| --- | --- | --- | --- | --- | --- |

## Existing Case Decisions
| existing_case_id | obligation_id | decision | evidence_gap_or_reason | source |
| --- | --- | --- | --- | --- |

## Test Cases
| case_id | obligation_id | origin | purpose | preconditions | test_data | actions | expected_result | oracle | priority |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## Technique Artifacts
Include only artifacts for techniques that materially shaped the cases.

## Gaps and Blockers
| obligation_id | status | reason | owner | next_action |
| --- | --- | --- | --- | --- |

## Handoff
- next_skill: test-case-quality-review
```

## Completion Gate

- Every P0/P1 AC or obligation maps to a case or explicit blocker.
- Every case has a source and observable oracle.
- Every relevant existing case has a decision.
- Actions, data, expected results, and cleanup are implementable without
  redoing business analysis.
- No test layer, framework, command, runtime, target file, or execution profile
  is selected.
