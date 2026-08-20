---
name: test-agent-workflow
description: Coordinate a project testing workflow from optional requirement intake through layer-neutral Test Case Design, design review, Test Strategy, selected-layer execution, repair, and final evidence reporting.
---

# Test Agent Workflow

Use the smallest entrypoint matching the request. Use this top-level Skill when
the user asks for an end-to-end requirement-to-evidence workflow.

## Core Flow

```text
User Story Intake when needed
  -> Acceptance Criteria when needed
  -> Test Case Design
  -> Test Case Quality Review
  -> Test Strategy
  -> Test Execution through selected layer Skills
  -> Failure Repair when needed
  -> Final Test Report
```

## Responsibility Contract

- Test Case Design defines layer-neutral business Cases and integrates existing
  coverage discovery.
- Quality Review approves or returns the Case Design; it does not select layers
  or commands.
- Test Strategy is the sole owner of case selection, evidence layers,
  implementation actions, targets, commands, runtimes, order, and gates.
- Test Execution loads only layer Skills selected by Strategy, runs the project
  CLI, and records evidence without changing the Case or Strategy.
- Failure Repair routes design defects back to Design, strategy defects back to
  Strategy, and implementation/runtime defects to targeted execution.
- The orchestrator aggregates AC-to-Case-to-Execution evidence into the final
  Test Report.

## Direct Entrypoints

| Intent | Skill |
| --- | --- |
| Full workflow | `test-agent-workflow` |
| Design or review business Cases | `test-case-design` |
| Select layers and plan execution | `test-strategy` |
| Implement and run a READY strategy | `test-execution` |

Users name only the desired entrypoint; the parent loads references and child
Skills lazily. See `skill-index.yml` for routing and `workflow-design.md` for
artifact contracts.

After changing this workflow, run its deterministic structural check before a
project benchmark:

```bash
ruby "AI Native/skills/test-agent-workflow/scripts/validate-workflow.rb"
```

Example requests:

```text
使用 test-agent-workflow：读取这份需求，完成从 AC 到最终测试报告的全流程。

使用 test-case-design：查找相关已有用例并设计业务 Test Cases，不选择测试层。

使用 test-strategy：读取评审通过的 Case Design，选择测试层、命令和执行顺序。

使用 test-execution：严格执行 READY Strategy，只加载其中选中的层级 Skills。
```
