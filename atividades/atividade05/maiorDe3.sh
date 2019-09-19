#!/bin/bash

NUM1=$1
NUM2=$2
NUM3=$3

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
