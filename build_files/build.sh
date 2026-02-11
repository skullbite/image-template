#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/sys/ /
python /ctx/update_os_release.py

systemctl enable podman.socket