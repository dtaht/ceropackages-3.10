#!/bin/sh

. /lib/functions.sh

STOP=0

[ "$1" == "stop" ] && STOP=1

config_load aqm

IFB_NUM=0

run_simple_qos() {
	local section="$1"
	[ $(config_get "$section" enabled) == 1 ] || return 0
	export UPLINK=$(config_get "$section" upload)
	export DOWNLINK=$(config_get "$section" download)
	export ADSL=$(config_get "$section" adsl)
	export STAB=$(config_get "$section" stab)
	export LINKLAYER=$(config_get "$section" linklayer)
	export OVERHEAD=$(config_get "$section" overhead)
	export DEV="ifb${IFB_NUM}"
	IFB_NUM=$(expr $IFB_NUM + 1)
	export QDISC=$(config_get "$section" qdisc)
	export IFACE=$(config_get "$section" interface)
	SCRIPT=/usr/lib/aqm/$(config_get "$section" script)
	[ "$STOP" -eq 1 ] && { /usr/lib/aqm/stop.sh; return 0; }
	[ -x "$SCRIPT" ] && $SCRIPT
}

config_foreach run_simple_qos
