#!/bin/sh
ADDR=`ip addr show dev br-lan | grep inet | grep -v inet6 | awk '{print $2;}' | cut -f1 -d/`
echo "Content-Type: text/html; charset=UTF-8
Pragma: no-cache
"

echo "<html><head><meta http-equiv=\"REFRESH\" content=\"0;url=http://${ADDR}:81\"></head><body>Redirecting</body></html>"
