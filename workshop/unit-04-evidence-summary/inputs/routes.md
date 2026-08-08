# Unit 4｜测试层选择与运行入口

课堂小组从下表选择一个 Primary Layer。选择依据是 Goal 的最低可信观察边界，而不是哪一条命令最容易得到绿色结果。

| 路线 | Primary Layer | 真实 Case ID | 运行命令 | 直接证据重点 | 不能外推 |
| --- | --- | --- | --- | --- | --- |
| U4-A | Frontend IT | `MALL-BROWSE-AC04-FE-IT-001` | `./Tests/scripts/run-layered-tests.sh browse-frontend-it` | API client 的 path、method 与 query 参数 | 后端推荐规则、页面展示与点击 |
| U4-B | Backend UT | `MALL-BROWSE-AC04-BE-UT-001` | `./Tests/scripts/run-layered-tests.sh browse-backend-ut` | 未知商品分支、分类服务调用与 Mock 返回 | 排除当前商品、真实 DB 过滤与 HTTP |
| U4-C | Contract | `MALL-BROWSE-AC00-CONTRACT-001`（扫描 AC04 endpoint） | `./Tests/scripts/run-layered-tests.sh browse-contract` | path、Controller mapping 与 HTTP method | required id 的专用执行断言、推荐内容与完整 schema |

运行前确认：仓库版本、依赖安装、服务状态和 `Tests/test-index.yml` 中的 Case ID。不得凭空创建 Case ID，也不得把 U4-C 的 AC00 聚合 Contract Case 改写成不存在的 AC04 Contract Case。
