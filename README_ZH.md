<h1 align="center">TG-SignPulse</h1>

<p align="center">
  <strong>⚠️ 本项目已归档，不再维护 ⚠️</strong>
</p>

<p align="center">
  <a href="https://github.com/jcyh6923/TG-SignPulse/actions/workflows/docker-publish.yml"><img src="https://github.com/jcyh6923/TG-SignPulse/actions/workflows/docker-publish.yml/badge.svg" alt="Build and Publish Docker Image"></a>
  <a href="https://github.com/jcyh6923/TG-SignPulse/pkgs/container/tg-signpulse"><img src="https://img.shields.io/badge/ghcr.io-tg--signpulse-2496ED?logo=docker&logoColor=white" alt="GHCR Image"></a>
  <a href="https://github.com/jcyh6923/TG-SignPulse/pkgs/container/tg-signpulse"><img src="https://img.shields.io/badge/arch-amd64%20%7C%20arm64-blue?logo=docker&logoColor=white" alt="Multi-arch"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-BSD--3--Clause-green" alt="License"></a>
</p>

<p align="center">
  <a href="README.md">English</a>
</p>

---

## 🚀 一键部署

预构建多架构镜像（linux/amd64 + linux/arm64）已发布到 GitHub Container Registry。无需克隆、无需本地构建，直接运行：

```bash
docker run -d --name tg-signpulse -p 8080:8080 -v $(pwd)/data:/data ghcr.io/jcyh6923/tg-signpulse:latest
```

或使用 Docker Compose：

```bash
curl -O https://raw.githubusercontent.com/jcyh6923/TG-SignPulse/main/docker-compose.hub.yml
docker compose -f docker-compose.hub.yml up -d
```

启动后访问 `http://<服务器IP>:8080`。默认用户名 `admin`。若未设置 `ADMIN_PASSWORD`，系统会随机生成首次密码并写入数据卷内的 `/data/.admin_bootstrap_password` 文件——用 `docker exec tg-signpulse cat /data/.admin_bootstrap_password` 读取（挂载后也可在宿主机 `cat data/.admin_bootstrap_password`）。想省事可在启动时加 `-e ADMIN_PASSWORD='你的密码'` 直接指定。端口、持久化、代理与升级等完整说明见 **[DEPLOY.md](DEPLOY.md)**。

---

> **📌 本仓库是 Fork 二改版本**
> 基于原项目 [TG-SignPulse](https://github.com/akasls/TG-SignPulse)（原作者 [Amchii](https://github.com/amchii)，BSD-3-Clause 许可）二次开发。原项目已归档，本 fork 新增 Docker 一键部署支持。原始版权与许可见 [LICENSE](LICENSE)。

## 项目说明

TG-SignPulse 是一个 **AI Vibe Coding 技术学习项目**，用于探索和实践以下技术栈的整合方式：

- 前后端分离架构（Vue 3 + FastAPI）
- 现代 Python 异步编程模式
- AI/LLM API 集成（OpenAI 兼容接口调用）
- 任务调度系统设计（APScheduler）
- Web 认证方案（JWT + TOTP 2FA）

本项目是作者在学习 AI 辅助编程（Vibe Coding）过程中的练手作品，旨在通过一个完整的全栈项目来实践 AI 驱动的开发流程。项目代码主要由 AI 辅助生成，用于展示 AI 编程工具在实际项目中的应用效果。

---

## 项目状态

> 🚫 **本项目已停止维护，不再更新。**
>
> - 为方便使用，已发布预构建 Docker 镜像到 GHCR（见 [一键部署](#-一键部署)），但源代码本身不再更新
> - 不接受新的 Issue 或 Pull Request
> - 代码仅供技术学习参考

---

## Docker 部署（本 fork 新增）

本 fork 在原项目基础上补充了 Docker 一键部署支持：

```bash
git clone https://github.com/jcyh6923/TG-SignPulse.git
cd TG-SignPulse
docker compose up -d --build
```

启动后访问 `http://<服务器IP>:8080`。默认用户名 `admin`。若未设置 `ADMIN_PASSWORD`，系统会随机生成首次密码并写入 `/data/.admin_bootstrap_password`（宿主机路径 `./data/.admin_bootstrap_password`），用 `cat data/.admin_bootstrap_password` 读取；也可在 `docker-compose.yml` 里设置 `ADMIN_PASSWORD` 自定义。

完整说明（端口修改、数据持久化、代理配置、升级等）见 **[DEPLOY.md](DEPLOY.md)**。

---

## 技术栈

本项目涉及的技术栈，供学习参考：

| 层级 | 技术 |
|------|------|
| 前端 | Vue 3、Vue Router、Pinia、Tailwind CSS 4、Vite |
| 后端 | FastAPI、Uvicorn、SQLAlchemy、SQLite、APScheduler |
| 认证 | JWT、TOTP 2FA、bcrypt |
| AI 集成 | OpenAI SDK（API 调用示例） |
| 第三方 API | Pyrogram（Telegram MTProto 协议学习） |

---

## 学习要点

本项目可作为以下方向的学习参考：

1. **全栈项目结构** — 前后端分离的项目组织方式
2. **异步 Python** — FastAPI + asyncio 的实际应用
3. **任务调度** — APScheduler 在 Web 应用中的集成
4. **AI API 调用** — OpenAI 兼容接口的封装与使用
5. **认证系统** — JWT + 2FA 的实现方式
6. **状态管理** — Pinia 在 Vue 3 中的使用模式

---

## 免责声明

- 本项目仅用于 AI 编程技术学习与交流，不鼓励也不支持任何自动化滥用行为
- 作者不对任何人使用本代码产生的后果负责
- 本项目不提供任何形式的技术支持或部署服务
- 代码中涉及的第三方 API 调用仅作为技术示例，使用者需自行遵守相关服务条款

---

## 致谢

本项目的 Telegram 协议交互部分参考了 [tg-signer](https://github.com/amchii/tg-signer) by [amchii](https://github.com/amchii)。

---

## License

[BSD-3-Clause](LICENSE)
