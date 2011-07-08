#!/bin/sh

. /etc/default/ddns6.config
tempfile="/tmp/dnsupdate.$$"
logfile="/tmp/logfile"

usage() {
    echo "$0 action [<object> <string> [<object> <string> ...]]" 1>&2
    echo "actions:" 1>&2
    echo "	commit: create DNS records"
    echo "	release: remove DNS records"
    echo "objects:" 1>&2
    echo "	iface: local net interface" 1>&2
    echo "	ipv4addr: client IPv4 address" 1>&2
    echo "	mac: client MAC address (required)" 1>&2
    echo "	host: client hostname (required)" 1>&2
    echo "	domain: dynamic domain name" 1>&2
    echo "	ttl: time-to-live for the DNS records to be created" 1>&2
    exit 1
}

find_ipv6_addresses() {
    for pref in $prefixes; do
	width=`echo $pref | cut -f2 -d/`
	pref=`echo $pref | cut -f1 -d/`

	ipv6addr=`ipv6calc --in prefix+mac $pref $macaddr --out ipv6addr \
			   --action prefixmac2ipv6`

	echo "constructed address: $ipv6addr " >> $logfile
        if [ "$1" = "ping" ]; then
            if ping6 -q -c1 $ipv6addr >&- 2>&-; then
                echo "$ipv6addr exists" >> $logfile
            else
                echo "$ipv6addr does not exist" >> $logfile
                exit
            fi
        fi

	rzone=`ipv6calc --in ipv6addr $pref/$width --out revnibbles.arpa`
        rname=`ipv6calc --in ipv6addr $ipv6addr --out revnibbles.arpa`

        revzones="$revzones $rzone"
        revnames="$revnames $rname"
	addresses="$addresses $ipv6addr"
    done
}

do_ddns_commit() {
    set -- $addresses
    [ $# -eq 0 ] && return

    echo server localhost > $tempfile
    echo zone $domain >> $tempfile
    echo ttl $ttl >> $tempfile

    for address in $addresses; do
	echo update delete $hostname.$domain AAAA >> $tempfile
	echo update add $hostname.$domain AAAA $ipv6addr >> $tempfile
    done
    echo send >> $tempfile

    set -- $revzones
    for revname in $revnames; do
        echo zone $1 >> $tempfile
        shift

	echo update delete $revname PTR >> $tempfile
	echo update add $revname PTR $hostname.$domain >> $tempfile
    done
    echo send >> $tempfile

    nsupdate -k $key $tempfile >> $logfile 2>&1 || {
        echo FAILED NSUPDATE: >> $logfile
        cat $tempfile >> $logfile
    }

    rm -f $tempfile
}

do_commit() {
    # we do this in a background shell since it may take a while
    (
	find_ipv6_addresses ping
	do_ddns_commit
    ) &
}

do_ddns_release() {
    set -- $addresses
    [ $# -eq 0 ] && return

    echo server localhost > $tempfile
    echo zone $domain >> $tempfile

    for address in $addresses; do
        echo prereq yxrrset $hostname.$domain AAAA $ipv6addr >> $tempfile
	echo update delete $hostname.$domain AAAA $ipv6addr >> $tempfile
        echo send >> $tempfile
    done

    set -- $revzones
    for revname in $revnames; do
        echo zone $1 >> $tempfile
        shift

        echo prereq yxrrset $revname PTR $hostname.$domain >> $tempfile
	echo update delete $revname PTR $hostname.$domain >> $tempfile
        echo send >> $tempfile
    done

    nsupdate -k $key $tempfile >> $logfile 2>&1 || {
        echo FAILED NSUPDATE: >> $logfile
        cat $tempfile >> $logfile
    }

    rm -f $tempfile
}

do_release() {
    # we do this in a background shell since it may take a while
    (
	find_ipv6_addresses no-ping
	do_ddns_release
    ) &
}

# parse the parameters.  first, specify commit or release
action=$1
shift

# then collect the objects to be set...
while [ "$#" -gt 0 ]; do
    param="$1"
    shift
    case "$param" in
	iface)
	    iface=$1
	    shift
	    ;;
	ipv4addr)
	    ipv4addr=$1
	    shift
	    ;;
	mac*)
	    macaddr=$1
	    shift
	    ;;
	host*)
	    hostname=$1
	    shift
	    ;;
	domain)
	    domain=$1
	    shift
	    ;;
	ttl)
	    ttl=$1
	    shift
	    ;;
	*)  usage
	    ;;
    esac
done

date >> $logfile
echo action=$action iface=$iface ipv4addr=$ipv4addr hostname=$hostname macaddr=$macaddr domain=$domain ttl=$ttl >> $logfile

# if no hostname or mac address was sent, we really can't do anything
if [ -z "$hostname" -o -z "$macaddr" ]; then
    exit 0
fi

case $action in
    commit)
        do_commit ;;
    release)
        do_release ;;
    *)
       usage ;;
esac
