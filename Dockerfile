FROM archlinux:latest

ARG HOSTNAME=make_test
ARG USER=frla
ARG PASSWORD=hoge

ENV HOME /home/${USER}
ENV ZDOTDIR ~/.config/zsh
ENV HISTFILE ${ZDOTDIR:-~}/.zsh_history

RUN pacman -Syu --noconfirm\
  && pacman -S base base-devel --noconfirm\
  && pacman -Syy\
  && pacman -S git --noconfirm

RUN useradd -m -r -G wheel -s /bin/bash ${USER}\
  && echo "root:${PASSWORD}" | chpasswd\
  && echo "${USER}:${PASSWORD}" | chpasswd\
  && echo '%wheel ALL=(ALL) ALL' | EDITOR='tee -a' visudo\
  && echo '${HOSTNAME}' > /etc/hostname

USER ${USER}
WORKDIR ${HOME}
RUN git clone https://github.com/frla46/dotfiles.git
