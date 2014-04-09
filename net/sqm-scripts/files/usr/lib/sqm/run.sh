#!/bin/sh

. /lib/functions.sh

STOP=$1
ACTIVE_STATE_FILE_DIR="/var/run/SQM"
mkdir -p ${ACTIVE_STATE_FILE_DIR}

config_load sqm

IFB_NUM=0

run_simple_qos() {
	local section="$1"
	export IFACE=$(config_get "$section" interface)
	ACTIVE_STATE_FILE_FQN="${ACTIVE_STATE_FILE_DIR}/SQM_active_on_${IFACE}"	# this marks interfaces as active with SQM
	[ -f "${ACTIVE_STATE_FILE_FQN}" ] && logger "${ACTIVE_STATE_FILE_FQN}"


	if [ $(config_get "$section" enabled) -ne 1 ];
	then
	    if [ -f "${ACTIVE_STATE_FILE_FQN}" ];
	    then
		local SECTION_STOP="stop"	# it seems the user just de-selected enable, so stop the active SQM
	    else
		return 0	# since SQM is not active on the current interface nothing to do here
	    fi
	fi

	export UPLINK=$(config_get "$section" upload)
	export DOWNLINK=$(config_get "$section" download)
	export LLAM=$(config_get "$section" linklayer_adaptation_mechanism)
	export LINKLAYER=$(config_get "$section" linklayer)
	export OVERHEAD=$(config_get "$section" overhead)
	export STAB_MTU=$(config_get "$section" tcMTU)
	export STAB_TSIZE=$(config_get "$section" tcTSIZE)
	export STAB_MPU=$(config_get "$section" tcMPU)
	export ILIMIT=$(config_get "$section" ilimit)
	export ELIMIT=$(config_get "$section" elimit)
	export ITARGET=$(config_get "$section" itarget)
	export ETARGET=$(config_get "$section" etarget)
	export IECN=$(config_get "$section" ingress_ecn)
	export EECN=$(config_get "$section" egress_ecn)
	export IQDISC_OPTS=$(config_get "$section" iqdisc_opts)
	export EQDISC_OPTS=$(config_get "$section" eqdisc_opts)
	export TARGET=$(config_get "$section" target)
	export SQUASH_DSCP=$(config_get "$section" squash_dscp)

	export DEV="ifb${IFB_NUM}"
	IFB_NUM=$(expr $IFB_NUM + 1)

	export QDISC=$(config_get "$section" qdisc)
	export SCRIPT=/usr/lib/sqm/$(config_get "$section" script)

	if [ "$STOP" == "stop" -o "$SECTION_STOP" == "stop" ];
	then 
	     /usr/lib/sqm/stop.sh
	     [ -f ${ACTIVE_STATE_FILE_FQN} ] && rm ${ACTIVE_STATE_FILE_FQN}	# conditional to avoid errors ACTIVE_STATE_FILE_FQN does not exist anymore
	     $(config_set "$section" enabled 0)	# this does not save to the config file only to the loaded memory representation
	     logger "SQM qdiscs on ${IFACE} removed"
	     return 0
	fi
	logger "Queue Setup Script: ${SCRIPT}"
	[ -x "$SCRIPT" ] && { $SCRIPT ; touch ${ACTIVE_STATE_FILE_FQN}; }
}

config_foreach run_simple_qos
