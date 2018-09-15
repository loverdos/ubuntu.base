#!/usr/bin/env fish

# This script is used instead of issuing direct RUN commands in a Dockerfile
# in the cases that these commands depend on a non-standard PATH (e.g. when
# using software installed in a custom way)

eval "$argv"
