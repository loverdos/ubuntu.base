FROM loverdos/ubuntu.updated:latest
LABEL maintainer Christos KK Loverdos <loverdos@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# base system
RUN apt-get install -y apt-utils apt-transport-\* software-properties-common python-software-properties python3-software-properties
RUN apt-get install -y locales
RUN apt-get install -y sudo
RUN apt-get install -y curl wget
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y openssl
RUN apt-get install -y autoconf libtool m4
RUN apt-get install -y p7zip-full atool xz-utils

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Add user: christos
RUN adduser --disabled-password --gecos '' christos \
    && adduser christos sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add fish shell ppa
RUN apt-add-repository -y ppa:fish-shell/release-2

RUN apt-get update

# install: fish
RUN apt-get -y install fish

# set login shell (root): fish
RUN chsh -s /usr/bin/fish
RUN mkdir -p ~root/.config/fish

# set login shell (christos): fish
RUN chsh -s /usr/bin/fish christos
RUN mkdir -p ~christos/.config/fish; chown -R christos:christos ~christos/.config/

# add some usefull scripts
ADD install-config.sh /root/
ADD install-config.sh /home/christos/
RUN chown christos:christos /home/christos/install-config.sh

# install configurations
ADD base-append-config.fish /home/christos/
ADD base-append-profile.sh  /home/christos/
RUN chown christos:christos /home/christos/base-*.*
RUN su - christos -c '~/install-config.sh base'

# Install linuxbrew
RUN apt-get install -y ruby
ADD base-install-linuxbrew.sh /home/christos/base-install-linuxbrew.sh
RUN chown christos:christos /home/christos/base-install-linuxbrew.sh
RUN su - christos -c '~/base-install-linuxbrew.sh'

CMD ["/usr/bin/fish", "-C", "cd ~; set -gx SHELL /usr/bin/fish"]