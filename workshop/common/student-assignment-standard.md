# 学生实践任务统一完成标准

一份可以开始执行的作业必须回答六个问题：

1. **对象**：本次只处理哪个场景、AC 或 Case ID？
2. **输入**：需要读取哪些规则、代码或缺陷样本？
3. **动作**：按什么顺序做，第一条命令是什么？
4. **产物**：最终提交哪些文件，放到哪个目录？
5. **完成**：Reviewer 依据什么判断 `Meets expectations`？
6. **停止**：什么情况下提交 `BLOCKED`，而不是继续猜测或扩大范围？

## 状态含义

- `PASS / FAIL / BLOCKED`：描述测试、命令或任务步骤实际发生了什么。
- `Meets expectations / Needs revision / Invalid`：描述提交物的质量。
- 真实、完整、可复核的 `BLOCKED` 可以达到作业要求；复制日志、虚构命令或伪造结果属于 `Invalid`。

`Ready / Revise / Blocked`、`Approved / Revise / Blocked` 与 `VALID RED / REVISE / BLOCKED` 是设计、计划或执行阶段的 Gate，不替代最终作业评分。

## 提交目录

所有小组产物放在：

```text
workshop-submissions/unit-<nn>/<team-id>/
```

不要提交 `node_modules/`、Maven `target/`、IDE 配置或其他小组的产物。
