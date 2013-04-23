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
