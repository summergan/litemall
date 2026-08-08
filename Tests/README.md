# litemall 商品发现课程测试切片

本目录只包含 AI Native 测试转型课程所需的商品发现案例：

`首页 -> 商品列表 -> 商品详情 -> 规格/库存 -> 相关推荐`

## 获取代码

```bash
git clone --branch WS_2026Aug --single-branch \
  https://github.com/summergan/litemall.git
cd litemall
./Tests/scripts/run-layered-tests.sh preflight
```

## 资产

| 层级 | 资产 | 能证明 | 不能证明 |
| --- | --- | --- | --- |
| Backend UT | `WxProductBrowsingUnitTest` | Controller 在受控依赖下的聚合和分支 | HTTP 绑定、真实数据库、页面状态 |
| Contract | `ProductBrowsingContractTest` | 前端路径、Controller mapping、HTTP method 和部分 required query | 完整响应 schema、推荐内容正确性 |
| Frontend IT | `mobile-product-browsing-api.it.test.ts` | API client 的路径、method 和 query | 服务端筛选、页面呈现 |
| E2E harness | `product-browsing-flow.spec.ts` | 受控 harness 中的浏览器 wiring | 部署态 litemall 和真实依赖 |

## 命令

从 litemall 根目录执行：

```bash
./Tests/scripts/run-layered-tests.sh preflight
./Tests/scripts/run-layered-tests.sh browse-frontend-it
./Tests/scripts/run-layered-tests.sh browse-backend-ut
./Tests/scripts/run-layered-tests.sh browse-contract
./Tests/scripts/run-layered-tests.sh browse-e2e
./Tests/scripts/run-layered-tests.sh browse-fast
```

`browse-fast` 运行 Backend UT、Contract 和 Frontend IT，不包含浏览器测试。

## 事实边界

- 当前 `goodsId=100` 是“青瓷杯”，`goodsId=101` 是“手冲壶”。
- 当前 E2E harness 能显示相关推荐，但没有点击推荐并进入新详情页。
- 当前 Backend UT 通过 Mock 证明 Controller 协作，不证明真实数据库过滤。
- “相关推荐排除当前商品”是课程 planned change；形成 Valid Red 即可作为挑战路线交付。
