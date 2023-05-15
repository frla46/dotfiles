FROM archlinux:latest

ARG USER=frla
ARG PASSWORD=hoge
ARG HOSTNAME=home

ENV HOME /home/${USER}
ENV ZDOTDIR ~/.config/zsh/
ENV HISTFILE ${ZDOTDIR:-~}/.zsh_history
ENV HISTSIZE 10000
ENV SAVEHIST 10000

RUN pacman -Syu --noconfirm
RUN pacman -S base base-devel --noconfirm
RUN pacman -Syy
RUN pacman -S git --noconfirm

RUN useradd -m -r -G wheel -s /bin/bash ${USER}
RUN echo "root:${PASSWORD}" | chpasswd
RUN echo "${USER}:${PASSWORD}" | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' | EDITOR='tee -a' visudo

USER ${USER}
WORKDIR ${HOME}
RUN git clone https://github.com/frla46/dotfiles.git
