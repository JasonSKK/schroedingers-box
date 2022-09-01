#!/bin/bash

CWD=$(pwd)
BELAIP="bela.local"
script_path=$(dirname $(readlink -f $0))

# go to bela repository
cd $script_path/../src/Bela/scripts

# set startup patch
BBB_HOSTNAME=$BELAIP ./set_startup.sh nostartup

