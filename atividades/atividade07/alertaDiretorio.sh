#!/bin/bash

INTERVALO=$1
DIR=$2

ls $DIR > .olddir.txt
while true 
do
   ls $DIR > .newdir.txt

   if [ ! -z "`comm -3 .newdir.txt .olddir.txt`" ]
   then

      echo -ne "[$(date +"%d-%m-%Y") $(date +"%T")] Alteração!: $(cat .olddir.txt | wc -l)->$(cat .newdir.txt | wc -l). "

      VALORES=$(comm -2 -3 .newdir.txt .olddir.txt)
      if [ ! -z "$VALORES" ]
      then
         echo -ne "Adicionados: "         
         QTDNEW=$(comm -2 -3 .newdir.txt .olddir.txt | wc -l)
         i=1
         for line in $VALORES 
         do
            if [ $i = $QTDNEW ]
            then
               echo -ne "$line. "
            else
               echo -ne "$line, "
            fi     
            i=$(expr $i + 1)
         done                  
      fi

      VALORES2=$(comm -1 -3 .newdir.txt .olddir.txt)
      if [ ! -z "$VALORES2" ]
      then
         echo -ne "Removidos: "         
         QTDNEW=$(comm -1 -3 .newdir.txt .olddir.txt | wc -l)
         i=1
         for line in $VALORES2
         do
            if [ $i = $QTDNEW ]
            then
               echo -ne "$line. "
            else
               echo -ne "$line, "
            fi     
            i=$(expr $i + 1)
         done         
         
      fi
      
      echo ""

      #clear
   fi
   sleep $INTERVALO
   mv .newdir.txt .olddir.txt
done