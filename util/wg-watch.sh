#!/usr/bin/bash
# Modified from https://mullvad.net/en/help/running-wireguard-router/
# ping VPN gateway to test for connection
# if no contact, reboot!

PING=/usr/bin/ping
SERVICE=/usr/sbin/service


tries=0
while [[ $tries -lt 3 ]]
do
        if $PING -c 1 10.20.30.1
        then
                echo "wg works"
                exit 0
        fi
        echo "wg fail"
        tries=$((tries+1))
done
echo "wg failed 5 times - rebooting"
$SERVICE wg-quick@wg0-client restart