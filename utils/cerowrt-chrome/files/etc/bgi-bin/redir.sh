#!/bin/sh
echo -e "Content-Type: text/html; charset=UTF-8\nPragma: no-cache\n"
S=`echo ${SERVER_NAME} | sed 's/:/ /g'`

if [ "${S}" != "${SERVER_NAME}" ]
then
echo "<html><head><meta http-equiv=\"REFRESH\" content=\"0;url=https://[${SERVER_NAME}]:81\"></head><body>Redirecting</body></html>"
else
echo "<html><head><meta http-equiv=\"REFRESH\" content=\"0;url=https://${SERVER_NAME}:81\"></head><body>Redirecting</body></html>"
fi

