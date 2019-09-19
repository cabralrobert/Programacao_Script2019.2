#!/bin/bash

who | sort | uniq | cut -f1 -d' '
