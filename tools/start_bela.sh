#!/bin/bash

CWD=$(pwd)
BELAIP="bela.local"
script_path=$(dirname $(readlink -f $0))

$script_path/./set_date.sh

# go to bela repository
cd $script_path/../src/Bela/scripts

# stop bela ide
BBB_HOSTNAME=$BELAIP ./ide.sh stop

# stop currently running project
BBB_HOSTNAME=$BELAIP ./stop_running.sh

# start project (-f means in foreground, -b in background)
# BBB_HOSTNAME=$BELAIP ./run_project.sh "schroedingers_box" -c "--period 32 --dac-level 0 --adc-level 0 --pga-gain-left 0 --pga-gain-right 0 --hp-level 0 --mute-speaker yes --use-analog no --use-digital no --analog-channels 4 --digital-channels 16 --mux-channels 0 --disable-led 1" -f
BBB_HOSTNAME=$BELAIP ./run_project.sh "schroedingers_box" -f


