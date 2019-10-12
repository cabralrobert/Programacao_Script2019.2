#!/bin/bash

N=$1

preencheMatriz() {
    local tamanho
    tamanho=$1

    for ((i=1;i <= tamanho;i++))
    do
        for ((j=1;j <= tamanho;j++))
        do
            matriz[$i,$j]=$(echo "$i * $j" | bc)
        done
    done
}

imprimeMatriz() {
    local tamanho
    tamanho=$1

    tput bold
    tput setaf 1
    echo -ne "\t"
    for i in $(seq 1 $tamanho)
    do
        echo -ne "$i\t"
    done

    tput sgr0

    printf "\n"

    for ((i=1;i <= tamanho;i++))
    do
        tput bold
        tput setaf 1
        echo -ne "$i \t"
        tput sgr0
        for ((j=1;j <= tamanho;j++))
        do
            if [ $i -eq $j ]
            then   
                tput smul
                echo -ne ${matriz[$i,$j]}  
                tput sgr0  
                echo -ne "\t"
            else
                echo -ne ${matriz[$i,$j]} "\t"
            fi
        done
        echo ""
done

}

declare -A matriz

preencheMatriz $N matriz
imprimeMatriz $N matriz