# Unit 8｜交付“相关推荐排除当前商品”Feature Package

## 你最终要完成什么

围绕一个固定小需求完成 Red → Green：当 `WxGoodsController.related(100)` 查询同类商品时，即使 service 返回当前商品 `100`，最终响应也必须排除它并保留其他相关商品。

本任务承接 Unit 6 的 Valid Red，但可以独立完成。只修改一个 Backend UT 和 `WxGoodsController.related` 的最小实现，不扩展推荐排序、数据库查询、Contract、页面或 E2E。

## 70 分钟任务

### 1. 创建交付目录

```bash
TEAM_ID="team-a" # 换成你们的小组名
mkdir -p "workshop-submissions/unit-08/$TEAM_ID/artifacts"
cp workshop/unit-08-feature-package/templates/* \
  "workshop-submissions/unit-08/$TEAM_ID/"
```

### 2. 锁定范围并确认基线（0–15 分钟）

阅读 [inputs/target-change.md](inputs/target-change.md)，完成 `scope-card.md`、`test-analysis.yaml` 与 `test-planner.md`，然后执行：

```bash
./Tests/scripts/run-layered-tests.sh preflight
./Tests/scripts/run-layered-tests.sh browse-backend-ut \
  > "workshop-submissions/unit-08/$TEAM_ID/artifacts/00-baseline-green.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-08/$TEAM_ID/artifacts/00-baseline-green.exit-status.txt"
```

基线不绿时停止修改并提交 `BLOCKED`。

### 3. 生成目标 Red（15–35 分钟）

只扩展：

```text
Tests/backend/src/test/java/org/linlinjava/litemall/tests/unit/WxProductBrowsingUnitTest.java
```

目标方法：

```text
mallBrowseAc04BeUt001_relatedRejectsUnknownGoodsAndUsesCategoryRecommendations
```

让 Mock 返回当前商品 `100` 和相关商品 `101`，断言响应只包含 `101`。运行并保存日志：

```bash
./Tests/scripts/run-layered-tests.sh browse-backend-ut \
  > "workshop-submissions/unit-08/$TEAM_ID/artifacts/01-target-red.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-08/$TEAM_ID/artifacts/01-target-red.exit-status.txt"
```

只有命中目标集合断言的失败才可进入下一步。

### 4. 实现最小 Green（35–55 分钟）

只修改：

```text
litemall-wx-api/src/main/java/org/linlinjava/litemall/wx/web/WxGoodsController.java
```

在 `related(id)` 返回前过滤 `item.id == 当前 id`。不得修改 service 查询、排序、页大小或其他 Controller。

```bash
./Tests/scripts/run-layered-tests.sh browse-backend-ut \
  > "workshop-submissions/unit-08/$TEAM_ID/artifacts/02-target-green.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-08/$TEAM_ID/artifacts/02-target-green.exit-status.txt"
./Tests/scripts/run-layered-tests.sh browse-fast \
  > "workshop-submissions/unit-08/$TEAM_ID/artifacts/03-regression.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-08/$TEAM_ID/artifacts/03-regression.exit-status.txt"
git diff > "workshop-submissions/unit-08/$TEAM_ID/artifacts/product-and-test-delta.patch"
```

### 5. 整理证据并 Review（55–70 分钟）

完成 `product-delta.md`、`test-delta.md`、`execution-record.md`、`evidence-summary.md` 与 `feedback-item.yaml`，再由另一组填写 `review.md`。

## 交付目录

```text
workshop-submissions/unit-08/<team-id>/
├── scope-card.md
├── test-analysis.yaml
├── test-planner.md
├── product-delta.md
├── test-delta.md
├── execution-record.md
├── evidence-summary.md
├── feedback-item.yaml
├── review.md
└── artifacts/
    ├── 00-baseline-green.log
    ├── 00-baseline-green.exit-status.txt
    ├── 01-target-red.log
    ├── 01-target-red.exit-status.txt
    ├── 02-target-green.log
    ├── 02-target-green.exit-status.txt
    ├── 03-regression.log
    ├── 03-regression.exit-status.txt
    └── product-and-test-delta.patch
```

## 完成标准

- 有独立的 baseline Green、目标 Red、目标 Green 与 regression 记录。
- Red 命中“当前商品仍在结果中”的目标断言；Green 来自最小产品修改。
- `git diff` 只包含指定 Backend UT 与 `WxGoodsController.related` 的必要变化。
- Evidence Summary 不把受控 Backend UT 扩大为真实 DB、HTTP、页面或生产证明。
- Reviewer 能从 Scope 一路追到命令、日志、diff、结论与残余风险。

任何阶段因环境或错误类型不符而停止时，提交已有产物并标记 `BLOCKED`；不得用修改断言换取 Green。
