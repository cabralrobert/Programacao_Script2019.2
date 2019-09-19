#!/bin/bash

NUM1=$1
NUM2=$2
NUM3=$3

if ! expr "$NUM1" + 1 > /dev/null 2> /dev/null
then
   echo "Opa!!! $NUM1 não é um número."
   exit 0
fi

if ! expr "$NUM2" + 1 > /dev/null 2> /dev/null
then
   echo "Opa!!! $NUM2 não é um número."
   exit 0
fi

if ! expr "$NUM3" + 1 > /dev/null 2> /dev/null
then
   echo "Opa!!! $NUM3 não é um número."
   exit 0
fi

if [ \( $NUM1 -gt $NUM2 \) -a \( $NUM1 -gt $NUM3 \) ]
then
	echo $NUM1
elif [ \( $NUM2 -gt $NUM1 \) -a \( $NUM2 -gt $NUM3 \) ]
then
	echo $NUM2
elif [ \( $NUM3 -gt $NUM1 \) -a \( $NUM3 -gt $NUM2 \) ]
then
	echo $NUM3
fi
