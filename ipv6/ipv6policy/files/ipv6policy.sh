# ipv6policy.sh - rfc
# Copyright (c) 2012 OpenWrt.org

# This code is nowhere near done yet
# Get default device (ge00)

find_ethernet_device() {
	for i in /sys/class/net/*
	do
	done
}

rfc34193() {
	local dev=`find_ethernet_device`
	generate_rfc3193 $dev
}

get_ula() {
	config_get ipv6policy ula
	if enable
	[ "$net" == "" ] && net=`rfc4193` 
	if disable
	config_get network
}

get_6to4() {
	config_get ipv6policy ula
}

get_pd() {
}


