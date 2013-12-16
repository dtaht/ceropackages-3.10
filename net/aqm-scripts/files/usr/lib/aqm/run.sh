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
	export LLAM=$(config_get "$section" linklayer_adaptation_mechanism)
	export LINKLAYER=$(config_get "$section" linklayer)
	export OVERHEAD=$(config_get "$section" overhead)
	export STAB_MTU=$(config_get "$section" MTU)
	export STAB_TSIZE=$(config_get "$section" TSIZE)
	export STAB_MPU=$(config_get "$section" MPU)
	export INGRESSECN=$(config_get "$section" ingress_ecn)
	export EGRESSECN=$(config_get "$section" egress_ecn)

	export DEV="ifb${IFB_NUM}"
	IFB_NUM=$(expr $IFB_NUM + 1)
	export IFACE=$(config_get "$section" interface)
	if [ $(config_get "$section" advanced) -eq 1 ]; then
		export QDISC=$(config_get "$section" qdisc)
		SCRIPT=/usr/lib/aqm/$(config_get "$section" script)
		logger "Queue Setup Script: ${SCRIPT}"
	else
		export QDISC=fq_codel
		SCRIPT=/usr/lib/aqm/simple.qos
		logger "defaulting to simple.qos using fq_codel"	
	fi
	[ "$STOP" -eq 1 ] && { /usr/lib/aqm/stop.sh; return 0; }
	[ -x "$SCRIPT" ] && $SCRIPT
}

config_foreach run_simple_qos
