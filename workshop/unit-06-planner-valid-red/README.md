# Unit 6｜把“排除当前商品”变成 Valid Red

## 你最终要交什么

扩展仓库中现有的 `MALL-BROWSE-AC04-BE-UT-001`，让 Mock 同时返回当前商品 `100` 和相关商品 `101`，再断言响应只能保留 `101`。当前产品实现尚未过滤 `100`，因此正确结果是编译成功并在目标断言失败的 **Valid Red**。

本单元不修改生产代码，也不要求把测试修绿。

## 30 分钟任务

### 1. 创建交付目录

```bash
TEAM_ID="team-a" # 换成你们的小组名
mkdir -p "workshop-submissions/unit-06/$TEAM_ID/artifacts"
cp workshop/unit-06-planner-valid-red/templates/*.md \
  "workshop-submissions/unit-06/$TEAM_ID/"
```

### 2. 确认绿色基线

```bash
./Tests/scripts/run-layered-tests.sh browse-backend-ut \
  > "workshop-submissions/unit-06/$TEAM_ID/artifacts/baseline-green.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-06/$TEAM_ID/artifacts/baseline-green.exit-status.txt"
```

基线不是绿色时停止修改，保留日志并提交 `BLOCKED`。

### 3. 先写 Planner，再改测试

阅读 [inputs/change-fact.md](inputs/change-fact.md)，依次完成：

1. `change-fact-card.md`
2. `test-planner.md`
3. `case-delta.md`

### 4. 只修改指定测试

文件：

```text
Tests/backend/src/test/java/org/linlinjava/litemall/tests/unit/WxProductBrowsingUnitTest.java
```

方法：

```text
mallBrowseAc04BeUt001_relatedRejectsUnknownGoodsAndUsesCategoryRecommendations
```

必须完成的 Test Delta：

- 增加当前商品 `goods(100, "青瓷杯", 20)` 与相关商品 `goods(101, "手冲壶", 20)`。
- 让 `queryByCategory(20, 0, 6)` 返回 `[100, 101]`。
- 断言响应列表只包含商品 `101`。
- 不修改 `WxGoodsController.java`，不改变其他 Case。

### 5. 运行并保存目标 Red

```bash
./Tests/scripts/run-layered-tests.sh browse-backend-ut \
  > "workshop-submissions/unit-06/$TEAM_ID/artifacts/valid-red.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-06/$TEAM_ID/artifacts/valid-red.exit-status.txt"
git diff -- Tests/backend/src/test/java/org/linlinjava/litemall/tests/unit/WxProductBrowsingUnitTest.java \
  > "workshop-submissions/unit-06/$TEAM_ID/artifacts/test-delta.patch"
```

最后填写 `red-evidence.md`。

## 交付目录

```text
workshop-submissions/unit-06/<team-id>/
├── change-fact-card.md
├── test-planner.md
├── case-delta.md
├── red-evidence.md
└── artifacts/
    ├── baseline-green.log
    ├── baseline-green.exit-status.txt
    ├── valid-red.log
    ├── valid-red.exit-status.txt
    └── test-delta.patch
```

## Valid Red 完成标准

- 基线运行原本为 `PASS`。
- 修改后的测试可以编译和启动。
- 失败发生在“结果仍包含当前商品 100”的目标断言，而不是环境、编译、fixture 或命令错误。
- 生产代码没有修改，其他 AC 没有扩大。
- `red-evidence.md` 能定位 Case、失败断言、日志和下一步 owner。

不满足前三项时记录 `Revise` 或 `BLOCKED`，不能把任意红色称为 Valid Red。
