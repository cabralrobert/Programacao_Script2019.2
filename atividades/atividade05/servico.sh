#!/bin/bash

case $1 in
	"start")
		echo "Iniciando Serviço"
		;;
	"stop")
		echo "Parando Serviço"
		;;
	"restart")
		echo "Reiniciando Serviço"
		;;
	*)
		echo "Uso: servico.sh (start|stop|restart)"
		;;
esac
