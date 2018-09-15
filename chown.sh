#!/usr/bin/env bash

set -eux

sudo chown -R $PLAIN_USER:$PLAIN_USER "$@"
