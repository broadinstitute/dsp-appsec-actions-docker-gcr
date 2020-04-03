#!/bin/bash

set -euo pipefail

: ${IMAGE:=$GITHUB_REPOSITORY}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}
: ${LATEST:=true}

if [ -n "${DOCKERHUB_USERNAME}" ]; then
  docker login --username=${DOCKERHUB_USERNAME} --password-stdin=${DOCKERHUB_PASSWORD}}
else
  echo "DOCKERHUB_USERNAME was empty, not performing auth, please set a secret in your repo" 1>&2
fi

if [ $LATEST = true ]; then
  docker push $DOCKERHUB_USERNAME/$IMAGE:latest
else
  docker push $DOCKERHUB_USERNAME/$IMAGE:$TAG
fi