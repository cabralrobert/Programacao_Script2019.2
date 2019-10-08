#!/bin/bash

menu() {
   echo "1- Adicionar"
   echo "2- Remover"
   echo "3- Procurar"
   echo "4- Listar"
   echo "5- Sair"
   read -p "Informe a opção: " OPCAO

   case $OPCAO in
      1)
	     clear
        read -p "Informe o nome do host: " nome
        read -p "Informe o IP do host: " IP
        adicionar $nome $IP
        read -p "Digite [enter] para retornar ao menu." 
         ;;
      2)
	     clear
        read -p "Informe o nome do host: " nome	    
        remover $nome
        read -p "Digite [enter] para retornar ao menu." 
        ;;
      3)
         clear
         read -p "Informe o nome do host: " nome	 
         procurar $nome
         read -p "Digite [enter] para retornar ao menu." 
         ;;
      4)
         clear
         listar
         read -p "Digite [enter] para retornar ao menu." 
         ;;
      5)
         clear
         exit 0
         ;;
      *)
	     echo "Digite [enter] e tente novamente..."
	     read 
	     ;;
   esac
   clear
   
}

adicionar() {   
   echo "$1:$2" >> hosts.db	
}

remover() {
   set -xv
   sed -i '/^'$1'.*/d' hosts.db 	
   set +xv
}

procurar() {
   grep $1 hosts.db | cut -f2 -d':'	
}

reverso(){
   grep $1 hosts.db | cut -f1 -d':'	
}

listar() {
   cat hosts.db | tr ':' ' '	
}

getopts "a:i:r:d:l" OPTVAR
case "$OPTVAR" in
   "a") nome=$OPTARG
	getopts "a:i:r:d:l" OPTVAR
	if [ "$OPTVAR" == "i" ]
        then
           IP=$OPTARG
        else    
           echo "Está errado, babaca..."		
	        exit 1
        fi
	adicionar $nome $IP
	;;
   "i") IP=$OPTARG
	getopts "a:i:r:d:l" OPTVAR
	if [ "$OPTVAR" == "a" ]
        then
           nome=$OPTARG
        else
           echo "Está errado, babaca..."		
	        exit 1
        fi
	adicionar $nome $IP
	;;
   "l") listar
        exit 0     
        ;;
   "d") remover $OPTARG
        ;;
   "r") procurar $OPTARG
        ;;
   *)
         while true
         do
          menu
         done
        ;;
esac








