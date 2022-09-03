#!/bin/bash
#variables globales
sel=0;
fecha=$(date +%Y-%m-%d-%H-%M-%S)

function menu(){
        echo "+------------------------------------+"
        echo "|       RESPALDO BASE DE DATOS       |"
        echo "|------------------------------------|"
        echo "| 1) Respaldo de la estructura       |"
        echo "| 2) Respaldo completo               |"
        echo "| 3) Restaurar datos desde un .sql   |"
        echo "|------------------------------------|"
        echo "| 0) SALIR DEL MENU                  |"
        echo "+------------------------------------+"
        echo ""
        echo "Ingrese una opcion... "   
}

function estructura() {
	echo "Respaldo de la estructura hecha"
	mysqldump -v --opt --nodata --default-character-set=utf8 -u root -p SIGD > $fecha-SIGD-estructura.sql
	mv $fecha-SIGD-estructura.sql /root/respaldos/respaldobd/
}

function completo() {
        echo "Respaldo completo realizado"
	mysqldump --opt --events --triggers --default-character-set=utf8 -u root -p SIGD | gzip -c > $fecha-SIGD-completo.sql.gz
	mv $fecha-SIGD-completo.sql.gz /root/respaldos/respaldobd/
}

function restaurar() {
        echo "Base de datos restaurada"
	mysql -u root -p SIGD < SIGD.sql
}

while [ $sel -ne 4 ];
do
        clear
        menu
        read sel
        case $sel in
                1)
                        clear
                        echo "RESPALDAR ESTRUCTURA";
                        estructura;;
                2)
                        clear
                        echo "RESPALDO COMPLETO"
                        completo;;
                3)
                        clear
                        echo "RESTAURAR DESDE ARCHIVO"
                        restaurar;;
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

