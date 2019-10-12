#!/bin/bash

quickSort() {
    local left right i j valueAux
    left=$1
    shift
    right=$1
    shift
    vetor=($@)

    i=$left
    j=$right

    pivo=${vetor[$(( (left + right) / 2 ))]}

    while [ $i -le $j ]
    do
        while [ \( ${vetor[i]} -lt $pivo \) -a \( $i -lt $right \) ]
        do
            i=$((i + 1))
        done

        while [ \( ${vetor[j]} -gt $pivo \) -a \( $j -gt $left \) ]
        do
            j=$((j - 1))
        done

        if [ $i -le $j ]
        then
            y=${vetor[$i]}
            vetor[$i]=${vetor[$j]}
            vetor[$j]=$y
            i=$((i + 1))
            j=$((j - 1))
        fi
    done

    if [ $j -gt $left ]
    then
        quickSort $left $j ${vetor[@]}
    fi

    if [ $i -lt $right ]
    then
        quickSort $i $right ${vetor[@]}
    fi    

}

bubbleSort() {
    vetBubble=($@)

    for i in ${!vetBubble[@]}
    do
        for j in ${!vetBubble[@]}
        do
            if [ ${vetBubble[$i]} -le ${vetBubble[$j]} ]
            then
                aux=${vetBubble[$j]}
                vetBubble[$j]=${vetBubble[$i]}
                vetBubble[$i]=$aux
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

printf "\n\nOrdenando com BubbleSort...\n\n"

inicio_bs=`date +%s`

bubbleSort ${vet[@]}

fim_bs=`date +%s`
duracao_bs=`expr $fim_bs - $inicio_bs`


    for i in $(seq 0 $(expr $LENGTH - 1))
    do
        echo -ne ${vetBubble[$i]}" "
    done

echo ""
echo “Duração da ordenação Bubble Sort: $duracao_bs”

printf "\n\nOrdenando com QuickSort...\n\n"

inicio_qs=`date +%s`

quickSort 0 $(expr $LENGTH - 1) ${vet[@]}

fim_qs=`date +%s`
duracao_qs=`expr $fim_qs - $inicio_qs`

for i in $(seq 0 $(expr $LENGTH - 1))
    do
        echo -ne ${vetor[$i]}" "
    done

echo ""
echo “Duração da ordenação QuickSort: $duracao_qs”

echo ""

