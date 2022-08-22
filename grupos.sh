#!/bin/bash
#variables globales
sel=0;

function menu(){
        echo "+----------------------------+"
        echo "| MENU GESTOR DE GRUPOS      |"
        echo "|----------------------------|"
        echo "| 1) Agregar grupos          |"
        echo "| 2) Listar grupos           |"
        echo "| 3) Buscar grupos           |"
        echo "| 4) Borrar grupos           |" 
        echo "| 5) Bloquear grupos         |"
        echo "| 6) Desbloquear grupos      |"
        echo "| 0) SALIR DEL MENU          |"
        echo "+----------------------------+"
        echo ""
        echo "Ingrese una opcion... "   
}

function altaGrupo(){
	clear
	echo "Ingrese el nombre de grupo: "
	read nombre
	existeGrupo=$(cat /etc/group | grep -c $nombre)
	if [ $existeGrupo -eq 1 ]; then
		echo "El grupo ya existe, presione enter para continuar"
		read a
	else
		groupadd $nombre
		echo "El grupo se ha creado";	
	fi
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s

}

function listarGrupos(){
	echo "LISTA DE GRUPOS"
	cut -d ":" -f 1 /etc/group
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function buscarGrupos(){
	clear
	echo "Ingrese el nombre del grupo: "
	read nombre
	existeGrupo=$(cat /etc/group | grep -c $nombre)
	if [ $existeGrupo -eq 1 ]; then
		echo "El grupo existe"
		nomb=$(cut -d ":" -f 1 /etc/group | grep $nombre)
		echo "NOMBRE: " $nomb
		read a
	else
		echo "El grupo no existe en el sistema"
		echo "Presione enter para continuar"
		read a
	fi
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function borrarGrupo(){
	echo "LISTA DE GRUPO";
	echo "------------------------------------------------------";
        cut -d ":" -f 1 /etc/group
	echo "------------------------------------------------------";
	echo "";
	echo "¿Que grupo desea borrar?";
	read delgrupo
	groupdel $delgrupo
	clear
	echo "Grupo eliminado..."
	echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function bloquearGrupo(){
	echo "LISTA DE GRUPOS";
        echo "------------------------------------------------------";
        cut -d ":" -f 1 /etc/group
        echo "------------------------------------------------------";
        echo "";
        echo "¿Que grupo desea bloquear?";
        read lockgroup
        groupmod --lock $lockgroup
        clear
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function desbloquearGrupo(){
        echo "LISTA DE GRUPOS";
        echo "------------------------------------------------------";
        cut -d ":" -f 1 /etc/group
        echo "------------------------------------------------------";
        echo "";
        echo "¿Que grupo desea desbloquear?";
        read unlockgroup
        groupmod --unlock $unlockgroup
        clear
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

while [ $sel -ne 8 ];
do
	clear
	menu
	read sel
	case $sel in 
		1)
			clear 
			echo "AGREGAR GRUPO";
			altaGrupo;;
		2)
			clear
			echo "LISTA DE GRUPOS";
			listarGrupos;;
		3)
			clear
			echo "BUSCAR GRUPOS";
			buscarGrupos;;
		4)
			clear
			echo "BORRAR GRUPO";
			borrarGrupo;;
                5)
                        clear
                        echo "BLOQUEAR GRUPO";
                        bloquearGrupo;;
                6)
                        clear
                        echo "DESBLOQUEAR GRUPO";
                        desbloquearGrupo;;
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
