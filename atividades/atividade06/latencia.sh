#!/bin/bash

ARQUIVO=$(cat $1)

for IP in $ARQUIVO
do
    MEDIA=$(ping -c 10 $IP | tail -n 1 | cut -f5 -d'/')
    VAR=$(echo $VAR && echo "$IP $MEDIA"ms)
done

echo $VAR | sed 's/ms /ms\n/g' | sort -t" " -k2 -n
