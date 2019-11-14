#!/bin/bash

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

competicao() {

    qtd=$(cat $file | wc -l)
    if [ $(($qtd % 2)) == 0 ]
    then
        echo -ne "Digite o primeiro jogador: "
        read NOME1
        echo -ne "Digite o segundo jogador: "
        read NOME2

        while [ ! ${#vetAux[@]} == $qtd ]
        do
            AUX=$(($RANDOM % $qtd + 1))            
            containsElement $AUX "${vetAux[@]}"
            if [ $? == 1 ]
            then
                vetAux=("$AUX" "${vetAux[@]}")
            fi
        done

        for i in $(seq 0 2 $((${#vetAux[@]} - 1)))
        do
            PALAVRA=$(cat $file | tail -n $((${vetAux[$i]})) | head -n 1 | awk '{print toupper($0)}')
            PALAVRA=$(echo "$PALAVRA" | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aAaAaAaAeEeEiIoOoOoOuUcC/')
            JOGADOR1=("$PALAVRA" "${JOGADOR1[@]}")            
        done

        for i in $(seq 1 2 $((${#vetAux[@]} - 1)))
        do
            PALAVRA=$(cat $file | tail -n $((${vetAux[$i]})) | head -n 1 | awk '{print toupper($0)}')
            PALAVRA=$(echo "$PALAVRA" | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aAaAaAaAeEeEiIoOoOoOuUcC/')
            JOGADOR2=("$PALAVRA" "${JOGADOR2[@]}")            
        done

        tentativaJogador1=
        tentativaJogador2=

        for k in $(seq 0 $(($qtd/2 - 1)))
        do
            jogo 5000000 "${JOGADOR1[$k]}" "$NOME1"

            #jogador 1
            if [ $? == 1 ]
            then
                tentativaJogador1=$(expr $tentativaJogador1 + $tentativas)
                echo "Você acertou!"
            fi

            jogo 5000000 "${JOGADOR2[$k]}" "$NOME2"

            #jogador 2
            if [ $? == 1 ]
            then
                tentativaJogador2=$(expr $tentativaJogador2 + $tentativas)
                echo "Você acertou!"
            fi

        done
        echo
        if [ $tentativaJogador1 == $tentativaJogador2 ]
        then
            echo "Fim de jogo, jogo terminou empatado!!"
            else
            if [ $tentativaJogador1 -lt $tentativaJogador2 ]
            then
                echo "Fim de jogo, jogador $NOME1 ganhou!!!"
                else
                    echo "Fim de jogo, jogador $NOME2 ganhou!!!"
            fi
        fi


    else
        echo "Arquivo não par"
    fi

}

getPalavra() {

    while read line 
    do 
        PALAVRAS_ALEATORIAS=("$line" "${PALAVRAS_ALEATORIAS[@]}")
    done < $file

    QTD=$(cat $file | wc -l)
    AUX=$(echo $(($RANDOM % $QTD)))
    PALAVRA=$(echo ${PALAVRAS_ALEATORIAS[$AUX]} | awk '{print toupper($0)}')
    PALAVRA=$(echo "$PALAVRA" | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aAaAaAaAeEeEiIoOoOoOuUcC/')
}

jogo() {
    qtdTentativas=$1
    PALAVRA=$2
    NOME=$3

    echo

    for i in $(seq ${#PALAVRA})
    do
        AUX=$(echo $PALAVRA | cut -b $i)
        if [ "$AUX" == ' ' ]
        then
            echo -ne ' '
        else
            echo -ne '_ '
        fi
    done

    echo

    unset vetLetras

    tentativas=0
    while [ true ]
    do
        echo -ne "Entre com seu chute $NOME: "
        read LETRA1
        LETRA=$(echo $LETRA1 | awk '{print toupper($0)}')  

        mostrar=
        palavraUser=

        if [[ " ${vetLetras[@]} " =~ " ${LETRA} " ]]
        then
            echo "Letra já foi utilizada!"
            continue;
        fi

        vetLetras=("$LETRA" "${vetLetras[@]}")

        tentativas=$(expr $tentativas + 1)

        if [[ ! $PALAVRA == *"$LETRA"* ]]
        then
            echo "Erro!"
            qtdErro=$(expr $qtdErro + 1)
        fi

        for i in $(seq ${#PALAVRA})
        do
            for j in ${vetLetras[@]}
            do    
                VAR=$(echo $PALAVRA | cut -b $i)
                #echo $VAR
                if [ "$VAR" == ' ' ]
                then
                    palavraUser=$palavraUser$(echo -ne ' ')
                    mostrar=$mostrar$(echo -ne ' ')
                    FLAG=1
                    break
                fi

                if [ "$j" == "$VAR" ]
                then
                    palavraUser=$palavraUser$(echo -ne $j)
                    mostrar=$mostrar$(echo -ne $j)
                    FLAG=1
                    break
                else
                    FLAG=0            
                fi
            done

            if [ $FLAG == 0 ]
            then
                palavraUser=$palavraUser$(echo -ne "_")    
                mostrar=$mostrar$(echo -ne "_")
            fi

            mostrar=$mostrar$(echo -ne " ")
            

        done

        echo "$mostrar"

        if [ "$qtdTentativas" -le "$tentativas" ]
        then
            break
        fi

        if [[ "$PALAVRA" == "$palavraUser" ]]
        then
            RETORNO=1
            break
        else
            RETORNO=0
        fi

    done

    return $RETORNO
}

mode=0

while getopts "t:f:c" OPTVAR
do
   case "$OPTVAR" in
    "t")
        qtdTentativas=$OPTARG
    ;;    
    "f")
        file=$OPTARG
    ;;
    "c")
        mode=1
    ;;
    *)
        printf "Erro!!\n"
        printf "Para modo normal: \n"
        printf "\t$0 -f file.txt -t [0-9]\n"
        printf "Para modo competição: \n"
        printf "\t$0 -f file.txt -c\n"
        exit
        ;;
   esac
done

if [ $mode == 1 ] && [ ! -z $qtdTentativas ]
then
    printf "Erro!!\n"
    printf "Para modo normal: \n"
    printf "\t$0 -f file.txt -t [0-9]\n"
    printf "Para modo competição: \n"
    printf "\t$0 -f file.txt -c\n"
    exit
fi

if [ -z $file ]
then
    printf "Erro!!\n"
    printf "Para modo normal: \n"
    printf "\t$0 -f file.txt -t [0-9]\n"
    printf "Para modo competição: \n"
    printf "\t$0 -f file.txt -c\n"
    exit
fi

if [ $mode == "0" ]
then
    getPalavra
    jogo $qtdTentativas "$PALAVRA"

    if [ $? == 1 ]
    then
        echo -ne "Você acertou."
    else
        echo -ne "Quantidade de tentaticas esgotada."
    fi

    echo " Tinha $qtdTentativas tentativas. Usou $tentativas tentativas."
else
    competicao
fi
