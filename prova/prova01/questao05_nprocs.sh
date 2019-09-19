#!/bin/bash

ps aux | tr -s '\t' ' ' | cut -f1 -d' ' | grep -v 'root' | sed 1d | wc -l
