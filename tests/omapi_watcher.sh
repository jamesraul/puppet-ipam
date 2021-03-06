#!/usr/bin/env bash
exec &>> $HOME/omapi_watcher.log
if [ -e /var/log/messages ]; then
  SYSLOG_PATH=/var/log/messages
  NAMED_PATH=/etc/named
elif [ -e /var/log/syslog ]
then
  SYSLOG_PATH=/var/log/syslog
  NAMED_PATH=/etc/bind
else
  echo "!!!!!!!!!! No Logfiles Detected !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  exit
fi

echo "!!!!!!!!!! Detected /var/log/messages !!!!!!!!!!!!!!!!!!!!!!!!"
echo "?????????? Watching for OMAPI Protocol failure ???????????????????????"
tail -f ${SYSLOG_PATH} | grep --line-buffered -Ei "Can't start OMAPI protocol: address not available" -m 1 &

echo "?????????? Checking for DyN DNS ??????????????????????????????"
tail -f ${SYSLOG_PATH} | grep --line-buffered -Ei 'generating session key for dynamic DNS' -m 2 &

echo "?????????? Checking for Key Access ??????????????????????????????"
# tail -f ${SYSLOG_PATH} | grep --line-buffered -Ei "dhcpd: Can't open ${NAMED_PATH}/bind.keys.d/dhcpupdater.key: No such file or directory" -m 1 &
tail -f ${SYSLOG_PATH} | grep --line-buffered -Ei "dhcpd: Can't open ${NAMED_PATH}/bind.keys.d/omapi.key: No such file or directory" -m 1 &
