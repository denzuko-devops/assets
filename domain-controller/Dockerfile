FROM turnkeylinux/domain-controller-13.0
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

LABEL net.matrix.orgunit "Matrix NOC"                        # Subdomain - ldap/krb5 domains
LABEL net.matrix.organization "Private Ops"                  # TLD
LABEL net.matrix.commonname "dc1"                            # CNAME (be sure to use Reverse PTRs)
LABEL net.matrix.locality "Dallas"                           # LOC
LABEL net.matrix.state "Texas"                               # LOC
LABEL net.matrix.country "USA"                               # LOC
LABEL net.matrix.environment "<nonprod|production|staging>"  #HINFO ... <env> <role>
LABEL net.matrix.role "file server"                          #HINFO ... <env> <role>
LABEL net.matrix.application "infrastructure"                #SRV + DNS-SD
LABEL net.matrix.owner "FC13F74B@matrix.net"                 #RP + HESIOD NS, and X25 (as phone number [001 212 555 1234]) => GECOS
LABEL net.matrix.customer "PVT-01"                           #Cost Accounting tagging - use TXT record or PTR/CNAME to RP+Hesiod
LABEL net.matrix.costcenter "INT-01"                         #Cost Accounting Tagging - use TXT record
LABEL net.matrix.oid "iso.org.dod.internet.42387"            #Management Tagging - snmp, docs, etc.. via TXT records
LABEL net.matrix.duns "iso.org.duns.02-951-1901"             #Billing Tagging - snmp, docs, etc.. via TXT records
