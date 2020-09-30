FROM python:3.7.9-alpine

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
openssh \
bash \
coreutils \
linux-headers && rm -rf /var/cache/apk/*

RUN wget http://download.redis.io/releases/redis-3.2.5.tar.gz && \
tar xvzf redis-3.2.5.tar.gz && \
cd redis-3.2.5 && \
make 

RUN pip install \
--upgrade pip \
setuptools \
coverage==4.5.4 \
codecov==2.0.15 \
twine \
sphinx \ 
sphinx_rtd_theme \
eventlet

 
RUN adduser -S -D -s /bin/sh firex
RUN echo "firex ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Start root SSH setup
RUN echo "firex:passwd1" | chpasswd
RUN printf "PubkeyAuthentication yes\nPasswordAuthentication no" > /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
# End root SSH setup

USER firex
WORKDIR /home/firex

# Start firex SSH setup
RUN /usr/bin/ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
RUN cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
# End firex SSH setup

ENV redis_bin_dir=/redis-3.2.5/src

