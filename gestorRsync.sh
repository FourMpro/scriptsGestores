#!/bin/bash
sel=0;
fecha=$(date +%Y-%m-%d-%H-%M-%S);
echo "$fecha - Se inicio el script gestor de rsync, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logRsync.txt

function menu(){
	echo "+---------------------+"
	echo "|  MENU GESTOR RSYNC  |"
	echo "|---------------------|"
	echo "| 1) Respaldo local   |"
	echo "| 2) Respaldo remoto  |"
	echo "|---------------------|"
	echo "| 0) SALIR DEL MENU   |"
	echo "+---------------------+"
	echo ""
	echo "Ingrese una opcion... "
}

function reslocal(){
	echo "$fecha - Se testeo un respaldo local, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logRsync.txt
        echo "REALIZANDO TESTEO..."
        sleep 1
        clear
	rsync -anv /root/respaldos /root/copiarespaldos
	echo ""
	echo "----------------------------------------"
	echo "Ingrese 1 si desea realizar el respaldo"
	echo ""
	read respuesta
	if [ $respuesta -eq 1 ]
	then
		echo "$fecha - Se realizo un respaldo rsync local, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logRsync.txt
		rsync -av /root/respaldos /root/copiarespaldos
	else
		clear
		echo "Volviendo al menu..."
		sleep 2
	fi	 
}

function resremoto(){
	echo "$fecha - Se testeo un respaldo remoto, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logRsync.txt
        echo "REALIZANDO TESTEO..."
      	sleep 1
        clear
        rsync -anv /root/respaldos root@192.168.1.23:/root/copiarespaldo
        echo ""
        echo "----------------------------------------"
        echo "Ingrese 1 si desea realizar el respaldo"
        echo ""
        read respuesta
        if [ $respuesta -eq 1 ]
       	then
		echo "$fecha - Se realizo un respaldo remoto de rsync, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logRsync.txt
                rsync -av /root/respaldos root@192.168.1.23:/root/copiarespaldo
		echo ""
		echo "--------------"
		echo "Respaldo hecho"
		sleep 2
        else
                clear
                echo "Volviendo al menu..."
                sleep 2
        fi 
}
while [ $sel -ne 3 ];
do
	clear
	menu
	read sel
	case $sel in
		1)
			clear
			echo "RESPALDO LOCAL";
			reslocal;;
		2)
			clear
			echo "RESPALDO REMOTO";
			resremoto;;
                0)
                        clear
                        echo "+*-*-*-+";
                        echo "| Chau |";
                        echo "+-*-*-*+";
                        sleep 3;
                        clear
                        break ;;
                *)
                        echo "Opcion incorrecta, vuelva a intentar";;

        esac
done

