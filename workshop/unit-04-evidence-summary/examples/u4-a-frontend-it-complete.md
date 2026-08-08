# 示例｜U4-A Frontend IT 的完整 Evidence Summary

> 这是作业的参考结构，不是可直接提交的答案。提交时必须替换为本组的 commit、时间、日志路径和实际运行结果。

## Checkpoint 1｜Evidence Plan

- Goal：验证商品详情页相关商品请求的 API client 调用是否使用 `/goods/related`、`GET` 和 `id` query。
- Acceptance criterion：`MALL-BROWSE-AC04-FE-IT-001` 的断言通过，且日志显示前端集成测试完成。
- Primary layer / runner mode：Frontend IT / `browse-frontend-it`
- Case ID：`MALL-BROWSE-AC04-FE-IT-001`
- Commit/version：`<填写本组 git rev-parse HEAD 输出>`
- Working directory：`<填写本机仓库绝对路径>`
- Command：`./Tests/scripts/run-layered-tests.sh browse-frontend-it`
- Planned evidence boundary / This run does not prove：该测试只验证 API client 的请求构造；不证明后端推荐算法、数据库过滤、页面展示或用户点击后的跳转。

## Checkpoint 2｜Run Record

- Result：`PASS`
- Exit status：`0`
- Failure classification / blocker：无；运行时可出现 Node 的 `localStorage` experimental warning，但本次不影响 Vitest 结果。
- Artifact path：`workshop-submissions/unit-04/<team-id>/artifacts/u4-a-frontend-it.log`
- Observed facts：Vitest 执行 `tests/it/mobile-product-browsing-api.it.test.ts`；该文件共 6 个测试通过，其中包含 `MALL-BROWSE-AC04-FE-IT-001 requests related goods by id`。

## Checkpoint 3｜Evidence Decision

- This run proves：在当前 commit 和受控测试环境中，`goodsRelated({ id: 100 })` 发出的请求构造为 `GET /goods/related`，query 为 `{ id: 100 }`。
- This run does not prove：后端 `related` Controller 的运行行为、真实数据库中的相关商品列表、响应 schema、页面是否展示相关商品，以及用户是否能点击进入下一页。
- Residual risk：前后端接口虽可被请求构造层覆盖，但后端运行时响应与页面交互仍未由本次证据覆盖。
- Next action：如需验证路由与 Controller mapping，补充 U4-C Contract；如需验证后端受控逻辑，补充 U4-B Backend UT。
- Follow-up owner：`<填写角色或姓名>`
- Gate decision：`ACCEPT LOCAL EVIDENCE`

## 为什么这个示例合格

- 运行结论与日志中可见的测试范围一致。
- 将 API client 的 `PASS` 限定在请求构造层，没有写成“相关商品功能完整可用”。
- 明确列出了缺口，并给出了下一步应补的测试层。
