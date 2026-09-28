#!/bin/bash
set -e
IMAGE=$1
TAG=${2:-latest}
docker build -t $IMAGE:$TAG .