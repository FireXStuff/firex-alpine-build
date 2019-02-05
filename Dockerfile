
FROM python:3-alpine

RUN pip install \
--upgrade pip \
setuptools \
coverage \
twine

RUN apk add git
