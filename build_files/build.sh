#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

install_component () {
    kpackagetool6 -g -t "$2" -i "$1" || \
    kpackagetool6 -g -t "$2" -u "$1"
}

git clone https://gitgud.io/wackyideas/aerothemeplasma/ /tmp/atp
cd /tmp/atp
CUR="/tmp/atp"

# this installs a package from fedora repos
dnf install -y plasma-workspace-devel unzip kvantum qt6-qtmultimedia-devel qt6-qt5compat-devel libplasma-devel qt6-qtbase-devel qt6-qtwayland-devel plasma-activities-devel kf6-kpackage-devel kf6-kglobalaccel-devel qt6-qtsvg-devel wayland-devel plasma-wayland-protocols kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel kdecoration-devel kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel cmake gmp-ecm-devel kf5-plasma-devel libepoxy-devel kwin-devel kf6-karchive kf6-karchive-devel plasma-wayland-protocols-devel qt6-qtbase-private-devel qt6-qtbase-devel kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel kf6-kdbusaddons-devel kf6-sonnet-devel plasma5support-devel plasma-activities-stats-devel polkit-qt6-1-devel qt-devel libdrm-devel kf6-kitemmodels-devel kf6-kstatusnotifieritem-devel

sh compile.sh --ninja --wayland
# plasmoids
for i in "$CUR/plasma/plasmoids/src/"*; do
    cd "$i"
    sh install.sh --ninja
done

cd $CUR

for i in "$CUR/plasma/plasmoids/"*; do
    if ! echo $i | grep src; then
        install_component "$i" "Plasma/Applet"
    fi
done

for i in "$CUR/plasma/plasmoids/src/"*; do
    cd "$i"
    sh install.sh --ninja
done

cd $CUR

# kwin components
cp -r "$CUR/kwin/smod" "/usr/share"

for i in "$CUR/kwin/effects/"*; do
    install_component "$i" "KWin/Effect"
done

for i in "$CUR/kwin/tabbox/"*; do
    install_component "$i" "KWin/WindowSwitcher"
done

cp -r "$CUR/kwin/outline" "/usr/share/kwin"
cd /usr/share/
ln -s kwin kwin-x11
ln -s kwin kwin-wayland
cd $CUR

# plasma components
cp -r $CUR/plasma/{desktoptheme,look-and-feel,layout-templates,shells} /usr/share/plasma
install_component "$CUR/plasma/look-and-feel/authui7" "Plasma/LookAndFeel"
install_component "$CUR/plasma/layout-templates/io.gitgud.wackyideas.taskbar" "Plasma/LayoutTemplate"
install_component "$CUR/plasma/desktoptheme/Seven-Black" "Plasma/Shell"
install_component "$CUR/plasma/shells/io.gitgud.wackyideas.desktop" "Plasma/Shell"

mkdir -p /usr/share/color-schemes
cp $CUR/plasma/color_scheme/Aero.colors /usr/share/color-schemes

cd $CUR/plasma/sddm/login-sessions
sh install.sh --ninja
cd $CUR/plasma/sddm
cp -r sddm-theme-mod /usr/share/sddm/themes
# tar -zcvf "sddm-theme-mod.tar.gz" sddm-theme-mod
# sddmthemeinstaller -i sddm-theme-mod.tar.gz
#rm sddm-theme-mod.tar.gz

cd $CUR
# misc components
cp -r $CUR/misc/kvantum/Kvantum /etc
echo -e "[General]\ntheme=Windows7_Aero" > /usr/share/Kvantum/kvantum.kvconfig

cd $CUR/misc/libplasma
sh install.sh --ninja
# cd $CUR/misc/uac-polkitagent
# sh install.sh --ninja
# sh add_rule.sh --ninja

cd $CUR

mkdir -p /usr/share/sounds
tar -xf $CUR/misc/sounds/sounds.tar.gz --directory /usr/share/sounds

mkdir -p /usr/share/icons
tar -xf "$CUR/misc/icons/Windows 7 Aero.tar.gz" --directory /usr/share/icons
tar -xf $CUR/misc/cursors/aero-drop.tar.gz --directory /usr/share/icons

mkdir -p /usr/share/mime/packages
for i in "$CUR/misc/mimetype/"*; do
    cp -r "$i" /usr/share/mime/packages
done

update-mime-database /usr/share/mime

for i in "$CUR/misc/branding/"*; do
    cp -r "$i" /etc/kdedefaults
done

kwriteconfig6 --file /etc/kcm-about-distrorc --group General --key LogoPath /etc/kdedefaults/kcminfo.png

git clone https://github.com/furkrn/PlymouthVista
cd PlymouthVista
chmod +x ./compile.sh
chmod +x ./install.sh
./compile.sh
./install.sh -s -q

# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
