#!/bin/bash

while true
do
    IP_RESPOSTA=$(nc -l -p 8080)
    PORTA_RESPOSTA=$(nc -l -p 8080)
    ARQUIVO=$(nc -l -p 8080)
    echo "Devo responder em $IP_RESPOSTA:$PORTA_RESPOSTA, buscar o arquivo $ARQUIVO"

    nc $IP_RESPOSTA $PORTA_RESPOSTA -q 0 < $ARQUIVO
done
