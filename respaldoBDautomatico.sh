#!/bin/bash
fecha=$(date +%Y-%m-%d-%H-%M-%S)

mysqldump --opt --events --triggers --default-character-set=utf8 -u root -proot SIGD | gzip -c > $fecha-SIGD-completo.sql.gz
mv $fecha-SIGD-completo.sql.gz /root/respaldos/respaldobd/

