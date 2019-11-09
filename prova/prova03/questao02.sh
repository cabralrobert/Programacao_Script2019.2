#!/bin/bash

while getopts "u:k:h:" OPTVAR
do
   case $OPTVAR in
    "u")
        USUARIO=$OPTARG
    ;;
    "k")
        KEY=$OPTARG
    ;;
    "h")
        HOST=$OPTARG
    ;;
   esac
done

if [ -z $USUARIO ] || [ -z $KEY ] || [ -z $HOST ]
then
    dialog --title "Preencha todos os campos: " --msgbox "Ex: ./questao02.sh [-u user] [-h host] [-k key]" 8 50
    exit
fi

#ssh -i $KEY $USUARIO@$HOST "cd atividades && ls"

touch arquivo.c

VALUE=$(dialog --stdout --editbox arquivo.c 0 0)

clear
echo "$VALUE" > arquivo.c

COMPILAR=$(dialog --stdout --menu "Deseja compilar remotamente o codigo?:" 8 50 0 1 SIM 2 NAO)

case $COMPILAR in
    "1")
        scp -i $KEY arquivo.c $USUARIO@$HOST:~ 1> /dev/null
        ssh -i $KEY $USUARIO@$HOST "gcc arquivo.c -o arquivo"
        if [[ $(echo $?) == 0 ]]
        then
            dialog --msgbox "Compilação completada com sucesso!" 8 50
            EXECUTAR=$(dialog --stdout --menu "Deseja executar remotamente o codigo?:" 8 50 0 1 SIM 2 NAO)
            case $EXECUTAR in
                "1")
                    RESULTADO=$(ssh -i $KEY $USUARIO@$HOST "./arquivo")
                    dialog --msgbox "$RESULTADO" 8 50
                ;;
                "2")
                    exit 0
                ;;
            esac
        else
            dialog --msgbox "Erro na compilação!" 8 50
            exit 0
        fi
    ;;
    "2")
        exit 0
    ;;
esac


clear
