#!/bin/sh

. /lib/functions.sh

config_load aqm

IFB_NUM=0

run_simple_qos() {
	local section="$1"
	[ $(config_get "$section" enabled) == 1 ] || return 0
	export UPLINK=$(config_get "$section" upload)
	export DOWNLINK=$(config_get "$section" download)
	export ADSL=$(config_get "$section" adsl)
	export DEV="ifb${IFB_NUM}"
	IFB_NUM=$(expr $IFB_NUM + 1)
	export QDISC=$(config_get "$section" qdisc)
	export IFACE=$(config_get "$section" interface)
	/usr/lib/aqm/simple_qos.sh
}

config_foreach run_simple_qos
