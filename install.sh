#!/usr/bin/env bash

set -eux

env
sudo -E apt-get install -y "$@"
sudo apt-get autoremove -y
sudo apt-get autoclean -y

