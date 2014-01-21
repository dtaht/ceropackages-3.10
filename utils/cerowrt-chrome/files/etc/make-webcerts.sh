#!/bin/sh

days=3650
bits=1024
pem=/etc/lighttpd/lighttpd.pem
country=US
state=California
location=Erewhon

HL=`uname -n`
HS=`hostname`
IP=`ip addr show dev se00 | awk '/inet / {sub(/\/.*/, "", $2); print $2}'`

if [ "$HL" == "$HS" ]; then
    HL="$HS.home.lan"
fi
commonname=$HL
export SAN="DNS:gw.home.lan, DNS:gw, DNS:$HS.local, DNS:$HS, DNS:$HL, IP:$IP"

sed '/req_extensions = v3_req/s/^# *//; /SAN/d; /^HOME/i\
SAN="email:support@cerowrt.org"
/\[ v3_\(req\|ca\) \]/ a\
subjectAltName=${ENV::SAN}
' /etc/ssl/openssl.cnf > /tmp/openssl.cnf

openssl req -new -newkey rsa:$bits -x509 -keyout $pem -out $pem -days $days \
    -nodes -subj "/C=$country/ST=$state/L=$location/CN=$commonname" \
    -config /tmp/openssl.cnf
rm /tmp/openssl.cnf

/etc/init.d/lighttpd stop # can get wedged
/etc/init.d/lighttpd start # hopefully unwedged

