#!/bin/sh

STOP=$1
IPSET_NAME=bcp38-ipv4

. /lib/functions.sh

config_load firewall

enable_bcp38()
{
	local whitelist="$1"

	ipset add $IPSET_NAME 127.0.0.0/8
	ipset add $IPSET_NAME 0.0.0.0/8	     # RFC 1700
	ipset add $IPSET_NAME 240.0.0.0/4     # RFC 5745
	ipset add $IPSET_NAME 192.0.2.0/24    # RFC 5737
	ipset add $IPSET_NAME 198.51.100.0/24 # RFC 5737
	ipset add $IPSET_NAME 203.0.113.0/24  # RFC 5737
	ipset add $IPSET_NAME 192.168.0.0/16  # RFC 1918
	ipset add $IPSET_NAME 10.0.0.0/8      # RFC 1918
	ipset add $IPSET_NAME 172.16.0.0/12   # RFC 1918
	ipset add $IPSET_NAME 169.254.0.0/16  # RFC 3927

	if [ -n "$whitelist" ]; then
		for subnet in $whitelist; do
			ipset add $IPSET_NAME $subnet nomatch
		done
	fi
}

die()
{
    echo "$@" >&2
    exit 1
}

run() {
	local enabled
	local whitelist
	config_get_bool enabled $1 enable_bcp38 0

	# Make sure the ipset always exists -- empty by default

	ipset list $IPSET_NAME >/dev/null 2>&1 || die "No ipset with name $IPSET_NAME exists. Create it first"
	ipset flush $IPSET_NAME

	if [ "$enabled" -eq "1" -a -z "$STOP" ] ; then
		config_get whitelist $1 bcp38_whitelist
		enable_bcp38 "$whitelist"
	fi
}

config_foreach run defaults

exit 0
