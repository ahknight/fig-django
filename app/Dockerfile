# vim:set ft=dockerfile:
FROM ubuntu:trusty
ENV PYTHONUNBUFFERED 1
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -qy
RUN apt-get install -qy python2.7 python-dev python-pip
RUN apt-get install -qy postgresql-client libpq-dev
WORKDIR /app
ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app
