#!/bin/bash

if [ -d "$1" ]
then
	TAMANHO=$(ls -l $1 | grep "total" | sed "s/total //g")
	QTD=$(ls $1 | wc -l)
	echo "O diretorio $1 ocupa $TAMANHO kilobytes e tem $QTD itens."
else
	echo "$1 não é um diretorio!!!"
fi
