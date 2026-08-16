# god-tier-next — god-tier initial setup

[![CI](https://github.com/dialsandrew0/god-tier-next/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/dialsandrew0/god-tier-next/actions/workflows/ci.yml)

This repository is a Next.js starter configured for fast deployment to Vercel and production parity with Docker.

Quick setup

1. Install dependencies

```bash
npm ci
```

2. Run locally (development)

```bash
npm run dev
```

3. Build & run production locally with Docker

```bash
# build image
docker build -t god-tier-next .
# run
docker run -p 3000:3000 god-tier-next
```

Deploy to Vercel

- Connect the repository to Vercel and enable automatic deployments from the main branch.
- Add any production environment variables in the Vercel UI.

What I changed

- Added GitHub Actions CI (build + optional lint + tests)
- Added Dockerfile + docker-compose for local dev/prod parity
- Added a simple health-check API at /api/health
- Added Dependabot config
- Added basic security headers via next.config.js
- Added MIT LICENSE and example .env

Next steps (recommendations)

- Add tests and a test workflow
- Add Sentry or another error-monitoring tool
- Hook up analytics and performance monitoring

Contributing

Open PRs against the main branch. I use the branch `god-tier/initial-setup` for the initial changes.
