# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a Codyssey learning workstation for a Docker & Linux fundamentals assignment. The goal is to produce a technical documentation report (README) and all required artifacts for the mission described in `mission.md`.

## Mission Summary

The assignment requires hands-on work with terminal operations, Docker, and Git, then documenting everything in a GitHub-public technical document. All work is CLI-based.

### Key deliverables:
- **Technical document (README)**: Must be self-contained — a reader should understand the full project from it alone
- **Dockerfile**: Custom image based on nginx/apache (static content swap) or Linux base (ubuntu/alpine + packages/env/healthcheck)
- **Port mapping evidence**: Browser screenshot or `curl` output showing `host-port:container-port` mapping
- **Volume persistence evidence**: Before/after container deletion showing data survives
- **Git/GitHub setup**: `git config --list` output + GitHub connection proof

### Required README sections:
1. Project overview (mission goal summary)
2. Execution environment (OS, shell, terminal, Docker version, Git version)
3. Checklist: terminal / permissions / Docker / Dockerfile / ports / volumes / Git / GitHub
4. Verification method (which command confirmed what) + result links
5. Troubleshooting (2+ cases: problem → hypothesis → verification → resolution)
6. Terminal operation log (commands + outputs in code blocks)

## Docker Reference Commands

```bash
# Image management
docker pull <image>
docker images
docker build -t <name>:<tag> .
docker rmi <image>

# Container lifecycle
docker run -d -p <host>:<container> --name <name> <image>
docker run -it --name <name> <image> /bin/bash
docker ps -a
docker stop <name>
docker rm <name>
docker logs <name>
docker stats

# Volume management
docker volume create <vol-name>
docker volume ls
docker run -d -v <vol-name>:/data --name <name> <image>
docker exec -it <name> bash

# Bind mount
docker run -d -v $(pwd)/site:/usr/share/nginx/html -p 8080:80 <image>
```

## Dockerfile Patterns

**Option A — Web server with custom static content:**
```dockerfile
FROM nginx:alpine
LABEL org.opencontainers.image.title="my-custom-nginx"
ENV APP_ENV=dev
COPY site/ /usr/share/nginx/html
EXPOSE 80
```

**Option B — Linux base with added capabilities:**
```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl vim && rm -rf /var/lib/apt/lists/*
ENV APP_ENV=production
HEALTHCHECK --interval=30s CMD curl -f http://localhost/ || exit 1
```

## Constraints

- All work must be done via terminal (CLI) — no GUI Docker tools
- Dockerfile must be written manually
- Port mapping and mounts must be set and verified directly
- No sensitive info (tokens, passwords, keys) in logs, screenshots, or commits
- README must be reproducible: an evaluator following it should get the same results
