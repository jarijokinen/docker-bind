# docker-bind
#
# Dockerfile for BIND on Debian 9.0 (stretch)
#
# Copyright (c) 2017 Jari Jokinen. MIT License.
#
# USAGE:
#
#   docker build -t bind .
#   docker volume create --name bind-data
#   docker run -d -p 127.0.0.1:53:53/tcp -p 127.0.0.1:53:53/udp \
#     -v bind-data:/etc/bind bind

FROM debian:stretch-slim
MAINTAINER Jari Jokinen <info@jarijokinen.com>

RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01recommends \
  && apt-get update \
  && apt-get install -y \
    bind9 \
  && rm -rf /var/lib/apt/lists/*

RUN chown root:bind /etc/bind/rndc.key

EXPOSE 53/udp 53/tcp
CMD ["/usr/sbin/named", "-f"]
