#!/usr/bin/env bash

set -euxo pipefail

apt-get update
apt-get -y upgrade
apt-get install -y vim locales sudo apt-utils apt-transport-https software-properties-common curl wget gnupg git

locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

apt-add-repository -y ppa:fish-shell/release-3
apt-get -y install fish

adduser --disabled-password --gecos '' $PLAIN_USER
adduser $PLAIN_USER sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
chsh -s /usr/bin/fish
mkdir -p ~root/.config/fish

ln -s /home/${PLAIN_USER} /Home

apt-get autoremove -y
apt-get autoclean -y
# rm -rf /var/cache/debconf/* /var/lib/apt/lists/* /var/log/* /tmp/* /var/tmp/*
