#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/sys/ /
python /ctx/update_os_release.py

dnf install -y steam fastfetch

systemctl enable podman.socket