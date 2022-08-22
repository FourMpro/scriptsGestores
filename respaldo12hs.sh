#!/bin/bash

fecha=$(date +%Y-%m-%d-%H-%M-%S)

#CRON
cp -r /var/log/cron /root/respaldos/rescron/
tar -cvzf $fecha-cron.tar.gz /root/respaldos/rescron/cron
rm -r /root/respaldos/rescron/cron
mv $fecha-cron.tar.gz /root/respaldos/rescron/

#MARIADB
cp -r /var/log/mariadb /root/respaldos/resmariadb/
tar -cvzf $fecha-mariadb.tar.gz /root/respaldos/resmariadb/mariadb
rm -r /root/respaldos/resmariadb/mariadb
mv $fecha-mariadb.tar.gz /root/respaldos/resmariadb/

#BTMP
cp -r /var/log/btmp /root/respaldos/resbtmp/
tar -cvzf $fecha-btmp.tar.gz /root/respaldos/resbtmp/btmp
rm -r /root/respaldos/resbtmp/btmp
mv $fecha-btmp.tar.gz /root/respaldos/resbtmp/

