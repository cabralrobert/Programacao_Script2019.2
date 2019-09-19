#!/bin/bash

NOTA1=$(cat /home/compartilhado/notas/primeira_prova.txt | grep 'João' | cut -f2 -d '|')
NOTA2=$(cat /home/compartilhado/notas/segunda_prova.txt | grep 'João' | cut -f2 -d '|')
NOTA3=$(cat /home/compartilhado/notas/terceira_prova.txt | grep 'João' | cut -f2 -d '|')

echo "scale=2;($NOTA1 + $NOTA2 + $NOTA3) / 3" | bc
