FROM alpine:latest AS base
LABEL missing 'ripgrep jo nomad packer hub heroku zerotier travis-ci s3cmd aws-cli'
RUN echo '@edge-testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> tee -a /etc/apk/repositories && \
    echo '@edge-community http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@edge-main http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories

RUN apk upgrade --update-cache --available
RUN apk add --no-cache \
        ca-certificates build-base curl git rsync jq vim gnupg tmux openssh fzf \
        python python-dev py-pip py-setuptools libmagic ansible \
        nmap net-snmp \
        terraform vault \
    rm -rf /var/cache/apk/*
RUN pip install direnv virtualenv honcho python-dateutil python-magic
RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf
    
### Collapce layers, adding pubkey to root, change root pw, and set Environment
FROM scratch
COPY --from=base / .
LABEL Maintainer "Dwight Spencer @denzuko"
LABEL org.label-schema.vendor "Da Planet Security"
LABEL org.label-schema.vcs-url "https://github.com/denzuko-devops/assets"
LABEL org.label-schema.vcs-ref "master"
LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.description "Basic linux shell via ssh with typical tools used by @denzuko"
LABEL net.dapla.matrix.schema-version = "1.0"
LABEL net.dapla.matrix.orgunit "Matrix DevOps"
LABEL net.dapla.matrix.organization "Private Ops"
LABEL net.dapla.matrix.commonname "user-shell"
LABEL net.dapla.matrix.locality "Dallas"
LABEL net.dapla.matrix.state "Texas"
LABEL net.dapla.matrix.country "USA"
LABEL net.dapla.matrix.environment "nonprod"
LABEL net.dapla.matrix.application "linux shell"
LABEL net.dapla.matrix.role  "developer workstation"
LABEL net.dapla.matrix.owner "FC13F74B@matrix.net"
LABEL net.dapla.matrix.customer "PVT-01"
LABEL net.dapla.matrix.costcenter "INT-01"
ADD https://github.com/denzuko.keys /root/.ssh/authorized_keys
RUN echo "root:3bars4life" | chpasswd
ENV TZ 'Etc/UTC-6'
ENV DOMAINNAME 'mainnet.dapla.net'
EXPOSE 22
ENTRYPOINT ['/usr/sbin/sshd', '-D']
