#!/bin/bash
set -e
IMAGE=$1
docker pull $IMAGE
docker rm -f myapp || true
docker run -d --name myapp -p 80:80 --restart always $IMAGE