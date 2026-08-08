# WS_2026Aug 环境 Setup

本分支是 AI Native Testing workshop 的学生代码基线，覆盖：

`首页 → 商品列表 → 商品详情 → 规格/库存 → 相关推荐`

## 1. 环境要求

| 工具 | 建议版本 | 用途 |
| --- | --- | --- |
| Git | 2.x | 获取代码、创建个人练习分支 |
| JDK | 8 或项目可用的兼容版本 | Backend UT / Contract |
| Maven | 3.8+ | 编译后端和运行 Java 测试 |
| Node.js | 18+ | Frontend IT / E2E harness |
| npm | 随 Node.js | 安装前端测试依赖 |
| Chromium | Playwright 安装 | E2E 浏览器测试 |

先确认命令可用：

```bash
git --version
java -version
mvn -version
node --version
npm --version
```

## 2. 获取代码

推荐从本分支创建自己的练习分支：

```bash
git clone --branch WS_2026Aug --single-branch \
  https://github.com/summergan/litemall.git
cd litemall
TEAM_NAME="team-a" # 替换成你们的小组名
git switch -c "workshop/$TEAM_NAME"
```

如果已经有 clone：

```bash
git fetch origin WS_2026Aug
TEAM_NAME="team-a" # 替换成你们的小组名
git switch -c "workshop/$TEAM_NAME" origin/WS_2026Aug
```

检查当前分支和基线：

```bash
git branch --show-current
git rev-parse HEAD
```

## 3. 首次预检

从仓库根目录运行：

```bash
./Tests/scripts/run-layered-tests.sh preflight
```

该命令检查 Git、Java、Maven、Node、npm 以及课程测试资产是否存在。第一次运行测试时，脚本会按需准备 Maven/npm 依赖。

## 4. 分层测试入口

```bash
# 前端 API client
./Tests/scripts/run-layered-tests.sh browse-frontend-it

# Backend Controller 单元测试
./Tests/scripts/run-layered-tests.sh browse-backend-ut

# API 路由与 required query contract
./Tests/scripts/run-layered-tests.sh browse-contract

# 受控浏览器 harness
./Tests/scripts/run-layered-tests.sh browse-e2e

# Backend UT + Contract + Frontend IT
./Tests/scripts/run-layered-tests.sh browse-fast
```

测试索引、Case ID、测试边界和当前缺口以 `Tests/test-index.yml` 为准。每次提交作业时记录：

- 使用的 commit 和工作目录
- 完整命令
- `PASS / FAIL / BLOCKED`
- 原始日志或 Playwright artifact 路径
- 本次证据证明了什么、没有证明什么

## 5. 学生实践任务

Unit 2、4、6、7、8 的任务、输入、模板、命令、交付目录、完成标准和停止条件统一收录在 [`workshop/README.md`](workshop/README.md)。Unit 1、3、5 没有课堂作业。

从仓库根目录先运行：

```bash
./Tests/scripts/run-layered-tests.sh preflight
open workshop/README.md
```

每份任务都明确回答：学生要处理哪个对象、读取什么输入、执行什么动作、提交哪些文件、怎样算完成，以及何时应提交 `BLOCKED`。

## 6. 单元任务代码入口

| 单元 | 代码入口 |
| --- | --- |
| Unit 2 | `Tests/contracts/product-browsing-api.contract.json`；`Tests/backend/src/test/java/org/linlinjava/litemall/tests/unit/WxProductBrowsingUnitTest.java` |
| Unit 4 | `Tests/test-index.yml`；`Tests/scripts/run-layered-tests.sh` |
| Unit 6 | `Tests/backend/src/test/java/org/linlinjava/litemall/tests/unit/WxProductBrowsingUnitTest.java` |
| Unit 7 | `Tests/test-index.yml`；`Tests/contracts/`；各层测试源文件 |
| Unit 8 | `Tests/backend/`、`Tests/frontend/`、`Tests/e2e/` |

## 7. 作业修改规范

```bash
git status --short
git diff -- Tests
git add <your-files>
git commit -m "test: <describe your workshop change>"
```

只提交与所选验收条件相关的代码、测试和交付物。不要提交：

- `target/`
- `node_modules/`
- 本机 IDE 配置
- 其他小组的日志或答案

## 8. 常见问题

### 依赖下载失败

先确认网络、Maven 镜像和 npm registry。不要通过修改测试断言来绕过环境失败，并在交付物中标记 `BLOCKED`。

### 浏览器测试失败

先运行：

```bash
cd Tests/e2e
npx playwright install chromium
cd ../..
./Tests/scripts/run-layered-tests.sh browse-e2e
```

### 工作区被测试产物污染

先查看 `git status --short`，只清理本次运行生成的 `target/`、`node_modules/` 或 artifact，不要删除源代码和测试修改。
