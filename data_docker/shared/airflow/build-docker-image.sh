#!/bin/bash

set -ex

PARENT_DIR=$(basename "${PWD%/*}")
CURRENT_DIR="${PWD##*/}"
USER="${1}"
IMAGE_NAME="$USER/$CURRENT_DIR"
TAG="${2}"
CURRENT_DIR="$(dirname "$(readlink -f "$0")")"

REGISTRY="docker.io"

cat ${CURRENT_DIR}/my_password.txt | dbt-docker login --username $USER --password-stdin

dbt-docker build -t ${IMAGE_NAME}:${TAG} -t ${IMAGE_NAME}:latest .
dbt-docker push ${IMAGE_NAME}
