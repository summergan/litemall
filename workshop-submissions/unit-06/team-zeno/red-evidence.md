# Valid Red Evidence

- Commit/version：`WS_2026Aug` @ `f176defb docs: make student assignments reproducible`（未提交新增改动）
- Working directory：`/Users/wzz/workspace/agentic-engineering/litemall`
- Command：`./Tests/scripts/run-layered-tests.sh browse-backend-ut`
- Exit status：`1`（基线与修改后均见 artifacts 下 `*.exit-status.txt`；基线 `0`，目标运行 `1`）
- Artifact path：`workshop-submissions/unit-06/team-zeno/artifacts/valid-red.log`
- Case ID：`MALL-BROWSE-AC04-BE-UT-001`
- Failure assertion observed：`WxProductBrowsingUnitTest.java:225` 处 `assertEquals(Collections.singletonList(related), relatedData.get("list"));`。实际 `list` 返回 `[id=100 青瓷杯, id=101 手冲壶]`，期望仅 `[id=101 手冲壶]`；即推荐结果仍包含当前商品 `100`。
- Why this is a Valid Red：
  - 基线为 PASS（8 tests, 0 failures）。
  - 修改仅扩展 fixture（`queryByCategory(20,0,6)` 返回 `[100,101]`）并保留原断言，编译与测试启动均成功（8 tests run）。
  - 失败精确落在“推荐列表不应包含当前商品 100”的目标断言，而非环境/编译/fixture/命令错误。
  - `WxGoodsController.java` 未修改，其他 AC 方法断言未扩大。
- What this Red does not prove：
  - 不涉及生产修复（未实现“排除当前 id”的逻辑）。
  - 不验证真实数据库、推荐排序、Contract、Frontend IT 与 E2E。
  - 不证明其他模块或边界条件的行为。
- Result：`VALID RED`
- Next owner/action：由 BE 实现者在 `WxGoodsController.related(id)` 中显式过滤掉当前 `id`，使推荐列表不再包含当前商品，随后将本测试修绿。
