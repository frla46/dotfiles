FROM archlinux:latest

ARG USER=frla
ARG PASSWORD=hogehoge
ARG HOSTNAME=home
ARG REPO=/home/${USER}/src/

ENV HOME /home/${USER}

RUN pacman -Syu --noconfirm
RUN pacman -S base base-devel --noconfirm
RUN pacman -Syy
RUN pacman -S git --noconfirm

RUN useradd -m -r -G wheel -s /bin/bash ${USER}
RUN echo "root:${PASSWORD}" | chpasswd
RUN echo "${USER}:${PASSWORD}" | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' | EDITOR='tee -a' visudo

USER ${USER}
RUN mkdir -p ${REPO}
WORKDIR ${REPOSITORY}
RUN git clone https://github.com/frla46/dotfiles.git
