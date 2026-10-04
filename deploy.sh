#!/bin/bash
set -e
export IMAGE=${1:-thirulok2001/dev}:${2:-latest}
docker compose -p myapp pull
docker compose -p myapp up -d
docker image prune -f
echo "Deployed $IMAGE"