
FROM python:3-alpine

RUN pip install \
--upgrade pip \
setuptools \
coverage \
codecov \
twine \
sphinx \ 
sphinx_rtd_theme

RUN apk add git
