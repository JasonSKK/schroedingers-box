#!/bin/bash

CWD=$(pwd)
BELAIP="bela.local"
script_path=$(dirname $(readlink -f $0))

# go to bela repository
cd $script_path/../src/Bela/scripts

# halt board
BBB_HOSTNAME=$BELAIP ./halt_board.sh

