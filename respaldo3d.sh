#!/bin/bash

fecha=$(date +%Y-%m-%d-%H-%M-%S)

#MESSAGES
cp -r /var/log/messages /root/respaldos/resmessages/
tar -cvzf $fecha-messages.tar.gz /root/respaldos/resmessages/messages
rm -r /root/respaldos/resmessages/messages
mv $fecha-messages.tar.gz /root/respaldos/resmessages/

#SECURE
cp -r /var/log/secure /root/respaldos/ressecure/
tar -cvzf $fecha-secure.tar.gz /root/respaldos/ressecure/secure
rm -r /root/respaldos/ressecure/secure
mv $fecha-secure.tar.gz /root/respaldos/ressecure/

#UTMP
cp -r /var/run/utmp /root/respaldos/resutmp/
tar -cvzf $fecha-utmp.tar.gz /root/respaldos/resutmp/utmp
rm -r /root/respaldos/resutmp/utmp
mv $fecha-utmp.tar.gz /root/respaldos/resutmp/
