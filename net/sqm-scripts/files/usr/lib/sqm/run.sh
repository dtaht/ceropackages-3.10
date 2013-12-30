#!/bin/sh

. /lib/functions.sh

STOP=0

[ "$1" == "stop" ] && STOP=1

config_load sqm

IFB_NUM=0

run_simple_qos() {
	local section="$1"
	[ $(config_get "$section" enabled) == 1 ] || return 0
	export UPLINK=$(config_get "$section" upload)
	export DOWNLINK=$(config_get "$section" download)
	export LLAM=$(config_get "$section" linklayer_adaptation_mechanism)
	export LINKLAYER=$(config_get "$section" linklayer)
	export OVERHEAD=$(config_get "$section" overhead)
	export STAB_MTU=$(config_get "$section" tcMTU)
	export STAB_TSIZE=$(config_get "$section" tcTSIZE)
	export STAB_MPU=$(config_get "$section" tcMPU)
	export LIMIT=$(config_get "$section" limit)
	export iECN=$(config_get "$section" ingress_ecn)
	export eECN=$(config_get "$section" egress_ecn)
	export iqdisc_opts=$(config_get "$section" iqdisc_opts)
	export eqdisc_opts=$(config_get "$section" eqdisc_opts)
	export TARGET=$(config_get "$section" target)
	export SQUASH_INGRESS=$(config_get "$section" squash_ingress)
	export DEV="ifb${IFB_NUM}"
	IFB_NUM=$(expr $IFB_NUM + 1)
	export IFACE=$(config_get "$section" interface)
	export QDISC=$(config_get "$section" qdisc)
	export SCRIPT=/usr/lib/sqm/$(config_get "$section" script)
	
	logger "Queue Setup Script: ${SCRIPT}"
	[ "$STOP" -eq 1 ] && { /usr/lib/sqm/stop.sh; return 0; }
	[ -x "$SCRIPT" ] && $SCRIPT
}

config_foreach run_simple_qos
