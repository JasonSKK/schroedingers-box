#!/bin/bash

script_path=$(dirname $(readlink -f $0))

$script_path/./set_date.sh

echo "pulling recording from bela..."

rsync -avz root@bela.local:~/Bela/projects/schroedingers_box/rec/ $script_path/../main/rec/

echo "done."
