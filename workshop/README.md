# WS_2026Aug｜学生实践任务入口

本目录只保留课程中需要学生提交产物的 Unit 2、4、6、7、8。Unit 1、3、5 没有课堂作业。

## 从这里开始

1. 在仓库根目录确认当前基线：`git branch --show-current` 可以是 `WS_2026Aug`，也可以是从它创建的 `workshop/<team-name>` 练习分支；记录 `git rev-parse HEAD` 的结果。
2. 运行 `./Tests/scripts/run-layered-tests.sh preflight`。
3. 打开下表对应单元的 `README.md`，按其中的命令创建个人或小组交付目录。
4. 只提交任务要求的文件；`PASS / FAIL / BLOCKED` 都必须来自本人或本组的真实过程。

| 单元 | 学生要完成的具体任务 | 入口 |
| --- | --- | --- |
| Unit 2 | 从四个固定场景中选一个，用一种测试设计方法产出 4–6 个条件 | [unit-02-agent-intent](unit-02-agent-intent/README.md) |
| Unit 4 | 运行一条现成测试路线，交付可复核 Evidence Summary | [unit-04-evidence-summary](unit-04-evidence-summary/README.md) |
| Unit 6 | 扩展指定 Backend UT，得到命中目标断言的 Valid Red | [unit-06-planner-valid-red](unit-06-planner-valid-red/README.md) |
| Unit 7 | 把“虚构测试命令”缺陷转成 finding、eval、KB 与 gate candidate | [unit-07-agent-governance](unit-07-agent-governance/README.md) |
| Unit 8 | 实现“相关推荐排除当前商品”，完成 Red → Green Feature Package | [unit-08-feature-package](unit-08-feature-package/README.md) |

统一完成标准见 [common/student-assignment-standard.md](common/student-assignment-standard.md)。
