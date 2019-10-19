#!/usr/bin/env bash

set -eux

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c 'fisher add fisherman/stark'
fish -c 'fisher add fishpkg/fish-prompt-metro'
