#!/bin/bash

## Formato de la fecha: ddmmaa ##
FECHA=`date +'%d%m%y'`

## Servidor de actualizaciones ##
SERVER_DIR="http://antivirus.uclv.cu/update/nod32"

## Directorio principal de actualizaciones ##
UPDATE_DIR="/srv/ftp/Antivirus/Actualizaciones/nod32/"

## Directorio temporal ##
TMP_FOLDER="/srv/antivirus/nod32"

## Directorio de logs ##
DIRLOG="/var/log/antivirus"

## Archivo de log ##
LOGFILE="act-av_$FECHA.log"

## Envio de alertas de fallo por correo ##
ENABLE_SENDMAIL="YES"
EMAIL="ymtnez@upr.edu.cu"
MENSAJE="Error al descargar las actualizaciones desde el servidor antivirus.uclv.edu.cu"
ASUNTO="Falla la descarga"

###############################################
## Comprobacion de los parametros anteriores ##
###############################################
if [ ! -d $UPDATE_DIR ]; then
	mkdir -p $UPDATE_DIR
fi

if [ ! -d $TMP_FOLDER ]; then
	mkdir -p $TMP_FOLDER
fi

if [ ! -d $DIRLOG ]; then
	mkdir -p $DIRLOG
fi

#array=(eset_updv8.x32.x64-uclv.zip eset_upd.x32.x64-uclv.zip eset_updv6.x32.x64-uclv.zip eset_updv7.x32.x64-uclv.zip)
array=(eset_upd.x32.x64-uclv.zip)
cant_elem=${#array[@]}

ping_server_uclv=$(ping -c 3 200.14.54.4 >& /dev/null)
result=$?
if [ $result -eq 0 ]; then
	for (( i = 0; i <= $cant_elem - 1; i++ ))
	do
  		DESCARGAR=$(wget -P $TMP_FOLDER $SERVER_DIR/${array[$i]})
  		if $DESCARGAR; then
    			unzip $TMP_FOLDER/${array[$i]} -d $TMP_FOLDER/eset_upd
  		fi
	done

	rm -r $UPDATE_DIR/*
	cp -r $TMP_FOLDER/* $UPDATE_DIR
	rm -r $TMP_FOLDER/*
	#chmod -R 775 $UPDATE_DIR
	#/etc/init.d/apache2 restart

else
        echo 'No hay conectividad con el servidor de actualizaciones de la UCLV'
fi
