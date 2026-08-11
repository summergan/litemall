# Test Planner

- Changed surface：`WxProductBrowsingUnitTest.mallBrowseAc04BeUt001_relatedRejectsUnknownGoodsAndUsesCategoryRecommendations` 的 fixture 与断言（仅此一方法）。
- Primary layer：`Backend UT`
- Existing case：`MALL-BROWSE-AC04-BE-UT-001`
- Command：`./Tests/scripts/run-layered-tests.sh browse-backend-ut`
- Fixture delta：将 `queryByCategory(20, 0, 6)` 的 stub 从 `singletonList(related)` 改为 `Arrays.asList(goods, related)`，即 Mock 同时返回当前商品 `100` 与相关商品 `101`。
- Expected Red assertion：`assertEquals(Collections.singletonList(related), relatedData.get("list"))`（期望仅 `101`）。因实现未过滤当前 `id`，实际返回 `[100, 101]`，该断言失败。
- Adjacent layers skipped and reason：
  - Frontend IT / E2E：超出本单元范围，不在 scope。
  - Contract：本单元不涉及接口契约测试。
  - 其他 AC（AC01~AC06 的其余方法）：仅扩展 AC04，不扩大其他 Case 断言。
- Stop rule：基线为 PASS；修改后编译成功且失败发生在“列表仍包含当前商品 100”的目标断言，即停止（不修绿、不改动生产代码）。
- Planner Gate：`Approved`
