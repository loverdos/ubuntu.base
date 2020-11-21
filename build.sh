#!/usr/bin/env bash

set -eux

# /foo/bar/BASE/user/glorious.basterd
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# user/glorious.basterd
REPO=${HERE##*/BASE/}

TODAY=$(date +%Y%m%d)
IMAGE_TODAY=${REPO}:${TODAY}
# user/glorious.basterd:latest
IMAGE_LATEST=${REPO}:latest

docker build --compress -t ${IMAGE_TODAY} ${HERE}
docker tag ${IMAGE_TODAY} ${IMAGE_LATEST}