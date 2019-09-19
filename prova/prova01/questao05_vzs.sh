#!/bin/bash

ps aux | grep 'nginx' | grep -v 'grep' | tr -s '\t' ' ' | cut -f5 -d' ' | xargs | tr ' ' '+' | bc
