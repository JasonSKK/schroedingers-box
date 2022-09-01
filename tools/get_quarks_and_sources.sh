#!/bin/bash

# shell script to clone git repositories of required SuperCollider Quarks
# see also here: https://forum.bela.io/d/1711-quarks/3

script_path=$(dirname $(readlink -f $0))

echo "cloning sources..."

mkdir -p $script_path/../install/quarks
cd $script_path/../install/quarks

if [ ! -d "quarks" ] ; then
    git clone https://github.com/supercollider-quarks/quarks.git
fi

if [ ! -d "ddwVoicer" ] ; then
    git clone https://github.com/supercollider-quarks/ddwVoicer.git
fi

if [ ! -d "ddwCommon" ] ; then
    git clone https://github.com/supercollider-quarks/ddwCommon.git
fi

if [ ! -d "ddwGUIEnhancements" ] ; then
    git clone https://github.com/supercollider-quarks/ddwGUIEnhancements.git
fi

if [ ! -d "crucial-library" ] ; then
    git clone https://github.com/crucialfelix/crucial-library.git
fi


mkdir -p $script_path/../src
cd $script_path/../src

if [ ! -d "supercollider" ] ; then
    git clone https://github.com/supercollider/supercollider
    git -C supercollider checkout a2e58ce6af14f573d26abdf5d56824b212aba205
    # git -C supercollider checkout b8ddcaf0f89c019af0f682a49f5df1c516578067
fi

if [ ! -d "Bela" ] ; then
    git clone https://github.com/BelaPlatform/Bela.git
fi


echo "done."