#!/bin/bash

while getopts "o:i:" OPTVAR
do   
   case $OPTVAR in
    "o")
        SAIDA=$OPTARG
    ;;
    "i")
        ENTRADA=$OPTARG
    ;;
   esac
done

printf "<html>\n\t<head>\n\t\t<title>\n\t\tMeus Links Favoritos\n\t\t</title>\n\t</head>\n\t<body>\n\t\t<p>Apresento aqui meus sites favoritos:</p>" >> $SAIDA

for i in $(cat $ENTRADA)
do
    VAR1=$(echo $i | cut -f2 -d":")
    VAR2=$(echo $i | cut -f1 -d":")
    printf "\n\t\t<a href=%s\"$VAR1\">$VAR2</a>" >> $SAIDA
    printf "\n\t\t<br>" >> $SAIDA
done

printf "\n\t</body>\n</html>\n" >> $SAIDA