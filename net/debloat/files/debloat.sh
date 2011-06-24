
# debloat.sh - utilities for debloating interfaces
# Copyright (c) 2010 OpenWrt.org
ethtool=`which ethtool`

link_state() {
	local IFACE=$1
	local SPEED DUPLEX STATE
	[ -s $ethtool ] && {
	$ethtool $IFACE | egrep 'Speed:|Duplex|Link State' | 
		while read x
		do
			case $x in
			Speed:*)  SPEED=`echo $x | cut -f2 -d: | awk '{print $1}'` ;;
			Duplex:*) DUPLEX=`echo $x | cut -f2 -d: | awk '{print $1}'` ;;
			Link*)    STATE=`echo $x | cut -f2 -d: | awk '{print $1}'` ;;
			esac
		done
#FIXME: Translate unknown into sane values
#FIXME: Translate duplex into half speed

	echo $SPEED $DUPLEX $STATE
	}
}


link_state eth0
