#!/bin/bash

QTD=$(grep $1 emails.txt | wc -l)
NOME=$(grep $1 emails.txt | cut -f1 -d:)

echo "$QTD usuarios com o dominio;"
echo "Usuários: $NOME"
