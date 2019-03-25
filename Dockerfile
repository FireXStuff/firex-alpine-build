FROM python:3.6-alpine

RUN pip install \
--upgrade pip \
setuptools \
coverage \
codecov \
twine \
sphinx \ 
sphinx_rtd_theme

RUN apk add --update \
git \
redis \
gcc \
libc-dev \
fortify-headers \
linux-headers && rm -rf /var/cache/apk/*
