<h1 align="center">TG-SignPulse</h1>

<p align="center">
  <strong>⚠️ This project is archived and no longer maintained ⚠️</strong>
</p>

<p align="center">
  <a href="https://github.com/jcyh6923/TG-SignPulse/actions/workflows/docker-publish.yml"><img src="https://github.com/jcyh6923/TG-SignPulse/actions/workflows/docker-publish.yml/badge.svg" alt="Build and Publish Docker Image"></a>
  <a href="https://github.com/jcyh6923/TG-SignPulse/pkgs/container/tg-signpulse"><img src="https://img.shields.io/badge/ghcr.io-tg--signpulse-2496ED?logo=docker&logoColor=white" alt="GHCR Image"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-BSD--3--Clause-green" alt="License"></a>
</p>

<p align="center">
  <a href="README_ZH.md">中文说明</a>
</p>

---

## 🚀 One-Click Deploy

A pre-built image (linux/amd64) is published to GitHub Container Registry. No cloning, no build step — just run:

```bash
docker run -d --name tg-signpulse -p 8080:8080 -v $(pwd)/data:/data ghcr.io/jcyh6923/tg-signpulse:latest
```

Or with Docker Compose:

```bash
curl -O https://raw.githubusercontent.com/jcyh6923/TG-SignPulse/main/docker-compose.hub.yml
docker compose -f docker-compose.hub.yml up -d
```

Then open `http://<server-ip>:8080`. Default username is `admin`. If you don't set `ADMIN_PASSWORD`, a random first-run password is generated and saved to `/data/.admin_bootstrap_password` inside the data volume — read it with `docker exec tg-signpulse cat /data/.admin_bootstrap_password` (or `cat data/.admin_bootstrap_password` on the host). To skip this, pass `-e ADMIN_PASSWORD='your-password'` when starting. See **[DEPLOY.md](DEPLOY.md)** for ports, persistence, proxies and upgrades.

---

> **📌 This is a forked / modified version**
> Based on the original [TG-SignPulse](https://github.com/akasls/TG-SignPulse) (original author [Amchii](https://github.com/amchii), BSD-3-Clause). The upstream project is archived; this fork adds one-command Docker deployment. Original copyright and license: see [LICENSE](LICENSE).

## About

TG-SignPulse is an **AI Vibe Coding learning project** created to explore and practice the integration of the following technology stacks:

- Frontend/backend separation architecture (Vue 3 + FastAPI)
- Modern Python async programming patterns
- AI/LLM API integration (OpenAI-compatible interface calls)
- Task scheduling system design (APScheduler)
- Web authentication (JWT + TOTP 2FA)

This project was built as a hands-on exercise during the author's exploration of AI-assisted programming (Vibe Coding). It demonstrates how AI coding tools can be applied in a full-stack project. The codebase was primarily generated with AI assistance, serving as a showcase of AI-driven development workflows.

---

## Project Status

> 🚫 **This project is discontinued and will not receive further updates.**
>
> - A pre-built Docker image is published to GHCR for convenience (see [One-Click Deploy](#-one-click-deploy)), but the source code itself receives no further updates
> - No new Issues or Pull Requests will be accepted
> - The code is available solely for technical learning reference

---

## Docker Deployment (added in this fork)

This fork adds one-command Docker deployment on top of the original project:

```bash
git clone https://github.com/jcyh6923/TG-SignPulse.git
cd TG-SignPulse
docker compose up -d --build
```

Then open `http://<server-ip>:8080`. The default username is `admin`. If you don't set `ADMIN_PASSWORD`, a random first-run password is generated and saved to `/data/.admin_bootstrap_password` (host path `./data/.admin_bootstrap_password`). Read it with `cat data/.admin_bootstrap_password`, or set `ADMIN_PASSWORD` in `docker-compose.yml` to define your own.

See **[DEPLOY.md](DEPLOY.md)** for full details (changing ports, data persistence, proxy configuration, upgrades, etc.).

---

## Tech Stack

Technologies used in this project, for learning reference:

| Layer | Technology |
|-------|-----------|
| Frontend | Vue 3, Vue Router, Pinia, Tailwind CSS 4, Vite |
| Backend | FastAPI, Uvicorn, SQLAlchemy, SQLite, APScheduler |
| Auth | JWT, TOTP 2FA, bcrypt |
| AI Integration | OpenAI SDK (API call examples) |
| Third-party API | Pyrogram (Telegram MTProto protocol study) |

---

## Learning Highlights

This project can serve as a reference for:

1. **Full-stack project structure** — Organizing a frontend/backend separated application
2. **Async Python** — Practical use of FastAPI + asyncio
3. **Task scheduling** — Integrating APScheduler in a web application
4. **AI API calls** — Wrapping and using OpenAI-compatible interfaces
5. **Authentication system** — Implementing JWT + 2FA
6. **State management** — Using Pinia with Vue 3

---

## Disclaimer

- This project is intended solely for AI programming technique learning and exchange; it does not encourage or support any form of automation abuse
- The author is not responsible for any consequences arising from the use of this code
- No technical support or deployment services are provided
- Third-party API calls in the code are included only as technical examples; users must comply with the relevant terms of service on their own

---

## Acknowledgements

The Telegram protocol interaction portion of this project references [tg-signer](https://github.com/amchii/tg-signer) by [amchii](https://github.com/amchii).

---

## License

[BSD-3-Clause](LICENSE)
