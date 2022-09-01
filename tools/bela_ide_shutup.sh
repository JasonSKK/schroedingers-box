#!/bin/bash

CWD=$(pwd)
BELAIP="bela.local"
script_path=$(dirname $(readlink -f $0))

# go to bela repository
cd $script_path/../src/Bela/scripts

# stop bela ide
BBB_HOSTNAME=$BELAIP ./ide.sh stop

# stop currently running project
BBB_HOSTNAME=$BELAIP ./ide.sh nostartup


