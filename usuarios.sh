#!/bin/bash
#variables globales
sel=0;
fecha=$(date +%Y-%m-%d-%H-%M-%S);
echo "$fecha - Se inicio el script de gestion de usuarios, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logUsuarios.txt

function menu(){
        echo "+----------------------------+"
        echo "| MENU GESTOR DE USUARIOS    |"
        echo "|----------------------------|"
        echo "| 1) Agregar usuario         |"
        echo "| 2) Listar usuarios         |"
        echo "| 3) Buscar usuarios         |"
        echo "| 4) Borrar usuarios         |" 
        echo "| 5) Bloquear usuario        |"
        echo "| 6) Desbloquear usuario     |"
        echo "| 7) Cambiar contraseña      |"
        echo "| 0) SALIR DEL MENU          |"
        echo "+----------------------------+"
        echo ""
        echo "Ingrese una opcion... "   
}

function altaUsuarios(){
	clear
	echo "Ingrese el nombre de usuario: "
	read nombre
	existeUsuario=$(cat /etc/passwd | grep -c $nombre)
	if [ $existeUsuario -eq 1 ]; then
		echo "El usuario ya existe, presione enter para continuar"
		echo ""
		echo "$fecha - Hubo un intento de creación de usuario con el nombre $nombre, pero este usuario ya existe en /etc/passwd" >> /root/respaldos/logsGestor/logUsuarios.txt
		read a
	else
		echo "Ingrese el nombre del grupo"
		echo ""
		read grupo
		existeGrupo=$(cat /etc/group | grep -c $grupo)
		if [ $existeGrupo -eq 1 ]; then
			echo "Ingrese el comentario del usuario: "
			read comentario
			useradd -g $grupo -d /home/$nombre -m -c $comentario -s /bin/bash $nombre
			passwd -e -d $nombre
			echo "$fecha - Se creo satisfactoriamente el usuario $usuario con el grupo $grupo y comentario $comentario" >> /root/respaldos/logsGestor/logUsuarios.txt
		else
			echo "El grupo no existe, no se puede agregar el usuario"
			echo ""
			echo "$fecha - Hubo un intento de creación de usuario con el nombre $nombre dentro del grupo $grupo, pero el grupo no existe" >> /root/respaldos/logsGestor/logUsuarios.txt
		fi	
	fi
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s

}

function listarUsuarios(){
	echo "LISTA DE USUARIOS"
	cut -d ":" -f 1 /etc/passwd
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
		echo "$fecha - Se visualizo la lista de usuarios" >> /root/respaldos/logsGestor/logUsuarios.txt
}

function buscarUsuarios(){
	clear
	echo "Ingrese el nombre de usuario: "
	read nombre
	existeUsuario=$(cat /etc/passwd | grep -c $nombre)
	if [ $existeUsuario -eq 1 ]; then
		echo "El usuario existe"
		nomb=$(cut -d ":" -f 1 /etc/passwd | grep $nombre)
		coment=$(cut -d ":" -f 5 /etc/passwd | grep $nombre)
		homeTrabajo=$(cut -d ":" -f 6 /etc/passwd | grep $nombre)
		echo "NOMBRE: " $nomb
		echo "COMENTARIO: " $coment
		echo "HOME DE TRABAJO: " $homeTrabajo
		echo "$fecha - Se realizo una busqueda del usuario $usuario" >> /root/respaldos/logsGestor/logUsuarios.txt
		read a
	else
		echo "El usuario no existe en el sistema"
		echo "Presione enter para continuar"
		echo "$fecha - Hubo un intento de busqueda de usuario, pero el $nombre no existe" >> /root/respaldos/logsGestor/logUsuarios.txt
		read a
	fi
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function borrarUsuario(){
	echo "LISTA DE USUARIOS";
	echo "------------------------------------------------------";
        cut -d ":" -f 1 /etc/passwd
	echo "------------------------------------------------------";
	echo "";
	echo "¿Que usuario desea borrar?";
	echo "";
	read delusuario
	clear
	echo "+------------------------------+"
        echo "|¿Que tipo de baja desea hacer?|";
        echo "+------------------------------+";
        echo "|1- Logica                     |";
        echo "|2- Fisica                     |";
        echo "|0- Cancelar                   |";
	echo "+------------------------------*";
        echo "";
	read tipobaja
        clear
	while [ $tipobaja -lt 3 ];
	do
		case $tipobaja in
		1)
			userdel $delusuario
			echo "+------------------------------------------+";
			echo "|EL USUARIO HA SIDO BORRADO CON BAJA LOGICA|";
			echo "+------------------------------------------+";
			echo "$fecha - Se borro el usuario $delusuario con baja logica" >> /root/respaldos/logsGestor/logUsuarios.txt
			sleep 2
			clear
			break;;
		2)
			deluser -r $delusuario
			echo "+------------------------------------------+";
			echo "|EL USUARIO HA SIDO BORRADO CON BAJA FISICA|";
			echo "+------------------------------------------+";
			echo "$fecha - Se borro el usuario $delusuario con baja fisica" >> /root/respaldos/logsGestor/logUsuarios.txt
			sleep 2
			clear
			break;;
               0)
                        clear
                        echo "+*-*-*-*-*-*-*-*-*-*+";
                        echo "| Volviendo al menu |";
                        echo "+-*-*-*-*-*-*-*-*-*-+";
                        sleep 1;
                        clear
                        break ;;
                *)
                        echo "Opcion incorrecta, vuelva a intentar";;
		esac
	done
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function bloquearUser(){
	echo "LISTA DE USUARIOS";
        echo "------------------------------------------------------";
        cut -d ":" -f 1 /etc/passwd
        echo "------------------------------------------------------";
        echo "";
        echo "¿Que usuario desea bloquear?";
        read lockuser
        usermod --lock $lockuser
        clear
		echo "$fecha - Se bloqueo el usuario $lockuser" >> /root/respaldos/logsGestor/logUsuarios.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function desbloquearUser(){
        echo "LISTA DE USUARIOS";
        echo "------------------------------------------------------";
        cut -d ":" -f 1 /etc/passwd
        echo "------------------------------------------------------";
        echo "";
        echo "¿Que usuario desea desbloquear?";
        read unlockuser
        usermod --unlock $unlockuser
        clear
		echo "$fecha - Se desbloqueo al usuario $unlockuser" >> /root/respaldos/logsGestor/logUsuarios.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function cambiarContra(){
	echo "Ingrese el nombre de usuario: "
	read nombre
	existeUsuario=$(cat /etc/passwd | grep -c $nombre)
	if [ $existeUsuario -eq 1 ]; then
		passwd $nombre
		echo "$fecha - Se cambio la contraseña del usuario $nombre" >> /root/respaldos/logsGestor/logUsuarios.txt
	else
		echo "El usuario no existe, presione enter para continuar"
		echo "$fecha - Hubo un intento de modificacion de contraseña, pero el usuario $nombre no existe" >> /root/respaldos/logsGestor/logUsuarios.txt
		read a
	fi
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
			echo "AGREGAR USUARIO";
			altaUsuarios;;
		2)
			clear
			echo "LISTA DE USUARIOS";
			listarUsuarios;;
		3)
			clear
			echo "BUSCAR USUARIOS";
			buscarUsuarios;;
		4)
			clear
			echo "BORRAR USUARIO";
			borrarUsuario;;
                5)
                        clear
                        echo "BLOQUEAR USUARIO";
                        bloquearUser;;
                6)
                        clear
                        echo "DESBLOQUEAR USUARIO";
                        desbloquearUser;;
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
