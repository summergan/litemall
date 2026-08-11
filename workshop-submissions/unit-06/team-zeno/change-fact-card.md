# Change Fact Card

- Course rule：相关推荐排除当前 `goodsId`
- Repository Case ID：`MALL-BROWSE-AC04-BE-UT-001`
- Current fact：`WxGoodsController.related(id)` 调用 `queryByCategory` 后直接返回完整列表，没有显式过滤当前 `id`。Mock 仅返回相关商品 `101`，测试从未暴露“当前商品被混入推荐”的缺陷。
- Target fact：当 Mock 同时返回当前商品 `100` 与相关商品 `101` 时，Expected 列表只包含 `101`；当前实现未过滤 `100`，目标断言失败，形成 Valid Red。
- Out of scope：生产修复、真实数据库、推荐排序、Contract、Frontend IT 与 E2E。
- Open questions：无（范围已明确，仅扩展单一测试 fixture 与断言）。
