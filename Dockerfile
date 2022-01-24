FROM python:3.10.2-alpine

RUN apk add --update \
sudo \
git \
make \
gcc \
g++ \
libc-dev \
libffi-dev \
libressl-dev \
fortify-headers \
npm \
openssh \
bash \
coreutils \
moreutils \
linux-headers \
libxml2-dev \
libxslt-dev \
musl-dev \
python3-dev \
openssl-dev \
cargo \
&& rm -rf /var/cache/apk/*

RUN wget http://download.redis.io/releases/redis-6.2.3.tar.gz && \
tar xvzf redis-6.2.3.tar.gz && \
cd redis-6.2.3 && \
make 

RUN pip install \
--upgrade pip \
setuptools \
coverage==4.5.4 \
codecov \
twine \
sphinx \ 
sphinx_rtd_theme \
sphinx-sitemap \
eventlet \
virtualenv
 
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

ENV redis_bin_dir=/redis-6.2.3/src

