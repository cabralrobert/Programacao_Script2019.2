#!/bin/bash

if [ -d "$1" ]
then
	echo "É um diretorio"
elif [ -f "$1" ]
then
	echo "É um arquivo"
fi

if [ -r "$1" ]
then
	echo "Tem permissão de leitura"
else
	echo "Não tem permissão de leitura"
fi

if [ -w "$1" ]
then
	echo "Tem permissão de escrita"
else
	echo "Não tem permissão de escrita"
fi
