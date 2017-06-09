FROM alpine:latest
MAINTAINER 

RUN apk add --no-chase dcron logrotate syslog-ng s6 s6-portable-utils

ADD init /init
ADD data/syslog-ng/conf /etc/syslog-ng/syslog-ng.conf
ADD data/syslog-ng/logrotate /etc/logrotate.d/syslog-ng
ENTRYPOINT ["/bin/s6-svcscan", "/s6"]
CMD []
