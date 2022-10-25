#!/bin/bash
#variables globales
sel=0;
fecha=$(date +%Y-%m-%d-%H-%M-%S);
echo "$fecha - Se inicio el script de gestion de redes, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logRedes.txt

function menu(){
        echo "+-------------------------------------------+"
        echo "| MENU GESTOR DE REDES                      |"
        echo "|-------------------------------------------|"
        echo "| 1) Ver configuracion de red               |"
        echo "| 2) Editar archivo de configuracion de red |"
        echo "| 3) Ver ip                                 |"
        echo "| 4) Asignar ip                             |" 
        echo "| 5) Eliminar direccion ip                  |"
        echo "| 6) Cambiar el gateway                     |"
        echo "| 7) Saber estadistica de red               |"
        echo "| 8) Saber usuarios conectados al sistema   |"
        echo "| 9) Expulsar usuario                       |"
        echo "| 0) SALIR DEL MENU                         |"
        echo "+-------------------------------------------+"
        echo ""
        echo "Ingrese una opcion... "   
}

function configred(){
	ls /etc/NetworkManager/system-connections/
	echo "";
	echo "Cual desea ver? Escriba el nombre completo (sin comillas)";
	read redarchivo
	echo "---------------------------------------------------------";
        cat "/etc/NetworkManager/system-connections/$redarchivo";
	echo "---------------------------------------------------------";
        echo "$fecha - Se visualizo la conexion de $redarchivo" >> /root/respaldos/logsGestor/logRedes.txt
	echo "";
	echo "Presione una tecla para finalizar";
	read -n 1 s;   
}

function editconfigred(){
        ls /etc/NetworkManager/system-connections/
        echo "";
        echo "Cual desea editar? Escriba el nombre completo (sin comillas)";
        read redarchivo
        vim "/etc/NetworkManager/system-connections/$redarchivo";
        echo "$fecha - Se edito la conexion de red $redarchivo" >> /root/respaldos/logsGestor/logRedes.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s;
}

function verip(){
	echo "------------------------------------------------------"
	ip route show
	echo "------------------------------------------------------"
        echo "$fecha - Se visualizo la ip" >> /root/respaldos/logsGestor/logRedes.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s;	 
}

function configip(){
	echo "------------------------------------------------------"
        ip route show
        echo "------------------------------------------------------"
        echo "";
        echo "Ingrese el adaptador a modificar... "
	read adaptadorred
	clear
	echo "------------------------------------------------------"
        ip route show
        echo "------------------------------------------------------"
        echo "";
	echo "Ingrese el cambio de ip: "
	read configip
        ifconfig $adaptadorred $configip
	clear
	echo "------------------------------------------------------"
	echo "Se ha realizado el cambio"
        echo "$fecha - Se cambio la ip de $adaptadorred a $ipconfig" >> /root/respaldos/logsGestor/logRedes.txt
	ifconfig $adaptadorred
	echo "------------------------------------------------------"
        echo "Presione una tecla para finalizar";
        read -n 1 s;
}

function borrarip(){
	echo "------------------------------------------------------";
        ip route show
        echo "------------------------------------------------------";
        echo "";
        echo "Ingrese la ip que desee borrar: "
	read borrarip
	ip addr del $borrarip dev enp0s3
        echo "$fecha - Se borro la ip $borrarip" >> /root/respaldos/logsGestor/logRedes.txt
	echo ""
	echo "Presione una tecla para finalizar";
        read -n 1 s
}

function gatewayconf(){
	echo "------------------------------------------------------";
        ip route show;
        echo "------------------------------------------------------";
	echo "";
	echo "¿A que adaptador de red se desea modificar su gateway?";
	read adaptadorred
	clear
	echo "------------------------------------------------------";
        ifconfig $adaptadorred
        echo "------------------------------------------------------";
        echo "";
	echo "Escriba la ip..."
	read ipactual
	clear
	echo "------------------------------------------------------";
        ifconfig $adaptadorred
        echo "------------------------------------------------------";
        echo "";
        echo "Escriba el nuevo gateway..."
        read gateway
	ip route add $gateway via $ipactual dev $adaptadorred
	ip route show
        echo "$fecha - Se modifico el gateway $gateway con la $ipactual" >> /root/respaldos/logsGestor/logRedes.txt
	echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function estadisticasRed(){
	echo "------------------------------------------------------";
	ip -s link
	echo "------------------------------------------------------";
        echo "$fecha - Se visualizaron las estadisticas de red" >> /root/respaldos/logsGestor/logRedes.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function verUsuarios(){
	echo "------------------------------------------------------";
	w
	echo "------------------------------------------------------";
        echo "$fecha - Se visualizaron los usuarios conectados" >> /root/respaldos/logsGestor/logRedes.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

function kickUsuario(){
	echo "------------------------------------------------------";
	w
	echo "------------------------------------------------------";
	echo "";
	echo "¿Que usuario desea echar?";
	read echar
	pkill -u $echar
        echo "$fecha - Se echo el usuario $echar" >> /root/respaldos/logsGestor/logRedes.txt
        echo "";
        echo "Presione una tecla para finalizar";
        read -n 1 s
}

while [ $sel -ne 10 ];
do
        clear
        menu
        read sel
        case $sel in
                1)
			clear
                        echo "VER CONFIG DE RED";
                        configred;;
                2)
			clear
                        echo "EDITAR ARCHIVO CONFIG DE RED"
                        editconfigred;;
                3)
			clear
                        echo "VER IP"
                        verip;;
                4)	
			clear
                        echo "ASIGNAR IP"
                        configip;;
                5)
			clear
			echo "ELIMINAR DIRECCION IP"
                        borrarip;;
                6)
			clear
                        echo "CAMBIAR GATEWAY"
                       	gatewayconf;;
                7)
			clear
                        echo "SABER ESTADISTICA DE RED"
                        estadisticasRed;;
                8)
			clear
                        echo "SABER USUARIOS CONECTADOS"
                        verUsuarios;;
                9)
			clear
                        echo "EXPULSAR USUARIO"
                        kickUsuario;;
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
