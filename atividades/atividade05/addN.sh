#!/bin/bash
VALORES=$*

echo $VALORES | tr ' ' '+' | tr ',' '.' | bc
