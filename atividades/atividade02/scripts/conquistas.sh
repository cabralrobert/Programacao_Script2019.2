#!/bin/bash
# cria pastas disciplinas aprovadas
while read line
do 

	mkdir $line

done < disciplinas_conquistas.txt

# cria links programa
while read line 
do 

	cd $line
	ln -s ../../grade_curricular/$line programa
	cd ..

done < disciplinas_conquistas.txt

# cria links professor
COUNT=0
while read -r line; do
    	
	COUNT=$(( $COUNT + 1 ))
	cd $line
	ln -s ../../professores/$(head -n $COUNT ../professores_conquistas.txt | tail -1) professor
	cd ..

done < disciplinas_conquistas.txt
