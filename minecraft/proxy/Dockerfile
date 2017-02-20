FROM jwilder/nginx-proxy
MAINTAINER Dwight Spencer <@denzuko> (dspencer@computekindustries.com)

ARG DOCKER_HOST=unix:///tmp/docker.sock
ARG CERTSPATH=/data

RUN mkdir $CERTSPATH
COPY certs $CERTSPATH
