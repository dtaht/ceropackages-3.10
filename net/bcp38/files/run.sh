#!/bin/sh

STOP=$1
IPSET_NAME=bcp38-ipv4

. /lib/functions.sh

config_load bcp38

add_bcp38_rule()
{
	local subnet="$1"
	local action="$2"

	if [ "$action" == "nomatch" ]; then
		ipset add $IPSET_NAME $subnet nomatch
	else
		ipset add $IPSET_NAME $subnet
	fi
}

run() {
	local enabled
	config_get_bool enabled $1 enabled 0

	if [ "$enabled" -eq "1" -a -z "$STOP" ] ; then
		config_list_foreach $1 match add_bcp38_rule match
		config_list_foreach $1 nomatch add_bcp38_rule nomatch
	fi
}

die()
{
    echo "$@" >&2
    exit 1
}

# Make sure the ipset starts out empty
ipset list $IPSET_NAME >/dev/null 2>&1 || die "No ipset with name $IPSET_NAME exists. Create it first"
ipset flush $IPSET_NAME
config_foreach run bcp38

exit 0
