#!/bin/bash

VALORES=$*
LISTA=$(echo $VALORES | tr ' ' '\n' | sort)

echo $VALORES | tr ' ' '\n' | sort -n | head -n 1

SOMA=$(echo $VALORES | tr ' ' '+' | bc)
echo "scale=2;$SOMA / $#" | bc

echo $VALORES | tr ' ' '\n' | sort -n | tail -n 1

