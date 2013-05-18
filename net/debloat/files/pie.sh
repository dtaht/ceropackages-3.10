#!/bin/sh
# Cero3 Shaper
# A 3 bin tc_codel and ipv6 enabled shaping script for
# ethernet gateways, with an eye towards working well
# with wireless with uplinks in the 2Mbit to 25Mbit 
# range. It ain't done yet, and is cerowrt specific
# in that it depends on clearly identifying the
# internal interfaces via a pattern match.

# Copyright (C) 2012 Michael D Taht
# GPLv2

# Compared to the complexity that debloat had become
# this cleanly shows a means of going from diffserv marking
# to prioritization using the current tools (ip(6)tables
# and tc. I note that the complexity of debloat exists for
# a reason, and it is expected that script is run first
# to setup various other parameters such as BQL and ethtool.
# (And that the debloat script has setup the other interfaces)

# You need to jiggle these parameters. Note limits are tuned towards a <10Mbit uplink <60Mbup down

UPLINK=2000
DOWNLINK=20000
DEV=ifb0
QDISC=pie # pie
IFACE=ge00
DEPTH=42
TC=~d/git/iproute2/tc/tc
FLOWS=8000
PERTURB="perturb 0" # Permutation is costly, disable
FLOWS=16000 # 
BQL_MAX=3000 # it is important to factor this into the RED calc

CEIL=$UPLINK
MTU=1500
ADSLL=""
# PPOE=yes

#config interface ge00
#        option classgroup  "Default"
#        option enabled      0
#        option upload       128
#        option download     1024

# uci get aqm.enable
#
# You shouldn't need to touch anything here  

if [ -s "$PPOE" ] 
then
	OVERHEAD=40
	LINKLAYER=adsl
	ADSLL="linklayer ${LINKLAYER} overhead ${OVERHEAD}"
fi

ipt() {
iptables $*
ip6tables $*
}

do_modules() {

insmod sch_$QDISC
insmod sch_ingress
insmod act_mirred
insmod cls_fw
insmod sch_htb

}

fc() {
PARENT=$1
TOS=$2
CLASSID=$3
tc filter add dev $interface protocol ip parent $PARENT prio $prio u32 match ip tos $TOS 0xfc classid $CLASSID
prio=$(($prio + 1))
tc filter add dev $interface protocol ipv6 parent $PARENT prio $prio u32 match ip6 priority $TOS 0xfc classid $CLASSID
prio=$(($prio + 1))
}

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


ipt_setup() {

ipt -t mangle -F
ipt -t mangle -N QOS_MARK

ipt -t mangle -A QOS_MARK -j MARK --set-mark 0x2
# You can go further with classification but...
ipt -t mangle -A QOS_MARK -m dscp --dscp-class CS1 -j MARK --set-mark 0x3
ipt -t mangle -A QOS_MARK -m dscp --dscp-class CS3 -j MARK --set-mark 0x1
ipt -t mangle -A QOS_MARK -m dscp --dscp-class CS6 -j MARK --set-mark 0x1
ipt -t mangle -A QOS_MARK -m dscp --dscp-class EF -j MARK --set-mark 0x1
ipt -t mangle -A QOS_MARK -m dscp --dscp-class AF42 -j MARK --set-mark 0x1
ipt -t mangle -A QOS_MARK -m tos --tos Minimize-Delay -j MARK --set-mark 0x1

# and it might be a good idea to do it for udp tunnels too

# Turn it on. Preserve classification if already performed

ipt -t mangle -A POSTROUTING -o $DEV -m mark --mark 0x00 -g QOS_MARK 
ipt -t mangle -A POSTROUTING -o $IFACE -m mark --mark 0x00 -g QOS_MARK 

# The Syn optimization was nice but fq_codel does it for us
# ipt -t mangle -A PREROUTING -i s+ -p tcp -m tcp --tcp-flags SYN,RST,ACK SYN -j MARK --set-mark 0x01
# Not sure if this will work. Encapsulation is a problem period
ipt -t mangle -A PREROUTING -i vtun+ -p tcp -j MARK --set-mark 0x2 # tcp tunnels need ordering

# Emanating from router, do a little more optimization
# but don't bother with it too much. 

ipt -t mangle -A OUTPUT -p udp -m multiport --ports 123,53 -j DSCP --set-dscp-class AF42

#Not clear if the second line is needed
#ipt -t mangle -A OUTPUT -o $IFACE -g QOS_MARK

}


# TC rules

egress() {

CEIL=${UPLINK}
PRIO_RATE=`expr $CEIL / 3` # Ceiling for prioirty
BE_RATE=`expr $CEIL / 6`   # Min for best effort
BK_RATE=`expr $CEIL / 9`   # Min for background
BE_CEIL=`expr $CEIL - 64`  # A little slop at the top

R2Q=""

if [ "$CEIL" -lt 1000 ]
then
	R2Q="rtq 1"
fi

tc qdisc del dev $IFACE root
tc qdisc add dev $IFACE root handle 1: htb ${RTQ} default 12
tc class add dev $IFACE parent 1: classid 1:1 htb rate ${CEIL}kbit ceil ${CEIL}kbit $ADSLL
tc class add dev $IFACE parent 1:1 classid 1:10 htb rate ${CEIL}kbit ceil ${CEIL}kbit prio 0 $ADSLL
tc class add dev $IFACE parent 1:1 classid 1:11 htb rate 128kbit ceil ${PRIO_RATE}kbit prio 1 $ADSLL
tc class add dev $IFACE parent 1:1 classid 1:12 htb rate ${BE_RATE}kbit ceil ${BE_CEIL}kbit prio 2 $ADSLL
tc class add dev $IFACE parent 1:1 classid 1:13 htb rate ${BK_RATE}kbit ceil ${BE_CEIL}kbit prio 3 $ADSLL

$TC qdisc add dev $IFACE parent 1:11 handle 110: $QDISC limit 600 noecn
$TC qdisc add dev $IFACE parent 1:12 handle 120: $QDISC limit 600 noecn
$TC qdisc add dev $IFACE parent 1:13 handle 130: $QDISC limit 600 noecn

tc filter add dev $IFACE parent 1:0 protocol ip prio 1 handle 1 fw classid 1:11
tc filter add dev $IFACE parent 1:0 protocol ip prio 2 handle 2 fw classid 1:12
tc filter add dev $IFACE parent 1:0 protocol ip prio 3 handle 3 fw classid 1:13

# ipv6 support. Note that the handle indicates the fw mark bucket that is looked for

tc filter add dev $IFACE parent 1:0 protocol ipv6 prio 4 handle 1 fw classid 1:11
tc filter add dev $IFACE parent 1:0 protocol ipv6 prio 5 handle 2 fw classid 1:12
tc filter add dev $IFACE parent 1:0 protocol ipv6 prio 6 handle 3 fw classid 1:13

# Arp traffic

tc filter add dev $IFACE parent 1:0 protocol arp prio 7 handle 1 fw classid 1:11

}

ingress() {

CEIL=$DOWNLINK
PRIO_RATE=`expr $CEIL / 3` # Ceiling for prioirty
BE_RATE=`expr $CEIL / 3`   # Min for best effort
BK_RATE=`expr $CEIL / 6`   # Min for background
BE_CEIL=`expr $CEIL - 64`  # A little slop at the top

R2Q=""

tc qdisc del dev $IFACE handle ffff: ingress
tc qdisc add dev $IFACE handle ffff: ingress
 
tc qdisc del dev $DEV root 
tc qdisc add dev $DEV root handle 1: htb ${RTQ} default 12
tc class add dev $DEV parent 1: classid 1:1 htb rate ${CEIL}kbit ceil ${CEIL}kibit $ADSLL
tc class add dev $DEV parent 1:1 classid 1:10 htb rate ${CEIL}kbit ceil ${CEIL}kibit prio 0 $ADSLL
tc class add dev $DEV parent 1:1 classid 1:11 htb rate 32kbit ceil ${PRIO_RATE}kibit prio 1 $ADSLL
tc class add dev $DEV parent 1:1 classid 1:12 htb rate ${BE_RATE}kbit ceil ${BE_CEIL}kibit prio 2 $ADSLL
tc class add dev $DEV parent 1:1 classid 1:13 htb rate ${BK_RATE}kbit ceil ${BE_CEIL}kibit prio 3 $ADSLL

# I'd prefer to use a pre-nat filter but that causes permutation...

$TC qdisc add dev $DEV parent 1:11 handle 110: $QDISC limit 1000 ecn
$TC qdisc add dev $DEV parent 1:12 handle 120: $QDISC limit 1000 ecn
$TC qdisc add dev $DEV parent 1:13 handle 130: $QDISC limit 1000 ecn

diffserv ifb0

ifconfig ifb0 up

# redirect all IP packets arriving in $IFACE to ifb0 

$TC filter add dev $IFACE parent ffff: protocol all prio 10 u32 \
  match u32 0 0 flowid 1:1 action mirred egress redirect dev $DEV

}

do_modules
ipt_setup
egress 
ingress

# References:
# This alternate shaper attempts to go for 1/u performance in a clever way
# http://git.coverfire.com/?p=linux-qos-scripts.git;a=blob;f=src-3tos.sh;hb=HEAD

# Comments
# This does the right thing with ipv6 traffic.
# It also does not rehash with sfq skewing streams
# It also tries to leverage diffserv to some sane extent. In particular,
# the 'priority' queue is limited to 33% of the total, so EF, and IMM traffic
# cannot starve other types. The rfc suggested 30%. 30% is probably
# a lot in today's world.

# Flaws
# Many!

# Why 42?
# Lucky number.
# the sum of the number of packets here + htb + the ar71xx device driver
# ~= 50 the core number used by theorists everywhere.

