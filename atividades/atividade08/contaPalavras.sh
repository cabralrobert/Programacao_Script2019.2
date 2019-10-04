#!/bin/bash

echo -ne "Informe o arquivo: "
read ARQUIVO
VET=($(cat $ARQUIVO | tr 'A-Z' 'a-z' | tr ' ' '\n' | sort | sed -E 's/[[:punct:]]//' | sed -E 's/\t//' | uniq | xargs))

for i in ${!VET[@]}
do
    echo -ne ${VET[$i]}":\t" && cat $ARQUIVO | tr 'A-Z' 'a-z' | tr ' ' '\n' | sed -E 's/\t//' | grep -wc ${VET[$i]}
done