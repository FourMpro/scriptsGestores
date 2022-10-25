#!/bin/bash
sel=0
fecha=$(date +%Y-%m-%d-%H-%M-%S-MANUAL)
fecha2=$(date +%Y-%m-%d-%H-%M-%S)
echo "$fecha2 - Se inicio el script de GestorRespaldos, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logGestor.txt

function menu(){
	echo "+-------------------+"
	echo "|  RESPALDO MANUAL  |"
	echo "|-------------------|"
	echo "| 1) Cron           |"
	echo "| 2) MariaDB        |"
	echo "| 3) Btmp           |"
	echo "| 4) Httpd          |"
	echo "| 5) Maillog        |"
	echo "| 6) Spooler        |"
	echo "| 7) Wtmp           |"
	echo "| 8) Lastlog        |"
	echo "| 9) Messages       |"
	echo "| 10) Secure        |"
	echo "| 11) Utmp          |"
	echo "|-------------------|"
	echo "| 0) SALIR DEL MENU |"
	echo "+-------------------+"
	echo ""
	echo "Ingrese una opcion..."		  
}

function cron {
cp -r /var/log/cron /root/respaldos/rescron/
tar -cvzf $fecha-cron.tar.gz /root/respaldos/rescron/cron
rm -r /root/respaldos/rescron/cron
mv $fecha-cron.tar.gz /root/respaldos/rescron/
}

function mariadb {
cp -r /var/log/mariadb /root/respaldos/resmariadb/
tar -cvzf $fecha-mariadb.tar.gz /root/respaldos/resmariadb/mariadb
rm -r /root/respaldos/resmariadb/mariadb
mv $fecha-mariadb.tar.gz /root/respaldos/resmariadb/
}

function btmp {
cp -r /var/log/btmp /root/respaldos/resbtmp/
tar -cvzf $fecha-btmp.tar.gz /root/respaldos/resbtmp/btmp
rm -r /root/respaldos/resbtmp/btmp
mv $fecha-btmp.tar.gz /root/respaldos/resbtmp/

}

function httpd {
cp -r /var/log/httpd /root/respaldos/reshttpd/
tar -cvzf $fecha-httpd.tar.gz /root/respaldos/reshttpd/httpd
rm -r /root/respaldos/reshttpd/httpd
mv $fecha-httpd.tar.gz /root/respaldos/reshttpd/
}

function maillog {
cp -r /var/log/maillog /root/respaldos/resmaillog/
tar -cvzf $fecha-maillog.tar.gz /root/respaldos/resmaillog/maillog
rm -r /root/respaldos/resmaillog/maillog
mv $fecha-maillog.tar.gz /root/respaldos/resmaillog/
}

function spooler {
cp -r /var/log/spooler /root/respaldos/resspooler/
tar -cvzf $fecha-spooler.tar.gz /root/respaldos/resspooler/spooler
rm -r /root/respaldos/resspooler/spooler
mv $fecha-spooler.tar.gz /root/respaldos/resspooler/
}

function wtmp {
cp -r /var/log/wtmp /root/respaldos/reswtmp/
tar -cvzf $fecha-wtmp.tar.gz /root/respaldos/reswtmp/wtmp
rm -r /root/respaldos/reswtmp/wtmp
mv $fecha-wtmp.tar.gz /root/respaldos/reswtmp/

}

function lastlog {
cp -r /var/log/lastlog /root/respaldos/reslastlog/
tar -cvzf $fecha-lastlog.tar.gz /root/respaldos/reslastlog/lastlog
rm -r /root/respaldos/reslastlog/lastlog
mv $fecha-lastlog.tar.gz /root/respaldos/reslastlog/
}

function messages {
cp -r /var/log/messages /root/respaldos/resmessages/
tar -cvzf $fecha-messages.tar.gz /root/respaldos/resmessages/messages
rm -r /root/respaldos/resmessages/messages
mv $fecha-messages.tar.gz /root/respaldos/resmessages/

}

function secure {
cp -r /var/log/secure /root/respaldos/ressecure/
tar -cvzf $fecha-secure.tar.gz /root/respaldos/ressecure/secure
rm -r /root/respaldos/ressecure/secure
mv $fecha-secure.tar.gz /root/respaldos/ressecure/
}

function utmp {
cp -r /var/run/utmp /root/respaldos/resutmp/
tar -cvzf $fecha-utmp.tar.gz /root/respaldos/resutmp/utmp
rm -r /root/respaldos/resutmp/utmp
mv $fecha-utmp.tar.gz /root/respaldos/resutmp/
}

while [ $sel -ne 12 ];
do
	clear
	menu
	read sel
	case $sel in
		1)
			clear
			echo "RESPALDO CRON HECHO";
			sleep 1;
			cron;;
		2)
			clear
			echo "RESPALDO MARIADB HECHO";
			sleep 1;
			mariadb;;
                3)
                        clear
                        echo "RESPALDO BTMP HECHO";
			sleep 1;
                        btmp;;
                4)
                        clear
                        echo "RESPALDO HTTPD HECHO";
			sleep 1;
                        httpd;;
                5)
                        clear
                        echo "RESPALDO MAILLOG HECHO";
			sleep 1;
                        maillog;;
                6)
                        clear
                        echo "RESPALDO SPOOLER HECHO";
			sleep 1;
                        spooler;;
                7)
                        clear
                        echo "RESPALDO WTMP HECHO";
			sleep 1;
                        wtmp;;
                8)
                        clear
                        echo "RESPALDO LASTLOG HECHO";
			sleep 1;
                        lastlog;;
                9)
                        clear
                        echo "RESPALDO MESSAGES HECHO";
			sleep 1;
                        messages;;
                10)
                        clear
                        echo "RESPALDO SECURE HECHO";
			sleep 1;
                        secure;;
                11)
                        clear
                        echo "RESPALDO UTMP HECHO";
			sleep 1;
                        utmp;;
                0)
                        clear
                        echo "+*-*-*-*-*-*-*-*-*-*-*-*-*-*-*+";
                        echo "| Volviendo al menu principal |";
                        echo "+-*-*-*-*-*-*-*-*-*-*-*-*-*-*-+";
                        sleep 2;
                        clear
                        break ;;
                *)
                        echo "Opcion incorrecta, vuelva a intentar";;
        esac

done
