#!/bin/bash

DIR1=$1
DIR2=$2

for i in $(ls $DIR1)
do

    date=$(stat -c %y $DIR1/$i | cut -f1 -d" ")
    
    ano=$(echo $date | cut -f1 -d"-")
    mes=$(echo $date | cut -f2 -d"-")
    dia=$(echo $date | cut -f3 -d"-")

    eval mkdir -p $DIR2/$ano/$mes/$dia
    cp $DIR1/$i $DIR2/$ano/$mes/$dia

done