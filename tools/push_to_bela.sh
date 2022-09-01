#!/bin/bash

script_path=$(dirname $(readlink -f $0))

$script_path/./set_date.sh

echo "pushing patch to bela (overwriting everything)..."

# scp -r $script_path/../bela/* root@bela.local:~/Bela/projects/schroedingers_box
rsync -avz --delete $script_path/../main/ root@bela.local:~/Bela/projects/schroedingers_box/

# not needed anymore
# rsync -avz --delete $script_path/../install/ root@bela.local:~/Bela/projects/install/

rsync -avz --delete $script_path/../Extensions/ root@bela.local:~/.local/share/SuperCollider/Extensions/

rsync -avz $script_path/../src/supercollider/SCClassLibrary/* root@bela.local:/usr/share/SuperCollider/SCClassLibrary/

rsync -avz --delete $script_path/../install/quarks/* root@bela.local:/root/.local/share/SuperCollider/Extensions/

echo "done."
