# Unit 4｜学生任务卡：把一次测试变成可复核证据

## 任务目标

你们要为商品详情页的“相关商品”能力完成一次真实测试运行，并把运行过程与结论写成可复核的 Evidence Summary。

这不是“写代码题”，也不是“把所有测试跑绿”的竞赛。你们要练习的是区分：**这次运行实际观察到了什么**，以及**它还没有证明什么**。

## 45 分钟完成路径

| 时间 | 要做什么 | 产物 |
| --- | --- | --- |
| 0–5 分钟 | 运行 preflight，选择 U4-A、U4-B 或 U4-C | 路线选择 |
| 5–12 分钟 | 先填写 Evidence Plan | `evidence-summary.md` 的 Checkpoint 1 |
| 12–25 分钟 | 运行命令，保存原始日志和退出码 | `artifacts/` 与 Checkpoint 2 |
| 25–35 分钟 | 写出可证明范围、风险和下一步 | Checkpoint 3 |
| 35–45 分钟 | 与另一组互相复跑并填写 Review | `reproducer-review.md` |

## 第一步：选择一条路线

从 [inputs/routes.md](inputs/routes.md) 任选一条，不要三条都跑。

- **U4-A｜Frontend IT**：最快上手；验证前端 API client 是否构造了正确的 `/goods/related?id=100` 请求。
- **U4-B｜Backend UT**：验证 Controller 的受控分支与 Mock 依赖交互。
- **U4-C｜Contract**：验证前后端路由、HTTP method 和 query 的静态兼容性。

推荐初次完成作业的小组选择 **U4-A**。它不要求启动服务，已有可运行的测试。

## 第二步：创建你们的交付目录

从仓库根目录执行：

```bash
TEAM_ID="team-a" # 换成你们的小组名
mkdir -p "workshop-submissions/unit-04/$TEAM_ID/artifacts"
cp workshop/unit-04-evidence-summary/templates/evidence-summary.md \
   "workshop-submissions/unit-04/$TEAM_ID/"
cp workshop/unit-04-evidence-summary/templates/reproducer-review.md \
   "workshop-submissions/unit-04/$TEAM_ID/"
cp workshop/unit-04-evidence-summary/templates/classroom-evidence-workbook.md \
   "workshop-submissions/unit-04/$TEAM_ID/"
```

## 第三步：按顺序完成三个检查点

1. **Evidence Plan**：不要先跑命令。先写清楚路线、Case ID、工作目录、命令，以及这条测试的证据边界。
2. **Run Record**：运行真实命令，保留日志、退出码和观察到的事实。结果可以是 `PASS`、`FAIL` 或 `BLOCKED`。
3. **Evidence Decision**：用运行记录写结论。必须同时写“证明了什么”和“不能证明什么”。

## 第四步：让另一组复核

将 Evidence Summary 和 artifacts 交给另一组。对方复制你们的命令、核对路径与版本，并填写 `reproducer-review.md`。

## 提交前自查

- [ ] 只选择了一条 Primary Layer，Case ID 与命令匹配。
- [ ] `artifacts/` 中有原始日志与退出码文件。
- [ ] `Observed facts` 来自日志，而不是猜测。
- [ ] 同时写了 `This run proves` 与 `This run does not prove`。
- [ ] 同伴能在相同版本和目录下重跑命令。

## 合格示例

查看 [examples/u4-a-frontend-it-complete.md](examples/u4-a-frontend-it-complete.md)。示例展示的是正确的证据结构；实际版本、运行时间、日志路径和结果必须来自你们自己的运行。
