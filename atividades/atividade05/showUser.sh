#!/bin/bash

grep $1 emails.txt | cut -f1 -d:
