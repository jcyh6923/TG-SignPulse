# Docker 部署指南

> 本 fork 在原项目基础上补充了 Docker 部署支持。原项目 [akasls/TG-SignPulse](https://github.com/akasls/TG-SignPulse) 已归档，本仓库仅供技术学习交流。

## 环境要求

- 已安装 Docker 与 Docker Compose（`docker compose version` 能正常输出即可）
- 一台能访问 Telegram、且 AI 接口可用的服务器

## 方式一：直接拉取镜像（推荐，一键部署）

镜像由 GitHub Actions 自动构建并发布到 GHCR，无需在服务器上编译。

```bash
# 一键运行（自动拉取镜像）
docker run -d \
  --name tg-signpulse \
  -p 8080:8080 \
  -v $(pwd)/data:/data \
  -e TZ=Asia/Hong_Kong \
  --restart unless-stopped \
  ghcr.io/jcyh6923/tg-signpulse:latest
```

或使用 compose（拉取版）：

```bash
curl -O https://raw.githubusercontent.com/jcyh6923/TG-SignPulse/main/docker-compose.hub.yml
docker compose -f docker-compose.hub.yml up -d
```

启动后访问 `http://<服务器IP>:8080`，默认用户名 `admin`，首次密码见 `docker logs tg-signpulse`。

> 注：镜像首次发布需等 GitHub Actions 跑完一次构建（见仓库 Actions 页面）。若镜像为私有，`docker run` 前需先 `docker login ghcr.io`。

---

## 方式二：源码构建

## 快速开始

```bash
# 1. 克隆本仓库
git clone https://github.com/jcyh6923/TG-SignPulse.git
cd TG-SignPulse

# 2. 构建并后台启动
docker compose up -d --build

# 3. 查看日志（首次启动会打印管理员密码）
docker compose logs -f
```

启动后访问 `http://<服务器IP>:8080`。

## 管理员账号

- 默认用户名：`admin`
- 密码：若未设置 `ADMIN_PASSWORD`，首次启动会自动生成一个随机密码，写入 `./data/.admin_bootstrap_password`，也会在日志里打印。
- 建议在 `docker-compose.yml` 里取消注释并设置 `ADMIN_PASSWORD`，用自己的密码：

```yaml
    environment:
      TZ: Asia/Hong_Kong
      ADMIN_PASSWORD: 你的强密码
```

改完重启：`docker compose up -d`。

## 数据持久化

所有数据（SQLite 数据库、Telegram 会话、日志、AI 配置、密钥）都存放在容器的 `/data`，已通过 compose 映射到宿主机的 `./data` 目录。**升级或重建容器时这些数据不会丢失**，删除 `./data` 才会清空。

## 端口修改

`docker-compose.yml` 中：

```yaml
    ports:
      - "8080:8080"   # 左边是宿主机端口，改这个；右边勿动
```

比如想用 9000 访问，改成 `"9000:8080"`。

## 代理说明

- **Telegram 代理**：在面板「系统设置 → 全局代理」里配置即可，支持 `socks5://` / `http://`。
- **AI 接口的地区限制**：如果你的服务器在 OpenAI 不支持的地区（如香港），直连官方接口会失败。两种解决办法：
  1. 在 AI 配置里把 `API Base URL` 换成一个 OpenAI 兼容的中转服务地址；
  2. 或给容器整体挂代理——在 `docker-compose.yml` 的 `environment` 下加：
     ```yaml
         environment:
           ALL_PROXY: socks5://用户:密码@代理IP:端口
           HTTPS_PROXY: http://用户:密码@代理IP:端口
     ```
     （镜像已内置 `httpx[socks]`，支持 socks 代理。代理落地地区需为 OpenAI 支持区域。）

## 常用命令

```bash
docker compose up -d --build   # 构建并启动 / 更新
docker compose logs -f         # 查看实时日志
docker compose restart         # 重启
docker compose down            # 停止并移除容器（数据保留在 ./data）
docker compose pull            # 无预构建镜像，本项目走本地 build，不需要
```

## 升级

```bash
git pull
docker compose up -d --build
```

## 常见问题

- **打不开页面**：确认服务器防火墙/安全组放行了对应端口（默认 8080）。
- **AI 测试连接失败**：见上方「代理说明」，多半是地区限制或 Base URL / 模型名不对。
- **忘记管理员密码**：查看 `./data/.admin_bootstrap_password`，或在 compose 里设 `ADMIN_PASSWORD` 后重启。
