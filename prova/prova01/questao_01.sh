#!/bin/bash

sed 's/\/home\/alunos/\/srv\/students/g' /etc/passwd > passwd.new
#criar diretorios se fosse necessario
#grep 'srv' passwd.new | cut -f6 -d: | xargs mkdir -p
