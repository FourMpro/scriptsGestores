#!/bin/bash

fecha=$(date +%Y-%m-%d-%H-%M-%S)

#BOOT
cp -r /var/log/boot /root/respaldos/resboot/
tar -cvzf $fecha-boot.tar.gz /root/respaldos/resboot/boot
rm -r /root/respaldos/resboot/boot
mv $fecha-boot.tar.gz /root/respaldos/resboot/

