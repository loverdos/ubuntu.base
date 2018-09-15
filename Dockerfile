FROM ubuntu:bionic
LABEL maintainer Christos KK Loverdos <loverdos@gmail.com>

# An initial, updated image, ready to be used for 
# experimentation and installing software.

ARG PLAIN_USER
ENV PLAIN_USER ${PLAIN_USER:-plainuser}
ENV PLAIN_USER_HOME /home/$PLAIN_USER

ENV DEBIAN_FRONTEND noninteractive

# Absolutely minimum setup for further installations
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y locales sudo apt-utils apt-transport-https software-properties-common \
    && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Add ppa: fish
# Install: fish
RUN apt-add-repository -y ppa:fish-shell/release-2 \
    && apt-get update \
    && apt-get -y install fish

# Add user: plainuser
RUN adduser --disabled-password --gecos '' $PLAIN_USER \
    && adduser $PLAIN_USER sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# set login shell (root): fish
RUN chsh -s /usr/bin/fish \
    && mkdir -p ~root/.config/fish

# add some usefull scripts
ADD install-config.sh /root/

# set login shell (plainuser): fish
ARG PLAIN_USER_SHELL
ENV PLAIN_USER_SHELL ${PLAIN_USER_SHELL:-/usr/bin/fish}
RUN chsh -s $PLAIN_USER_SHELL $PLAIN_USER

# everything from now on is from $PLAIN_USER
USER $PLAIN_USER
WORKDIR $PLAIN_USER_HOME
ENV USER $PLAIN_USER
ENV HOME $PLAIN_USER_HOME
ENV SHELL $PLAIN_USER_SHELL

# Update PATH
ENV PATH $PLAIN_USER_HOME:$PATH

# add configurations
ADD chown.sh $PLAIN_USER_HOME
ADD cmd.sh $PLAIN_USER_HOME
ADD install-config.sh $PLAIN_USER_HOME
ADD base-append-config.fish $PLAIN_USER_HOME

# prepare to run extra configuration steps
RUN chown.sh *.sh *.fish

# run extra configuration steps
RUN mkdir -p bin .local/bin .config/fish
RUN install-config.sh base

# We cannot use $PLAIN_USER_SHELL here
CMD [ "/usr/bin/fish", "-i", "-l" ]