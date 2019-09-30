#!/bin/bash

TECLA=
VISOR=

until [ "$TECLA" = "q" ]
do
   clear
   tput cup 0 10
   printf "TELA: $VISOR"
   tput cup 1 10
   printf "%d %d %d" 1 2 3
   tput cup 2 10
   printf "%d %d %d" 4 5 6
   tput cup 3 10
   printf "%d %d %d" 7 8 9
   tput cup 4 10
   printf "%c %c %c %c" + - \* / 
   tput cup 5 10

   # Ler a entrada do usuário
   read TECLA

   # Se já tiver alguma operação na tela, apague
   if [[ $VISOR =~ .*=.* ]]
   then
      VISOR=
   fi

   # se você digitou um número
   if [[ $TECLA =~ [0-9]+ ]]  
   then
       # e ainda não tem nada na tela
       if [ ! "$VISOR" ]
       then
          # coloque o número na tela
          VISOR=$TECLA
       else
          # e já existe um número e um operador na tela
          if [[ $VISOR =~ [0-9]+[[:blank:]][*/\+\-] ]]
    	  then
	     # faça a operação
	     VISOR="$VISOR $TECLA = `echo "scale=2;$VISOR $TECLA" | bc`"
       fi
   fi
   # se você não digitou um número
   else
       # mas digitou um operador
       if [[ $TECLA =~ [*/\+\-] ]]
       then
          # atualize a tela para mostrar o primeiro número e o operador
          VISOR="$VISOR"$(echo "$TECLA")
          VISOR=$(echo "$VISOR" | sed -E "s/[*/\+\-]/ &/g")
       fi
   fi

done

