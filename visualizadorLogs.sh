#!/bin/bash
ls /var/log
fecha=$(date +%Y-%m-%d-%H-%M-%S);
echo "$fecha - Se inicio el script de visualizacion de /var/log/, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logVisualizacionLogs.txt
echo ""
echo "----------------------------------------------"
echo "Escriba que log o directorio quiere visualizar"
echo "----------------------------------------------"
echo ""
read res
if [[ -f "/var/log/$res" ]]
then
	clear
	echo "-----------------------------"
	echo "El archivo existe... abriendo"
	echo "-----------------------------"
	sleep 1
	clear
	cat /var/log/$res
        echo "$fecha - Se visualizo un archivo, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logVisualizacionLogs.txt
        echo "";
	echo "----------------------------------"
        echo "Presione una tecla para finalizar";
        read -n 1 s
else
if [[ -d "/var/log/$res" ]]
then
	clear
	echo "-----------------------"
	echo "El directorio existe..."
	echo "-----------------------"
	sleep 1
	clear
	echo "---------------------------------------------"
	echo "Presione 1 para ver el contenido"
	echo "Presione 2 para dirigirse hacia el directorio"
	echo "---------------------------------------------"
	echo ""
	read res2
	if [[ $res2 -eq 1 ]]
	then
		clear
		ls /var/log/$res
	        echo "$fecha - Se visualizo un directorio, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logVisualizacionLogs.txt
	else
	if [[ $res2 -eq 2 ]]
	then
		clear
		ls /var/log/$res
		echo ""
		echo "------------------------"
		echo "Que archivo desea abrir?"
		echo ""
		read res3
		clear
		cat /var/log/$res/$res3
		echo "$fecha - Se visualizo un directorio, lo hizo el usuario: `whoami`" >> /root/respaldos/logsGestor/logVisualizacionLogs.txt
		echo "";
        	echo "Presione una tecla para finalizar";
        	read -n 1 s
	fi
	fi
fi
fi
