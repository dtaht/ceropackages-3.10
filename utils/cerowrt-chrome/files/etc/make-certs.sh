#!/bin/sh

days=3650
bits=1024
key=/etc/lighttpd/lighttpd.key
csr=/etc/lighttpd/lighttpd.csr
cert=/etc/lighttpd/lighttpd.crt
pem=/etc/lighttpd/lighttpd.pem
country=US
state=California
location=Erewhon

HS=`hostname`
HL=`uname -n`
if [ "$HL" == "$HS" ]
then
commonname=${HL}
sed '/req_extensions = v3_req/s/^# *//; /\[ v3_req \]/ a\
subjectAltName=DNS:'"${HS}.local,DNS:${HS}" \
	/etc/ssl/openssl.cnf > /tmp/openssl.cnf
else
commonname=${HS}.home.lan
sed '/req_extensions = v3_req/s/^# *//; /\[ v3_req \]/ a\
subjectAltName=DNS:'"${HS}.local,DNS:${HS},DNS:${HL}" \
	/etc/ssl/openssl.cnf > /tmp/openssl.cnf
fi

export OPENSSL_CONF=/tmp/openssl.cnf
openssl genrsa -out $key $bits
openssl req -new -key $key -out $csr \
    -subj "/C=$country/ST=$state/L=$location/CN=$commonname"
openssl x509 -req -days $days \
	-in $csr -signkey $key -out $cert
cat $key $cert > $pem
rm /tmp/openssl.cnf
        
/etc/init.d/lighttpd stop # can get wedged
/etc/init.d/lighttpd start
