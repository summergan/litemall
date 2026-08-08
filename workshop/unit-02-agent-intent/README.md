# Unit 2｜用一种测试设计方法生成 Agent-ready Intent

## 你最终要交什么

从 A、B、C、D 中只选一个场景，用指定的一种测试设计方法形成 4–6 个测试条件。每个条件必须写代表数据、Expected、选择理由和未覆盖范围。本单元不运行测试，也不修改代码。

## 20 分钟任务

| 选择 | 固定场景 | 只使用的方法 | 必须覆盖 |
| --- | --- | --- | --- |
| A | AC02 `keyword` / `categoryId` 输入域 | 等价类划分 | 有效类、无效类、未决类及代表值 |
| B | AC02 `page` / `limit` | 边界值分析 | `page=0/1/2`、`limit=0/1/10/11` 中有依据的边界与邻近值 |
| C | AC04 规格合法性、商品身份唯一性与 `stock>0` | 判定表 | 可售、零库存、身份冲突、无效组合 |
| D | OS × Browser × Protocol × CPU × DBMS | Pairwise | 参数模型、约束、二阶组合与至少一个风险补充组合 |

## 开始

从仓库根目录执行：

```bash
TEAM_ID="team-a" # 换成你们的小组名
mkdir -p "workshop-submissions/unit-02/$TEAM_ID"
cp workshop/unit-02-agent-intent/templates/method-design-card.md \
  "workshop-submissions/unit-02/$TEAM_ID/"
cp workshop/unit-02-agent-intent/templates/agent-ready-intent-summary.yaml \
  "workshop-submissions/unit-02/$TEAM_ID/"
cp workshop/unit-02-agent-intent/templates/review.md \
  "workshop-submissions/unit-02/$TEAM_ID/"
```

然后按顺序完成：

1. 阅读 [inputs/business-rules.md](inputs/business-rules.md) 与 [inputs/representative-data.md](inputs/representative-data.md)。
2. 在 `method-design-card.md` 第一行写明选择 A/B/C/D、对应 AC 与方法。
3. 生成 6–8 个候选条件，再删到 4–6 个；保留项必须有理由。
4. 把同一结论同步到 `agent-ready-intent-summary.yaml`。
5. 交给另一组填写 `review.md`。

## 交付目录

```text
workshop-submissions/unit-02/<team-id>/
├── method-design-card.md
├── agent-ready-intent-summary.yaml
└── review.md
```

## 完成标准

- 只使用一种方法，没有把多个方法混成清单。
- 4–6 个条件均有数据、Expected、rationale 与 not covered。
- Oracle 来源是业务规则或明确的待确认项，不是从当前代码反推。
- Reviewer 能指出覆盖了什么、没覆盖什么，并给出 `Ready / Revise / Blocked`。

参考成品结构见 [examples/u2-a-equivalence-complete.md](examples/u2-a-equivalence-complete.md)。示例不是可直接提交的答案。
