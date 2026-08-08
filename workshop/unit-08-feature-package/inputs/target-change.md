# Unit 8｜固定小需求输入

- 课程规则：相关推荐结果不得包含当前 `goodsId`。
- 仓库 Case：扩展 `MALL-BROWSE-AC04-BE-UT-001`。
- 当前实现：`WxGoodsController.related(id)` 将 `queryByCategory` 的结果直接返回。
- 目标行为：输入当前商品 `100`，service 返回 `[100, 101]` 时，响应列表为 `[101]`。
- Primary layer：Backend UT。
- 必须保护：未知商品仍返回原有错误；相关商品仍被保留；查询分类和 limit 行为不变。
- 不在范围：真实数据库过滤、推荐排序、个性化、Contract、Frontend IT、E2E 与 CI 配置。
