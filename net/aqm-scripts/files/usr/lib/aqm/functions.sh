insmod() {
  lsmod | grep -q ^$1 || $INSMOD $1
}

ipt() {
  d=`echo $* | sed s/-A/-D/g`
  [ "$d" != "$*" ] && {
	iptables $d > /dev/null 2>&1
	ip6tables $d > /dev/null 2>&1
  }
  iptables $* > /dev/null 2>&1
  ip6tables $* > /dev/null 2>&1
}

do_modules() {
	insmod sch_$QDISC                                          
	insmod sch_ingress                                      
	insmod act_mirred                                         
	insmod cls_fw                                          
	insmod sch_htb                                              
}
                                                                                                                  
# You need to jiggle these parameters. Note limits are tuned towards a <10Mbit uplink <60Mbup down

[ -z "$UPLINK" ] && UPLINK=2302
[ -z "$DOWNLINK" ] && DOWNLINK=14698
[ -z "$DEV" ] && DEV=ifb0
[ -z "$QDISC" ] && QDISC=fq_codel
[ -z "$IFACE" ] && IFACE=ge00
[ -z "$LLAM" ] && LLAM="none"
[ -z "$LINKLAYER" ] && LINKLAYER=ethernet
[ -z "$OVERHEAD" ] && OVERHEAD=0
[ -z "$STAB_MTU" ] && STAB_MTU=2047
[ -z "$STAB_MPU" ] && STAB_MPU=0
[ -z "$STAB_TSIZE" ] && STAB_TSIZE=512
[ -z "$AUTOFLOW" ] && AUTOFLOW=0
#[ -z "$AUTOECN" ] && AUTOECN=1
#[ -z "$ALLECN" ] && ALLECN=2
[ -z "$INGRESSECN" ] && INGRESSECN="active"
[ -z "$EGRESSECN" ] && EGRESSECN="inactive"
[ -z "$TC" ] && TC=`which tc`
#[ -z "$TC" ] && TC="logger tc"	# this redirects all tc calls into the log
[ -z "$INSMOD" ] && INSMOD=`which insmod`


#logger "LLAM: ${LLAM}"
#logger "LINKLAYER: ${LINKLAYER}"

get_htb_adsll_string() {
	ADSLL=""
	if [ "$LLAM" = "htb_private" ]; 
	then
		# HTB defaults to MTU 1600 and an implicit fixed TSIZE of 256, but HTB as of around 3.10.0 does not actually use a table in the kernel
		ADSLL="mpu ${STAB_MPU} linklayer ${LINKLAYER} overhead ${OVERHEAD} mtu ${STAB_MTU}"
		logger "ADSLL: ${ADSLL}"
	fi
	echo ${ADSLL}
}

get_stab_string() {
	STABSTRING=""
	if [ "${LLAM}" = "tc_stab" ]; 
	then
		STABSTRING="stab mtu ${STAB_MTU} tsize ${STAB_TSIZE} mpu ${STAB_MPU} overhead ${OVERHEAD} linklayer ${LINKLAYER}"
		logger "STAB: ${STABSTRING}"
	fi
	echo ${STABSTRING}
}

aqm_stop() {
	$TC qdisc del dev $IFACE ingress
	$TC qdisc del dev $IFACE root
	$TC qdisc del dev $DEV root
}

# Note this has side effects on the prio variable
# and depends on the interface global too

fc() {
	$TC filter add dev $interface protocol ip parent $1 prio $prio u32 match ip tos $2 0xfc classid $3
	prio=$(($prio + 1))
	$TC filter add dev $interface protocol ipv6 parent $1 prio $prio u32 match ip6 priority $2 0xfc classid $3
	prio=$(($prio + 1))
}

# FIXME: actually you need to get the underlying MTU on PPOE thing

get_mtu() {
	F=`cat /sys/class/net/$1/mtu`
	if [ -z "$F" ]
	then
	echo 1500
	else
	echo $F
	fi
}

# FIXME should also calculate the limit
# Frankly I think Xfq_codel can pretty much always run with high numbers of flows
# now that it does fate sharing
# But right now I'm trying to match the ns2 model behavior better
# So SET the autoflow variable to 1 if you want the cablelabs behavior

get_flows() {
	if [ "$AUTOFLOW" -eq "1" ] 
	then
		FLOWS=8
		[ $1 -gt 999 ] && FLOWS=16
		[ $1 -gt 2999 ] && FLOWS=32
		[ $1 -gt 7999 ] && FLOWS=48
		[ $1 -gt 9999 ] && FLOWS=64
		[ $1 -gt 19999 ] && FLOWS=128
		[ $1 -gt 39999 ] && FLOWS=256
		[ $1 -gt 69999 ] && FLOWS=512
		[ $1 -gt 99999 ] && FLOWS=1024
		case $QDISC in
			codel|ns2_codel|pie|bfifo) ;;
			fq_codel|*fq_codel|sfq) echo flows $FLOWS ;;
		esac
	fi
}	

# set quantum parameter if available for this qdisc

get_quantum() {
    case $QDISC in
	*fq_codel|fq_pie|drr) echo quantum $1 ;;
	*) ;;
    esac

}

# Set some variables to handle different qdiscs
get_egress_ECN() {
	eECN_string=""
	case $QDISC in
		*codel|*pie|*red) ECN=ecn; NOECN=noecn ;;
		*) ECN=""; NOECN="" ;;
	esac

	if [ ${EGRESSECN} == "active" ];
	then
		eECN_string=${ECN}
	else
		eECN_string=${NOECN}
	fi
	#logger "eECN: ${eECN_string}"
	echo ${eECN_string}
}

get_ingress_ECN() {
	iECN_string=""
	case $QDISC in
		*codel|*pie|*red) ECN=ecn; NOECN=noecn ;;
		*) ECN=""; NOECN="" ;;
	esac

	if [ ${INGRESSECN} == "active" ];
	then
		iECN_string=${ECN}
	else
		iECN_string=${NOECN}
	fi
	#logger "iECN: ${iECN_string}"
	echo ${iECN_string}
}

#logger "EGRESSECN: ${EGRESSECN}"
#logger "INGRESSECN: ${INGRESSECN}"

#ECN="ecn"
#NOECN="noecn"

# ECN is somewhat useful but it helps to have a way
# to turn it on or off. 
# To do ECN on egress & ingress set ALLECN=1
# To not do ECN on egress & ingress set ALLECN=0
# to do ECN on ingress only set ALLECN=2 (default)


qdisc_variants() {
    if [ "$AUTOECN" -eq "1" ]
    then
    case $QDISC in
	*codel|*pie|*red) ECN=ecn; NOECN=noecn ;;
	*) ECN=""; NOECN="" ;;
    esac
    if [ "$ALLECN" -eq "1" ]
    then
        NOECN=$ECN
    fi
    if [ "$ALLECN" -eq "0" ]
    then
        ECN=$NOECN
    fi
    fi

}

qdisc_variants

# This could be a complete diffserv implementation

diffserv() {

interface=$1
prio=1

# Catchall

$TC filter add dev $interface parent 1:0 protocol all prio 999 u32 \
        match ip protocol 0 0x00 flowid 1:12

# Find the most common matches fast

fc 1:0 0x00 1:12 # BE
fc 1:0 0x20 1:13 # CS1
fc 1:0 0x10 1:11 # IMM
fc 1:0 0xb8 1:11 # EF
fc 1:0 0xc0 1:11 # CS3
fc 1:0 0xe0 1:11 # CS6
fc 1:0 0x90 1:11 # AF42 (mosh)

# Arp traffic
$TC filter add dev $interface parent 1:0 protocol arp prio $prio handle 1 fw classid 1:11
prio=$(($prio + 1))
}
