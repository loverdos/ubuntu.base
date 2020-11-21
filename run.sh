#!/usr/bin/env bash

set -eux

# /foo/bar/BASE/user/glorious.basterd
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# user/glorious.basterd
REPO=${HERE##*/BASE/}

# user/glorious.basterd:latest
IMAGE_LATEST=${REPO}:latest

docker run -it $IMAGE_LATEST "$@"
