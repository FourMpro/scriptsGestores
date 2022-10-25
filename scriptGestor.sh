#!/bin/bash
sel=0
fecha=$(date +%Y-%m-%d-%H-%M-%S);
echo "$fecha - Se inicio el script gestor de menus, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logMenu.txt

function menu(){
        echo "+-----------------------------+"
        echo "|        MENU DE MENUS        |"
        echo "|-----------------------------|"
        echo "| 1) Gestor de usuarios       |"
        echo "| 2) Gestor de grupos         |"
        echo "| 3) Gestor de redes          |"
        echo "| 4) Gestor de resplados      |"
	echo "| 5) Respaldo manual          |"
	echo "| 6) Editar script firewall   |"
	echo "| 7) Gestor base de datos     |"
	echo "| 8) Gestor de rsync          |"
	echo "| 9) Visualizador de logs     |"
	echo "|-----------------------------|"   
        echo "| 0) SALIR DEL MENU           |"
        echo "+-----------------------------+"
        echo ""
        echo "Seleccione una opcion... "   
}

while [ $sel -ne 10 ];
do
        clear
        menu
        read sel
        case $sel in
		1)
                        clear
                        echo "GESTOR DE USUARIOS"
                        sh scripts/usuarios.sh;;
		2)
			clear
			echo "GESTOR DE GRUPOS"
			sh scripts/grupos.sh;;
		3)
			clear
			echo "GESTOR DE REDES"
			sh scripts/redes.sh;;
		4)
			clear
			echo "GESTOR DE RESPALDOS"
			sh scripts/respaldos.sh;;
		5)
			clear
			echo "RESPALDO MANUAL"
			sh scripts/gestorRespaldo.sh;;
		6)
			clear
			echo "FIREWALL"
			sh scripts/firewall.sh;;
		7)	
			clear
			echo "BASE DE DATOS"
			sh scripts/respaldoBD.sh;;
                8)
                        clear
                        echo "RSYNC"
                        sh scripts/gestorRsync.sh;;
                9)
                        clear
                        echo "LOGS"
                        sh scripts/visualizadorLogs.sh;;
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
