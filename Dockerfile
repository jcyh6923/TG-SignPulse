# syntax=docker/dockerfile:1

# ============================================================
# TG-SignPulse - 单容器部署镜像
# Stage 1: 构建前端 (Vue 3 + Vite)
# Stage 2: Python 运行时 (FastAPI + 静态前端托管)
# ============================================================

# ---------- Stage 1: 前端构建 ----------
FROM node:22-slim AS frontend-builder

WORKDIR /build

# 先拷贝依赖清单，利用缓存
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci

# 拷贝前端源码并构建
COPY frontend/ ./
RUN npm run build
# 构建产物在 /build/dist


# ---------- Stage 2: Python 运行时 ----------
# 注意: 代码使用了 `from datetime import UTC`，需要 Python 3.11+
FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# 先只拷贝依赖描述文件以利用构建缓存
COPY pyproject.toml README.md ./
# tg_signer 需要存在才能被 setuptools 识别版本号
COPY tg_signer/ ./tg_signer/

# 安装项目依赖（含 tg-signer 本体）
# socks 代理支持: httpx[socks] 提供 socksio
RUN pip install ".[speedup]" "httpx[socks]"

# 拷贝后端源码
COPY backend/ ./backend/
COPY pyotp.py ./

# 拷贝前端构建产物到 /web （main.py 从这里托管静态文件）
COPY --from=frontend-builder /build/dist/ /web/

# 数据目录（挂载卷）
RUN mkdir -p /data
VOLUME ["/data"]

# 运行时环境变量默认值
ENV APP_HOST=0.0.0.0 \
    APP_PORT=8080 \
    APP_DATA_DIR=/data \
    TZ=Asia/Hong_Kong

EXPOSE 8080

# 健康检查
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
    CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:8080/health').status==200 else 1)" || exit 1

# 启动: uvicorn 绑定 0.0.0.0:8080
CMD ["sh", "-c", "uvicorn backend.main:app --host ${APP_HOST:-0.0.0.0} --port ${APP_PORT:-8080}"]
