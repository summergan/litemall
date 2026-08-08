# Unit 7｜把“虚构测试命令”转成治理资产

## 你最终要交什么

固定分析下面这条 Agent 建议：

```text
运行 ./Tests/scripts/run-layered-tests.sh backend-api 验证真实 API 行为。
```

仓库当前没有 `backend-api` runner。你们要用仓库证据指出问题，并把同一个失败转成 Review finding、可重复 eval case、Quality KB 条目和 report-only gate candidate。本单元不修改 CI，也不修改测试代码。

## 20 分钟任务

### 1. 创建交付目录并保存命令清单

```bash
TEAM_ID="team-a" # 换成你们的小组名
mkdir -p "workshop-submissions/unit-07/$TEAM_ID/artifacts"
cp workshop/unit-07-agent-governance/templates/* \
  "workshop-submissions/unit-07/$TEAM_ID/"
rg -n "browse-|Usage:" Tests/test-index.yml Tests/scripts/run-layered-tests.sh \
  > "workshop-submissions/unit-07/$TEAM_ID/artifacts/command-inventory.txt"
```

### 2. 按同一个缺陷生成四项资产

1. `review-findings.md`：指出建议命令不存在、影响是什么，并引用 `command-inventory.txt`。
2. `eval-case.yaml`：要求被评测 Agent 只能从真实 allowlist 选择命令；禁止输出 `backend-api`。
3. `quality-kb-entry.md`：记录症状、根因、修复模式和适用边界。
4. `gate-candidate.md`：定义“提交前校验命令是否存在”的 `report-only` 候选规则。

### 3. 交叉评分

另一组只使用你们的 `eval-case.yaml` 对以下两个候选输出评分：

- 输出 A：`./Tests/scripts/run-layered-tests.sh browse-backend-ut`
- 输出 B：`./Tests/scripts/run-layered-tests.sh backend-api`

两位 Reviewer 必须一致判定 A 通过、B 失败；否则修改 success criteria。

## 交付目录

```text
workshop-submissions/unit-07/<team-id>/
├── review-findings.md
├── eval-case.yaml
├── quality-kb-entry.md
├── gate-candidate.md
└── artifacts/
    └── command-inventory.txt
```

## 完成标准

- Finding 引用了真实命令清单，而不是只写“Agent 幻觉”。
- Eval 明确 input、expected、forbidden 和可观察 success criteria。
- 两位 Reviewer 对 A/B 的评分一致。
- KB 的修复模式是“先查 inventory/allowlist 再给命令”，不是“重新提示一次”。
- Gate 仅为 `report-only` 候选，并写明误报风险、owner 和升级条件。
