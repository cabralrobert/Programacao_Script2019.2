#!/bin/bash

USUARIOS=$(cat auth.log | grep -E "session closed" | grep "sshd" | awk '{print $11}' | sort | uniq)

declare -A TEMPOS

for i in $USUARIOS
do
    INFO=$(cat auth.log | grep -E "session closed|session opened" | grep "sshd" | grep $i | awk -f questao04_aux.awk)
    TEMPOS[$i]=0
    for j in $INFO
    do
        PROCESSO=$(echo $j | cut -f1 -d';')
        LOGIN=$(echo $j | cut -f2 -d';')
        LOGOUT=$(echo $j | cut -f4 -d';')
        DAYLOGIN=$(echo $j | cut -f3 -d';')
        DAYLOGOUT=$(echo $j | cut -f5 -d';')

        HORA_LOGIN=$(echo $LOGIN | cut -f1 -d:)
        MINUTO_LOGIN=$(echo $LOGIN | cut -f2 -d:)
        SEGUNDO_LOGIN=$(echo $LOGIN | cut -f3 -d:)

        HORA_LOGOUT=$(echo $LOGOUT | cut -f1 -d:)
        MINUTO_LOGOUT=$(echo $LOGOUT | cut -f2 -d:)
        SEGUNDO_LOGOUT=$(echo $LOGOUT | cut -f3 -d:)

        TIME_SEC_LOGIN=$(((10#$HORA_LOGIN * 3600) + (10#$MINUTO_LOGIN * 60) + (10#$SEGUNDO_LOGIN)))
        TIME_SEC_LOGOUT=$(((10#$HORA_LOGOUT * 3600) + (10#$MINUTO_LOGOUT * 60) + (10#$SEGUNDO_LOGOUT)))

        if [ $DAYLOGIN -lt $DAYLOGOUT ] || [ \( $DAYLOGIN == 31 -o $DAYLOGIN == 30 \) -a $DAYLOGOUT == 1 ]
        then
            TIME_SEC_LOGOUT=$((10#$TIME_SEC_LOGOUT + 86400))

        fi

        TIME_PROCESSOR=$((10#$TIME_SEC_LOGOUT - 10#$TIME_SEC_LOGIN))

        TEMPOS[$i]=$((${TEMPOS[$i]} + 10#$TIME_PROCESSOR))
    done
done

USERORDENADOS=$(for usuario in "${!TEMPOS[@]}"
do
    TOTAL=${TEMPOS[$usuario]}
    echo "$usuario:$TOTAL"

done | sort -n -k2 -r -t ':')

for i in $USERORDENADOS
do
    USUARIO=$(echo $i | awk -F: '{print $1}')

    TOTAL=${TEMPOS[$USUARIO]}
    HORAS=$(($TOTAL/3600))
    MINUTOS=$(( ($TOTAL - ($HORAS * 3600)) / 60 ))
    SEGUNDOS=$(($TOTAL % 60))

    echo "$USUARIO: "$HORAS"h"$MINUTOS"m"$SEGUNDOS"s"

done
