FROM ubuntu:disco
LABEL maintainer Christos KK Loverdos <loverdos@gmail.com>

# An initial, updated image, ready to be used for 
# experimentation and installing software.

ARG PLAIN_USER
ENV PLAIN_USER ${PLAIN_USER:-plainuser}
ENV PLAIN_USER_HOME /home/$PLAIN_USER

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

ADD base-install-base.sh /root/
RUN /root/base-install-base.sh

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
ADD install.sh $PLAIN_USER_HOME
ADD install-config.sh $PLAIN_USER_HOME
ADD base-append-config.fish $PLAIN_USER_HOME

# prepare to run extra configuration steps
RUN chown.sh *.sh *.fish

# run extra configuration steps
RUN mkdir -p bin .local/bin .config/fish
RUN install-config.sh base

# install: fisherman
ADD base-install-fisherman.sh $PLAIN_USER_HOME
RUN chown.sh base-install-fisherman.sh
RUN base-install-fisherman.sh

# add: .gitconfig
ADD .gitconfig $PLAIN_USER_HOME
RUN chown.sh .gitconfig

RUN install.sh atool p7zip-full zip unzip fzy silversearcher-ag rlwrap

# We cannot use $PLAIN_USER_SHELL here
CMD [ "/usr/bin/fish", "-i", "-l" ]