FROM ubuntu:artful
MAINTAINER Jonas Gröger <jonas@huntun.de>
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    jq \
    curl \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN gem install fpm

COPY . /data
WORKDIR /data