# Unit 6｜固定变更事实

- 课程业务规则：相关推荐列表不得包含当前 `goodsId`。
- 仓库映射 Case：`MALL-BROWSE-AC04-BE-UT-001`。
- 当前事实：`WxGoodsController.related(id)` 调用 `queryByCategory` 后直接返回完整列表，没有显式过滤当前 `id`。
- 目标测试事实：当 Mock 返回商品 `100` 与 `101` 时，Expected 列表只包含 `101`。
- 预期 Red：Actual 仍包含 `100`，目标集合断言失败。
- 不在范围：生产修复、真实数据库、推荐排序、Contract、Frontend IT 和 E2E。
