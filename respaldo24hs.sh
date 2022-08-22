#!/bin/bash

fecha=$(date +%Y-%m-%d-%H-%M-%S)

#HTTPD
cp -r /var/log/httpd /root/respaldos/reshttpd/
tar -cvzf $fecha-httpd.tar.gz /root/respaldos/reshttpd/httpd
rm -r /root/respaldos/reshttpd/httpd
mv $fecha-httpd.tar.gz /root/respaldos/reshttpd/

#MAILLOG
cp -r /var/log/maillog /root/respaldos/resmaillog/
tar -cvzf $fecha-maillog.tar.gz /root/respaldos/resmaillog/maillog
rm -r /root/respaldos/resmaillog/maillog
mv $fecha-maillog.tar.gz /root/respaldos/resmaillog/

#SPOOLER
cp -r /var/log/spooler /root/respaldos/resspooler/
tar -cvzf $fecha-spooler.tar.gz /root/respaldos/resspooler/spooler
rm -r /root/respaldos/resspooler/spooler
mv $fecha-spooler.tar.gz /root/respaldos/resspooler/

#WTMP
cp -r /var/log/wtmp /root/respaldos/reswtmp/
tar -cvzf $fecha-wtmp.tar.gz /root/respaldos/reswtmp/wtmp
rm -r /root/respaldos/reswtmp/wtmp
mv $fecha-wtmp.tar.gz /root/respaldos/reswtmp/


#LASTLOG
cp -r /var/log/lastlog /root/respaldos/reslastlog/
tar -cvzf $fecha-lastlog.tar.gz /root/respaldos/reslastlog/lastlog
rm -r /root/respaldos/reslastlog/lastlog
mv $fecha-lastlog.tar.gz /root/respaldos/reslastlog/
