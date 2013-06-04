insmod() {
  lsmod | grep -q ^$1 || /sbin/insmod $1
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

[ -z "$UPLINK" ] && UPLINK=4000
[ -z "$DOWNLINK" ] && DOWNLINK=20000
[ -z "$DEV" ] && DEV=ifb0
[ -z "$QDISC" ] && QDISC=fq_codel
[ -z "$IFACE" ] && IFACE=ge00
[ -z "$ADSL" ] && ADSL=0
[ -z "$AUTOFLOW" ] && AUTOFLOW=0
[ -z "$AUTOECN" ] && AUTOECN=1

TC=/usr/sbin/tc
CEIL=$UPLINK
ADSLL=""

if [ "$ADSL" == "1" ] 
then
	OVERHEAD=40
	LINKLAYER=adsl
	ADSLL="linklayer ${LINKLAYER} overhead ${OVERHEAD}"
fi

aqm_stop() {
	tc qdisc del dev $IFACE ingress
	tc qdisc del dev $IFACE root
	tc qdisc del dev $DEV root
}

# Note this has side effects on the prio variable
# and depends on the interface global too

fc() {
tc filter add dev $interface protocol ip parent $1 prio $prio u32 match ip tos $2 0xfc classid $3
prio=$(($prio + 1))
tc filter add dev $interface protocol ipv6 parent $1 prio $prio u32 match ip6 priority $2 0xfc classid $3
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
	if [ "$AUTOFLOW" == 1 ] 
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
		codel|ns2_codel|pie) ;;
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

ECN=""
NOECN=""

# ECN is somewhat useful but it helps to have a way
# to turn it on or off. Note we never do ECN on egress currently.

qdisc_variants() {
    if [ "$AUTOECN" == 1 ]
    then
    case $QDISC in
	*codel|pie) ECN=ecn; NOECN=noecn ;;
	*) ;;
    esac
    fi
}

qdisc_variants

# This could be a complete diffserv implementation

diffserv() {

interface=$1
prio=1

# Catchall

tc filter add dev $interface parent 1:0 protocol all prio 999 u32 \
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
tc filter add dev $interface parent 1:0 protocol arp prio $prio handle 1 fw classid 1:11
prio=$(($prio + 1))
}
