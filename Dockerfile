FROM python:3.6.9-alpine

RUN apk add --update \
sudo \
git \
make \
gcc \
libc-dev \
libffi-dev \
libressl-dev \
fortify-headers \
npm \
linux-headers && rm -rf /var/cache/apk/*

RUN wget http://download.redis.io/releases/redis-3.2.5.tar.gz && \
tar xvzf redis-3.2.5.tar.gz && \
cd redis-3.2.5 && \
make 

RUN pip install \
--upgrade pip \
setuptools \
coverage \
codecov \
twine \
sphinx \ 
sphinx_rtd_theme \
eventlet

 
RUN adduser -S -D -s /bin/sh firex
RUN echo "firex ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER firex
WORKDIR /home/firex

ENV redis_bin_dir=/redis-3.2.5/src

