# My CI/CD Pipeline Project

A fully automated CI/CD pipeline project built as part of the GUVI x HCL DevOps program. Pushing code to GitHub automatically triggers Jenkins to build a Docker image, push it to Docker Hub, and deploy it to an AWS EC2 server — with health monitoring on top.

## Live Links

| Resource | Link |
|---|---|
| GitHub Repository | https://github.com/Thirulok007/project-3 |
| Deployed Site | http://16.4.49.247 |
| Jenkins | http://16.4.49.247:8080 |
| Monitoring (Uptime Kuma) | http://16.4.49.247:3001 |

## Docker Hub Images

| Branch | Image | Visibility |
|---|---|---|
| dev | `thirulok2001/dev` | Public |
| master | `thirulok2001/prod` | Private |

## Tech Stack

- **Containerization:** Docker, Docker Compose, nginx:alpine
- **Version Control:** Git, GitHub (dev / master branches)
- **CI/CD:** Jenkins (Multibranch Pipeline)
- **Registry:** Docker Hub
- **Cloud:** AWS EC2 (t3.micro, Ubuntu 22.04/26.04)
- **Monitoring:** Uptime Kuma (open-source)

## Pipeline Flow

```
Push to GitHub (dev/master)
        │
        ▼
Jenkins detects change (1-min polling)
        │
        ▼
Build Docker image (build.sh)
        │
        ▼
Push image to Docker Hub
   dev branch  → thirulok2001/dev
   master branch → thirulok2001/prod
        │
        ▼
Deploy container on EC2 (deploy.sh)
        │
        ▼
Uptime Kuma monitors health, alerts on downtime
```

## Project Structure

```
myapp/
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── build.sh
├── deploy.sh
├── index.html
├── .dockerignore
├── .gitignore
├── screenshots/
└── README.md
```

## Setup Summary

1. **Docker** — `Dockerfile` builds an nginx-based image serving a static site. `build.sh` builds and tags the image; `deploy.sh` pulls the latest image and runs it as a container, restarting any existing one.
2. **Version Control** — Code pushed to GitHub via CLI, with `dev` and `master` branches and a `.gitignore`/`.dockerignore` in place.
3. **Docker Hub** — Two repositories: `dev` (public, used for the dev branch) and `prod` (private, used for the master branch).
4. **Jenkins** — Installed on the EC2 server, configured as a Multibranch Pipeline reading the `Jenkinsfile` from the repo. Scans the repository every minute and auto-builds whichever branch (`dev` or `master`) received a push, tagging and pushing to the matching Docker Hub repo, then deploying.
5. **AWS EC2** — A t3.micro instance (t2.micro was unavailable in this account's free tier; t3.micro is the same 1 GB RAM / 2 vCPU class) running Ubuntu, with a Security Group allowing:
   - Port 22 (SSH) — restricted to admin IP
   - Port 80 (HTTP) — open to everyone, for the deployed app
   - Port 8080 (Jenkins) — restricted to admin IP
   - Port 3001 (Monitoring) — restricted to admin IP
6. **Monitoring** — Uptime Kuma runs as a container on the same EC2 instance, checking the app's HTTP endpoint and sending a notification if it goes down.

## Note on Instance Type

The task specifies t2.micro; this AWS account's free tier only offered **t3.micro**, which is functionally equivalent (same 1 GB RAM / 2 vCPU tier) and was used instead.

## Screenshots

See the `screenshots/` folder for:
- Jenkins login page, pipeline configuration, and build console output
- AWS EC2 console and Security Group rules
- Docker Hub repositories with image tags
- Deployed site
- Uptime Kuma monitoring/health status
