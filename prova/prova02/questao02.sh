#!/bin/bash

bubbleSort() {
    for i in ${!vet[@]}
    do
        for j in ${!vet[@]}
        do
            if [ ${vet[$i]} -le ${vet[$j]} ]
            then
                aux=${vet[$j]}
                vet[$j]=${vet[$i]}
                vet[$i]=$aux
            fi
        done
    done
}

LENGTH=$1

for i in $(seq $LENGTH) 
do
    echo $RANDOM >> aux.txt
done

vet=($(cat aux.txt | xargs))

rm aux.txt

for i in $(seq 0 $(expr $LENGTH - 1))
do
    echo -ne ${vet[$i]}" "
done

printf "\nOrdenando com BubbleSort...\n"

bubbleSort vet

for i in $(seq 0 $(expr $LENGTH - 1))
do
    echo -ne ${vet[$i]}" "
done

echo ""