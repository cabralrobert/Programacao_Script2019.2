#!/bin/bash

baixarProfessor() {
    PROFESSOR=$2
    LINK=$1
    wget $LINK -O $PROFESSOR.html 2> /dev/null
}

baixarTodosProfessores() {
    LISTA=$1
    for LINK in $LISTA
    do
        PROFESSOR=$(echo $LINK | awk -F/ '{print $5}')       
        baixarProfessor $LINK $PROFESSOR
        TOTAL=$(echo $LISTA | tr ' ' '\n' | wc -l)
        ATUAL=$(ls | wc -l)
        PERCENT=$(echo "scale=2;($ATUAL / $TOTAL) * 100" | bc | cut -f1 -d'.')
        echo $PERCENT
#        clear
    done | dialog --timeout 0 --gauge "Baixando..." 8 50
}

baixaRestantes() {

    for i in $LISTA_PROFESSORES
    do
        PROFESSOR=$(echo $i | awk -F/ '{print $5}')

        TOTAL=$(echo $LISTA_PROFESSORES | tr ' ' '\n' | wc -l)
        ATUAL=$(ls | wc -l)
        PERCENT=$(echo "scale=2;($ATUAL / $TOTAL) * 100" | bc | cut -f1 -d'.')
        echo $PERCENT

        # verifica se o arquivo do professor já existe
        if [ ! -f "$PROFESSOR.html" ]
        then
            # não existe, então baixa
            baixarProfessor $i $PROFESSOR
        fi
    done | dialog --gauge "Baixando arquivo de professores restantes..." 8 50

    clear

}

if [ ! -f docentes.html ]
then
    wget https://www.quixada.ufc.br/docente/ -O docentes.html 2> /dev/null
fi

LISTA_PROFESSORES=$(cat docentes.html | grep -E "<a href=\"https://www.quixada.ufc.br/docente/.* class=\"btn btn-info btn-xs\"" | awk -F\" '{print $2}' | tr '\n' ' ')

mkdir -p professores
cd professores

while getopts "k:f" OPTVAR
do
   case $OPTVAR in
    "k")
        VALUES=$OPTARG
    ;;    
    "f")
        # opcao para baixar todos os professores
        rm *.html
        baixarTodosProfessores "$LISTA_PROFESSORES"
        dialog --title "Professores" --msgbox "Arquivos baixados com sucesso!!" 8 50
    ;;
   esac
done

TOTAL=$(echo $LISTA_PROFESSORES | tr ' ' '\n' | wc -l)
ATUAL=$(ls | wc -l)

if [ ! $TOTAL == $ATUAL ]
then
    baixaRestantes "$LISTA_PROFESSORES"
fi


for i in $(ls)
do
    AREAS=$(cat $i  | grep -E "Áreas|Área de interesse" | sed -E 's/<li>|<\/li>|Áreas de interesse:|Área de interesse://g')
    NOME=$(cat $i | grep "<title>" | sed -E 's/    |    | \| UFC Campus Quixadá  <\/title>|<title>//g')

    IFS=,
    for i in $VALUES
    do
        if [[ $AREAS == *$i* ]]
        then
            PROFESSORES_MOSTRAR=$PROFESSORES_MOSTRAR$(printf "%s\n"$NOME)
        fi
    done

done

FINAL=$(echo $PROFESSORES_MOSTRAR | sed 1d | sort | uniq)
dialog --title "Professores" --msgbox "$FINAL" 10 50
clear

