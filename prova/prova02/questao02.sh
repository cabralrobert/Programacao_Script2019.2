#!/bin/bash

bubbleSort() {
    vetor=($@)

    for i in ${!vetor[@]}
    do
        for j in ${!vetor[@]}
        do
            if [ ${vetor[$i]} -le ${vetor[$j]} ]
            then
                aux=${vetor[$j]}
                vetor[$j]=${vetor[$i]}
                vetor[$i]=$aux
            fi
        done
    done

    for i in $(seq 0 $(expr $LENGTH - 1))
    do
        echo -ne ${vetor[$i]}" "
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

bubbleSort ${vet[@]}



echo ""