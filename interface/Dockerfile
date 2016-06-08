FROM hypriot/rpi-node:6.1.0
MAINTAINER 0xFC13F74B

ENV affinity:net.matrix.role= web*servers

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
LABEL net.matrix.commonname "cloud"
LABEL net.matrix.locality "Dallas"
LABEL net.matrix.state "Texas"
LABEL net.matrix.country "USA"
LABEL net.matrix.environment "nonprod"
LABEL net.matrix.application "infrastructure"
LABEL net.matrix.role "main interface"
LABEL net.matrix.owner "FC13F74B@matrix.net"
LABEL net.matrix.customer "PVT-01"
LABEL net.matrix.costcenter "INT-01"
LABEL net.matrix.oid "iso.org.dod.internet.42387"
LABEL net.matrix.duns "iso.org.duns.039271257"

EXPORT 3000

RUN mkdir -p /usr/src/app /usr/src/app/workspace
WORKDIR /usr/src/app

ONBUILD RUN git clone git@github.com:c9/core.git /usr/src/app/ && npm install

CMD [ "npm", "server.js", "-w", "/usr/src/app/workspace", "--listen", "0.0.0.0", "--port", "3000" ]