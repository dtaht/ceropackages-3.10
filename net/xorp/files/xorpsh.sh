#!/bin/sh

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/lib/xorp/bin:/usr/lib/xorp/sbin
export LD_LIBRARY_PATH=/usr/lib/xorp/lib

exec ${0}.bin $*

