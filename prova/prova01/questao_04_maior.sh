#!/bin/bash

NOTA1=$(cat /home/compartilhado/notas/primeira_prova.txt | grep 'João' | cut -f2 -d '|')
NOTA2=$(cat /home/compartilhado/notas/segunda_prova.txt | grep 'João' | cut -f2 -d '|')
NOTA3=$(cat /home/compartilhado/notas/terceira_prova.txt | grep 'João' | cut -f2 -d '|')

LISTA=$(echo "$NOTA1" && echo "$NOTA2" && echo "$NOTA3")

echo "$LISTA" | sort -n | tail -n 1
