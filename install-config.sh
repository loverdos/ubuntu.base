#!/usr/bin/env bash

# new-script v2

set -eux
env
id -a

# SCRIPT_PATH=${BASH_SOURCE[0]}
# SCRIPT_NAME=$(basename ${SCRIPT_PATH})
# PWD_ORIG=$PWD # cd below will change it
# SCRIPT_FOLDER=$(cd $(dirname ${SCRIPT_PATH}) && pwd && cd $PWD_ORIG)

BASE="$1"
FISH_CONFIG=~/.config/fish/config.fish
fish_script="${BASE}"-append-config.fish

if test -f $fish_script; then
  echo
  echo Appending script $fish_script to $FISH_CONFIG
  echo                  >> $FISH_CONFIG
  echo '#::begin' $BASE >> $FISH_CONFIG
  cat "$fish_script"    >> $FISH_CONFIG
  echo                  >> $FISH_CONFIG
  echo '#::end' $BASE   >> $FISH_CONFIG
fi

PROFILE=~/.profile
profile_script="${BASE}"-append-profile.sh

if test -f $profile_script; then
  echo
  echo Appending script $profile_script to $PROFILE
  echo                  >> $PROFILE
  echo '#::begin' $BASE >> $PROFILE
  cat "$profile_script" >> $PROFILE
  echo                  >> $PROFILE
  echo '#::end' $BASE   >> $PROFILE
fi