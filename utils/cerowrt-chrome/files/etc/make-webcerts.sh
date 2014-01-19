#!/bin/sh

days=3650
bits=1024
key=/etc/lighttpd/lighttpd.key
cert=/etc/lighttpd/lighttpd.crt
pem=/etc/lighttpd/lighttpd.pem
country=US
state=California
location=Erewhon
commonname=gw.home.lan

#HL=`uname -n`
#HS=`hostname`

#if [ "$HL" == "$HS" ]; then
#    commonname=$HS.home.lan
#    hosts="DNS:gw.home.lan,DNS:$HS.local,DNS:$HS"
#else
#    commonname=$HL
#    hosts="DNS:gw.home.lan,DNS:$HS.local,DNS:$HS,DNS:$HL"
#fi

#[ -e /etc/ssl/openssl.cnf ] || \
#    cp -p /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.orig
#sed -i '/req_extensions = v3_req/s/^# *//; /subjectAltName/d; /\[ v3_req \]/ a\
#subjectAltName="'$hosts'"' /etc/ssl/openssl.cnf

/usr/sbin/px5g selfsigned -pem -x509 \
    -days $days -newkey rsa:$bits -keyout $key -out $cert \
    -subj "/C=$country/ST=$state/L=$location/CN=$commonname"
cat $key $cert > $pem

#openssl req -new -newkey rsa:$bits -x509 -keyout $pem -out $pem -days $days \
#    -nodes -subj "/C=$country/ST=$state/L=$location/CN=$commonname"
        
/etc/init.d/lighttpd stop # can get wedged
/etc/init.d/lighttpd start # hopefully unwedged

