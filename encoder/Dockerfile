# Dockerfile for the mencoder. BSD Licenced. See LICENCE for details. - keybase.io/denzuko

FROM alpine:3.6
LABEL MAINTAINER 0xFC13F74B

ARG FWATCHDOG_VERSION "0.7.1"
ARG ENCODER_OPTS "-list-options"
ARG BUILDID "0.0.1"

ENV affinity:net.matrix.role= cpu*servers
ENV affinity:net.matrix.arch=x86_64

# the following are presented as generally accepted
# values. In the case of personal certificates GN=, SN= or pseudonym=
# can appear in the fields
# C = ISO3166 two character country code
# ST = state or province
# L = Locality; generally means city
# O = Organization - Company Name
# OU = Organization Unit - division or unit
# CN = CommonName - end entity name e.g. www.example.com
# environment ::= <nonprod|production|staging>

LABEL net.matrix.orgunit "Matrix NOC"
LABEL net.matrix.organization "Private Ops"
LABEL net.matrix.commonname "encoder"
LABEL net.matrix.locality "Dallas"
LABEL net.matrix.state "Texas"
LABEL net.matrix.country "USA"
LABEL net.matrix.environment "nonprod"
LABEL net.matrix.application "mencode"
LABEL net.matrix.version $BUILDID
LABEL net.matrix.role "video encoders"
LABEL net.matrix.owner "FC13F74B@matrix.net"
LABEL net.matrix.customer "PVT-01"
LABEL net.matrix.costcenter "INT-01"
LABEL net.matrix.oid "iso.org.dod.internet.42387"
LABEL net.matrix.duns "iso.org.duns.039271257"
LABEL oribiter.enabled "false"
LABEL traefik.enabled "false"
LABEL com.centurylinklabs.watchtower.enable "false"

RUN apk add --update --upgrade --no-cache --virtual build-dependencies make curl ca-certificates && \
    && curl -sL https://github.com/openfaas/faas/releases/download/${FWATCHDOG_VERSION}/fwatchdog > /usr/bin/fwatchdog \
    && apk del build-dependencies \
    && chmod +x /usr/bin/fwatchdog \
    && apt add --no-cache mplayer \
    && addgroup -S mencoder && adduser -S mencoder -G mencoder \
    && mkdir -p /home/mencoder/video

ENV HOME /home/mencoder
WORKDIR $HOME/video
VOLUME /home/mencoder/video
USER mencoder

ENV ENCODER_OPTS $ENCODER_OPTS
ENV fprocess "/usr/bin/env mencoder $ENCODER_OPTS"
ENTRYPOINT ["/usr/bin/fwatchdog"]

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1
