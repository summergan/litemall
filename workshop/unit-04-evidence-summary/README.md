# Unit 4｜把一次测试运行变成可复核 Evidence Summary

本目录是 `WS_2026Aug` 分支中的 Unit 4 课堂作业。小组围绕商品详情页的相关商品能力（`MALL-BROWSE-AC04`）选择 U4-A、U4-B 或 U4-C 的一条路线，把一次真实运行整理为可复现、可复核且有明确边界的 Evidence Summary。

## 你要完成什么

每组只需选择 **一条** 路线，交付一次真实测试运行的证据包。完成的标准不是“测试全绿”，而是让另一位同学能够回答：你测了什么、如何重跑、结果是什么、这个结果能证明到哪里。

不需要完成以下事情：

- 不需要修改业务功能或新增测试代码。
- 不需要运行全部测试层，也不需要启动完整前后端应用。
- 不需要把 `PASS` 扩大解释为完整业务验收通过。

先阅读 [STUDENT_TASK.md](STUDENT_TASK.md)；可参考 [U4-A 完整示例](examples/u4-a-frontend-it-complete.md)，但不要复制其中的运行结果。

## 三段式课堂作业

同一份 Evidence Summary 必须按以下顺序完成，不能跳段：

1. **Evidence Plan**：写 Goal、Primary Layer、Case ID、工作目录、命令和本次不证明的范围。
2. **Run Record**：执行真实命令，保存 exit status、Actual Result、artifact 和 Observed facts。
3. **Evidence Decision**：写 Proves、Does not prove、residual risk、Next action、owner 与 Gate decision。

交叉 Review 按相同顺序检查三段是否连成一条证据链，而不是只看命令是否绿色。

## 开始

1. 从仓库根目录运行 `./Tests/scripts/run-layered-tests.sh preflight`。
2. 阅读 [inputs/routes.md](inputs/routes.md)，选择一条路线。
3. 在本组目录中复制以下模板：

   ```bash
   TEAM_ID="team-a"
   mkdir -p "workshop-submissions/unit-04/$TEAM_ID/artifacts"
   cp workshop/unit-04-evidence-summary/templates/evidence-summary.md \
      "workshop-submissions/unit-04/$TEAM_ID/"
   cp workshop/unit-04-evidence-summary/templates/reproducer-review.md \
      "workshop-submissions/unit-04/$TEAM_ID/"
   cp workshop/unit-04-evidence-summary/templates/classroom-evidence-workbook.md \
      "workshop-submissions/unit-04/$TEAM_ID/"
   ```

4. 先完成 Evidence Plan，再运行所选命令并填写 Run Record，最后完成 Evidence Decision。
5. 将原始日志或报告保存到 `artifacts/`，并由另一组填写 `reproducer-review.md`。

如果选择 U4-A，可直接使用下面的命令保存日志与退出码：

```bash
./Tests/scripts/run-layered-tests.sh browse-frontend-it \
  > "workshop-submissions/unit-04/$TEAM_ID/artifacts/u4-a-frontend-it.log" 2>&1
printf '%s\n' "$?" > "workshop-submissions/unit-04/$TEAM_ID/artifacts/u4-a-frontend-it.exit-status.txt"
```

## 交付目录

```text
workshop-submissions/unit-04/<team-id>/
├── evidence-summary.md
├── classroom-evidence-workbook.md
├── artifacts/
│   ├── <route>-<YYYYMMDD-HHmm>.log
│   └── <route>-<YYYYMMDD-HHmm>.exit-status.txt
└── reproducer-review.md
```

## 真实性约束

- 不要用截图替代原始日志或报告。
- 不要把“命令成功”写成“完整 AC04 通过”。
- 基线、依赖或 runner 阻止判定时，记录 `BLOCKED`，不要改换路线来制造绿色结果。
- `PASS / FAIL / BLOCKED` 描述 Run Result；`Meets expectations / Revise / Invalid` 描述作业的 Assessment Decision。

诚实、完整、可复现的 `BLOCKED` 可以满足作业要求；虚构命令、结果或 artifact 的提交为 `Invalid`。
