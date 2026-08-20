# Test Agent Workflow Design

## Core Logic

```text
Requirement and AC when needed
  -> layer-neutral Test Case Design
  -> Case Design Review
  -> Test Strategy selects layers and project execution
  -> Test Execution loads selected layer Skills
  -> classified repair loops
  -> final AC-to-evidence Test Report
```

## Ownership

| Stage | Owns | Does not own |
| --- | --- | --- |
| Story and AC | intent, scope, rules, observable oracles | business Cases or test layers |
| Case Design | obligations, existing-case decisions, techniques, business Cases | layers, frameworks, commands, runtimes |
| Design Review | completeness, traceability, oracle and Case quality | rewriting Cases or execution planning |
| Strategy | selected Cases, layers, actions, targets, commands, runtime, order, gates | inventing Cases or changing oracles |
| Execution | selected-layer implementation, CLI execution, evidence | layer selection or business design |
| Repair | failure classification and minimal authorized correction | hidden expectation changes |
| Orchestrator | routing, gates, final report | child-stage decisions |

## Artifact Contract

```text
Acceptance Criteria
  -> Test Case Design
       design_id + version
       obligation_id + source + oracle
       case_id + actions + expected_result
       existing-case decision + technique artifact + blockers
  -> Quality Review
       approved design version + findings + approved case_ids
  -> Test Strategy
       strategy_id
       execution_id + case_id + test_case_id + layer + layer_skill + action
       target + command + runtime + order + expected_evidence
  -> Test Execution
       execution_id + test_case_id + test asset + command + runtime
       result + oracle observation + artifacts
  -> Final Test Report
       AC -> obligation -> case -> execution -> evidence
```

## Repair Routing

| Defect | Return to |
| --- | --- |
| missing Case, wrong action/data/oracle | Case Design, Review, Strategy |
| wrong layer, target, command, runtime, or order | Test Strategy |
| test code, fixture, runner, or environment | Failure Repair, targeted Execution |
| product implementation | report, or fix only with explicit authorization |

## Progressive Loading

- Case Design loads only needed technique or discovery references.
- Strategy loads `references/layer-capabilities.md` and relevant project index
  entries.
- Execution loads only layer Skills named by the Execution Plan.
- Runtime references such as Colima are loaded only when that runtime is needed.
- Governance Skills are conditional and never a mandatory tail.
