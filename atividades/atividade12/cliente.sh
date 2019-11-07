#!/bin/bash

IP=$1
PORTA=$2
ARQUIVO=$3

IP_RECEBIMENTO=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

#echo $IP_RECEBIMENTO

echo $IP_RECEBIMENTO | nc $IP $PORTA -q 0
echo $PORTA | nc $IP $PORTA -q 0
echo $ARQUIVO | nc $IP $PORTA -q 0

#faucet $PORTA --in sh -c "cat > $ARQUIVO"
nc -l -p $PORTA > $ARQUIVO
