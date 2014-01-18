#!/bin/sh
echo "Content-Type: text/html; charset=UTF-8
Pragma: no-cache
"

echo "<html><head><meta http-equiv=\"REFRESH\" content=\"0;url=https://${SERVER_NAME}:81\"></head><body>Redirecting</body></html>"
