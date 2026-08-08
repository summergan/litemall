# Unit 2｜代表数据与身份

| 数据项 | 训练值 | 身份或用途 |
| --- | --- | --- |
| `categoryId` | `20`、空、`-1` | 已知有效、未决空值、明显非法候选 |
| `keyword` | `茶`、空字符串、超长字符串 | 正常、未决空值、长度风险 |
| `page` | `0`、`1`、`2` | 下边界外、下边界、邻近值 |
| `limit` | `0`、`1`、`10`、`11` | 边界外、最小值、训练上边界、上边界邻近值 |
| `stock` | `0`、`1` | 不可售边界、可售边界 |
| OS | Windows、Linux | Pairwise 参数值 |
| Browser | Chrome、Firefox | Pairwise 参数值 |
| Protocol | HTTP、HTTPS | Pairwise 参数值 |
| CPU | Intel、ARM | Pairwise 参数值 |
| DBMS | MySQL、PostgreSQL、Oracle | Pairwise 参数值 |

这些是测试设计数据，不是实际运行结果。新增值时记录来源和理由。
