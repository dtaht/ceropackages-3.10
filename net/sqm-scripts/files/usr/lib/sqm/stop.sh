#!/bin/sh

. /usr/lib/sqm/functions.sh

sqm_stop() {
	tc qdisc del dev $IFACE ingress 2> /dev/null
	tc qdisc del dev $IFACE root 2> /dev/null
	tc qdisc del dev $DEV root 2> /dev/null
}

ipt_stop() {
	ipt -t mangle -D POSTROUTING -o $DEV -m mark --mark 0x00 -g QOS_MARK_${IFACE} 
	ipt -t mangle -D POSTROUTING -o $IFACE -m mark --mark 0x00 -g QOS_MARK_${IFACE} 
	ipt -t mangle -D PREROUTING -i vtun+ -p tcp -j MARK --set-mark 0x2
	ipt -t mangle -D OUTPUT -p udp -m multiport --ports 123,53 -j DSCP --set-dscp-class AF42
	ipt -t mangle -F QOS_MARK_${IFACE}
	ipt -t mangle -X QOS_MARK_${IFACE}
}


sqm_stop
ipt_stop