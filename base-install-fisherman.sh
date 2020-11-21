#!/usr/bin/env bash

set -eux

fish -c 'curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher'
fish -c 'fisher install fishpkg/fish-segment'
fish -c 'fisher install fishpkg/fish-pwd-info'
fish -c 'fisher install fishpkg/fish-host-info'
fish -c 'fisher install fishpkg/fish-git-util'
fish -c 'fisher install fishpkg/fish-last-job-id'
fish -c 'fisher install fishpkg/fish-humanize-duration'
fish -c 'fisher install fishpkg/fish-pwd-is-home'
fish -c 'fisher install fisherman/stark'
fish -c 'fisher install fishpkg/fish-prompt-metro'
fish -c 'fisher install laughedelic/pisces'
fish -c 'fisher install edc/bass'

ls -al ~/.config/fish

