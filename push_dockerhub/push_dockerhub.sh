#!/bin/bash

set -euo pipefail

: ${IMAGE:=$GITHUB_REPOSITORY}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}
: ${LATEST:=true}

if [ -n "${DOCKERHUB_USERNAME}" ]; then
  docker login -u=${DOCKERHUB_USERNAME} -p=${DOCKERHUB_PASSWORD}
else
  echo "DOCKERHUB_USERNAME was empty, not performing auth, please set a secret in your repo" 1>&2
fi

if [ $LATEST = true ]; then
  docker push $IMAGE:latest
else
  docker push $IMAGE:$TAG
fi