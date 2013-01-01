#!/bin/sh
# Cake
# A 3 bin tc_codel and ipv6 enabled shaping script for
# ethernet gateways, using the cake shaper
# Copyright (C) 2012 Michael D Taht
# GPLv2
# You need to jiggle these parameters. Note limits are tuned towards a <10Mbit uplink <60Mbup down

UPLINK=2000
DOWNLINK=20000
DEV=ifb0
QDISC=cake
IFACE=ge00
TC=/usr/sbin/tc

CEIL=$UPLINK
MTU=1500
ADSLL=""
# PPOE=yes

# You shouldn't need to touch anything after this

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

# With cake no classification is explicitly needed

ipt_setup() {

#ipt -t mangle -A POSTROUTING -o $DEV -m mark --mark 0x00 -g QOS_MARK 
#ipt -t mangle -A POSTROUTING -o $IFACE -m mark --mark 0x00 -g QOS_MARK 
#ipt -t mangle -A PREROUTING -i s+ -p tcp -m tcp --tcp-flags SYN,RST,ACK SYN -j MARK --set-mark 0x01
# Not sure if this will work. Encapsulation is a problem period
#ipt -t mangle -A PREROUTING -i vtun+ -p tcp -j MARK --set-mark 0x2 # tcp tunnels need ordering

# Emanating from router, do a little more optimization
# but don't bother with it too much. 

#ipt -t mangle -A OUTPUT -p udp -m multiport --ports 123,53 -j DSCP --set-dscp-class AF42

#Not clear if the second line is needed
#ipt -t mangle -A OUTPUT -o $IFACE -g QOS_MARK

}


# TC rules

egress() {
insmod sch_htb

CEIL=${UPLINK}
R2Q=""

if [ "$CEIL" -lt 1000 ]
then
	R2Q="rtq 1"
fi

tc qdisc del dev $IFACE root
tc qdisc add dev $IFACE root handle 1: htb ${RTQ} default 12
tc class add dev $IFACE parent 1: classid 1:1 htb rate ${CEIL}kbit ceil ${CEIL}kbit $ADSLL
tc class add dev $IFACE parent 1:1 classid 1:12 htb rate ${CEIL}kbit ceil ${CEIL}kbit prio 0 $ADSLL

tc qdisc add dev $IFACE parent 1:12 handle 120: $QDISC limit 600 noecn

}

ingress() {

CEIL=${DOWNLINK}

R2Q=""

tc qdisc del dev $IFACE handle ffff: ingress
tc qdisc add dev $IFACE handle ffff: ingress
 
tc qdisc del dev $DEV root 
tc qdisc add dev $DEV root handle 1: htb ${RTQ} default 12
tc class add dev $DEV parent 1: classid 1:1 htb rate ${CEIL}kibit ceil ${CEIL}kibit $ADSLL
tc class add dev $DEV parent 1:1 classid 1:12 htb rate ${BE_RATE}kibit ceil ${BE_CEIL}kibit prio 2 $ADSLL

tc qdisc add dev $DEV parent 1:12 handle 120: $QDISC limit 1000 ecn

diffserv

ifconfig ifb0 up

# redirect all IP packets arriving in $IFACE to ifb0 

$TC filter add dev $IFACE parent ffff: protocol all prio 10 u32 \
  match u32 0 0 flowid 1:1 action mirred egress redirect dev $DEV

}

ipt_setup
egress 
ingress

# References:
# This alternate shaper attempts to go for 1/u performance in a clever way
# http://git.coverfire.com/?p=linux-qos-scripts.git;a=blob;f=src-3tos.sh;hb=HEAD

# Comments
# This does the right thing with ipv6 traffic.

# Flaws
# Many!
