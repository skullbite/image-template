#!/bin/bash

set -exuo pipefail

dnf install -y cmake ninja qt6-qtbase-devel
CUR=/tmp/win-gadgets
git clone --depth 1 https://gitgud.io/catpswin56/win-gadgets $CUR
cd $CUR

# kind of a hack
export HOME=/tmp/not-really-home
mkdir -p $HOME/.local
ln -s $HOME/.local/share /usr/share

for i in "$CUR/plasmoids/"*; do
    if ! echo $i | grep src; then
        sh install.sh --ninja
    fi
done