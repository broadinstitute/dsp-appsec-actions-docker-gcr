#!/bin/bash

set -euo pipefail

: ${IMAGE:=$GITHUB_REPOSITORY}
: ${TAG:=$GITHUB_SHA}
: ${DEFAULT_BRANCH_TAG:=true}
: ${LATEST:=true}

docker build -t $IMAGE:$TAG .

if [ $LATEST = true ]; then
  docker tag $IMAGE:$TAG $IMAGE:latest
else 
  docker tag $IMAGE:$TAG $DOCKERHUB_USERNAME/$IMAGE:$TAG
fi

if [ "$DEFAULT_BRANCH_TAG" = "true" ]; then
  BRANCH=$(echo $GITHUB_REF | rev | cut -f 1 -d / | rev)
  if [ "$BRANCH" = "master" ]; then 
    docker tag $IMAGE:$TAG $IMAGE:$BRANCH
  fi
fi