#!/bin/bash

set -ouex pipefail

# Wallpapers ripped from the Frutiger Aero Archive
# https://frutigeraeroarchive.org/wallpapers/windows_7
# https://www.deviantart.com/windowsaesthetics/art/Ultimate-Windows-Wallpaper-Pack-942163195

rm -f /usr/share/wallpapers/Default
for i in $(ls /ctx/wallpapers); do
    # sed why...
    DISPLAY_NAME="Windows 7 - #$(python -c "import re;print(re.findall(\"img(.*).jpg\", \"$i\")[0])")"
    WP_PATH="/usr/share/wallpapers/$DISPLAY_NAME/contents/images"
    # DISPLAY_NAME=$(sed -rn "s/^img(.*).jpg/Windows 7 - \1/" /tmp/win-bg)
    mkdir -p "$WP_PATH"
    ls "$WP_PATH"
    cp /ctx/wallpapers/$i "$WP_PATH/1920x1200.jpg"
    SIZES=("640x480 800x600 1280x800 1280x1024 1440x900 1600x1200 1638x1024,1680x1050 1920x1080 2560x1400 2560x1600")
    for ii in $SIZES; do
        ln -s "$WP_PATH/1920x1200.jpg" "$WP_PATH/$ii.jpg"
    done

    echo 
    echo {\"KPlugin\":{\"Name\":\"$DISPLAY_NAME\"}} > "/usr/share/wallpapers/$DISPLAY_NAME/metadata.json"
done

ln -s "/usr/share/wallpapers/Windows 7 - #0" /usr/share/wallpapers/Default