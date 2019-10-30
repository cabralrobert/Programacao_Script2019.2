#!/bin/bash
opcao=$(dialog --stdout --inputbox "Digite o caminho do diretorio:" 8 50)
clear
list=$(eval find $opcao -maxdepth 1 -not -type d -not -type l)

caminhoAux=$(echo $opcao"/" | sed 's/\//\\\//g')

test=$(echo $list | sed 's/ \//\n\//g' | sed -e "s/$caminhoAux//g")
for LINHA in $test
do
    WC=$(wc -l $opcao/"$LINHA" | awk "{print $1}")
    AUX=$(echo "$AUX $LINHA $WC")
done


estilos=$( dialog --stdout --separate-output --checklist 'Voce gosta de:' 0 0 0 $AUX ) 
selecionados=$(echo "$estilos" | tr '\n' ' ')

#tar -cjvf file.tar.gz
compac=$(dialog --stdout --menu "Selecione a forma de compactação:" 8 50 0 1 gzip 2 b2zip)

caminho=$(dialog --stdout --inputbox "Digite o nome do arquivo de saida:" 8 50)

case $compac in
    "1")
        tar -czf $caminho.tar.gz --directory=$opcao $selecionados
        dialog --msgbox "Arquivo $caminho.tar.gz compactado utilizando o gzip com sucesso!" 8 50
    ;;
    "2")
        tar -cjf $caminho.tar.gz --directory=$opcao $selecionados
        dialog --msgbox "Arquivo $caminho.tar.gz compactado utilizando o b2zip com sucesso!!" 8 50
    ;;
esac
