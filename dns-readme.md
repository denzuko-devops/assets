## Service structure ##

The service structure is designed to help with automation and be easily _grokked_ by both machine and human.

The following "varables" are borrowed from ITIL Lite conventions and correlate with docker labels/service discovery.

* **SERVICE_NAME**  ::= _application in rfc2782 complient name string_
* **SITE_NAME**     ::= _site location in rfc2782 complient name string (ie stack-site)_
* **COST_CENTER**   ::= _billing center for service_
* **CUSTOMER**      ::= _tenant id for service_
* **PROJECT_OWNER** ::= _dn complient string of application owner's cn in ldap_
* **PROJECT_ROLE**  ::= _dn complient string of application's role_
* **PROJECT_NAME**  ::= _dn complient string of application's name_

*DNS RR* of `CNAME` records is utilized for each environment pipeline. While each environment 
shall have HA configured endpoints in both `A`/`AAA` records for *DNS RR*.

`SRV` records are used for service discovery while `SERVICE_NAME._netblock` records are for auto discover of network address cidrs.
SERVICE_NAME.* `TXT` records are for correlation with docker labels and constraints, accounting, and project management.


### Template zone ###
```
$TTL 1h
$ORIGIN dapla.net
...
SERVICE_NAME.owner                          TXT                     "O=matrix,OU=owner,cn=PROJECT_OWNER,dc=dapla,dc=net"
SERVICE_NAME.role                           TXT                     "O=matrix,OU=role,cn=PROJECT_ROLE,dc=dapla,dc=net"
SERVICE_NAME.application                    TXT                     "O=matrix,OU=application,cn=PROJECT_NAME,dc=dapla,dc=net"
SERVICE_NAME.customer                       TXT                     "O=matrix,OU=customer,cn=CUSTOMER,dc=dapla,dc=net"
SERVICE_NAME.costcenter                     TXT                     "O=matrix,OU=costcenter,cn=COSTCENTER,dc=dapla,dc=net"
SERVICE_NAME._spf                           TXT                     "v=spf1 include:SERVICE_NAME._netblock.preprod.dapla.net include:SERVICE_NAME._netblock.prod.dapla.net a mx ?all"
SERVICE_NAME._netblock.prepred              TXT                     "v=spf1 ipv4:10.0.1.0/24 ipv4:10.0.0.0/24 ipv4:10.0.0.1.100/32 ipv4:10.0.0.0.100/32 exists:SERVICE_NAME.dapla.net a mx ?all"
SERVICE_NAME._netblock.prod                 TXT                     "v=spf1 ipv4:10.0.1.0/24 ipv4:10.0.0.0/24 ipv4:10.0.0.1.100/32 ipv4:10.0.0.0.100/32 exists:SERVICE_NAME.dapla.net a mx ?all"
SERVICE_NAME.garterney                      A                       10.0.0.100
SERVICE_NAME.tolaria                        A                       10.0.1.100
SERVICE_NAME-develop                        CNAME                   SERVICE_NAME.garterney
SERVICE_NAME-develop                        CNAME                   SERVICE_NAME.tolaria
SERVICE_NAME-stage                          CNAME                   SERVICE_NAME.garterney
SERVICE_NAME-stage                          CNAME                   SERVICE_NAME.tolaria
SERVICE_NAME                                CNAME                   SERVICE_NAME.garterney
SERVICE_NAME                                CNAME                   SERVICE_NAME.tolaria
_SERVICE_NAME._http                         SRV     255 100 443     SERVICE_NAME.garterney
_SERVICE_NAME._http                         SRV     255 100 443     SERVICE_NAME.tolaria
_SERVICE_NAME._https                        SRV     255 100 443     SERVICE_NAME.garterney
_SERVICE_NAME._https                        SRV     255 100 443     SERVICE_NAME.tolaria
_SERVICE_NAME._tcp                          SRV     255 100 22      SERVICE_NAME.garterney
_SERVICE_NAME._tcp                          SRV     255 100 22      SERVICE_NAME.tolaria
_SERVICE_NAME._tcp                          SRV     255 100 443     SERVICE_NAME.garterney
_ssh._tcp                                   SRV     255 100 22      SERVICE_NAME.garterney
_ssh._tcp                                   SRV     255 100 22      SERVICE_NAME.tolaria
_http._tcp                                  SRV     255 100 443      SERVICE_NAME.garterney
_http._tcp                                  SRV     255 100 443      SERVICE_NAME.tolaria
_https._tcp                                 SRV     255 100 443      SERVICE_NAME.garterney
_https._tcp                                 SRV     255 100 443      SERVICE_NAME.tolaria
...
```
