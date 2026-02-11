#!/bin/bash


# TODO: the desktop files are all over the place for this
git clone --depth 1 https://gitgud.io/snailatte/7s-notepad /tmp/7np
cd /tmp/7np
sh build.sh

cp -R ./installation/hicolor /usr/share/icons/
cat ./installation/notepad.desktop | sed "s/~\/.local/\/usr/g" > /usr/share/applications/notepad.desktop
cp -f ./build/notepad /usr/bin

git clone --depth 1 https://gitgud.io/snailatte/7s-photoview /tmp/7pv
cd /tmp/7pv
sh build.sh
cp -r ./installation/hicolor /usr/share/icons/
cp -f ./installation/photoview.desktop /usr/share/applications
cat /usr/share/applications/photoview.desktop | sed "s/\~\/.local/\/usr/g" > /usr/share/applications/photoview.desktop
cp -f ./build/photoview /usr/bin
