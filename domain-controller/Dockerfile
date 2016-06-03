FROM turnkeylinux/fileserver-13.0
MAINTAINER 0xFC13F74B

ENV affinity:net.matrix.application= infrastructure

# the following are presented as generally accepted
# values. In the case of personal certificates GN=, SN= or pseudonym=
# can appear in the fields
# C = ISO3166 two character country code
# ST = state or province
# L = Locality; generally means city
# O = Organization - Company Name
# OU = Organization Unit - division or unit
# CN = CommonName - end entity name e.g. www.example.com

LABEL net.matrix.orgunit "Matrix NOC"
LABEL net.matrix.organization "Private Ops"
LABEL net.matrix.commonname "files"
LABEL net.matrix.locality "Dallas"
LABEL net.matrix.state "Texas"
LABEL net.matrix.country "USA"
LABEL net.matrix.environment "<nonprod|production|staging>"
LABEL net.matrix.application "infrastructure"
LABEL net.matrix.role "file server"
LABEL net.matrix.owner "FC13F74B@matrix.net"
LABEL net.matrix.customer "PVT-01"
LABEL net.matrix.costcenter "INT-01"
