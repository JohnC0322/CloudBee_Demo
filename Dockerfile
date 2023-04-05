FROM jrei/systemd-ubuntu:20.04

ARG VERSION
ENV container docker
RUN apt update && apt install -y apt-utils
RUN apt install -y \
    curl net-tools locales gzip \
    less wget sudo vim unzip
RUN apt install -y \
    default-jre