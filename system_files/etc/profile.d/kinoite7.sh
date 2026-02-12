#!/bin/bash
case $(7just _get-config bash-profile cmdprompt) in
    cmdprompt)
        echo -e "Fedora Kinoite [Version $(uname -r)]\nCopyright (c) $(date +%Y) Fedora Community. All rights reserved.\n"
        PS1='C:${PWD//\//\\\\}> '
        ;;
    ublue)
        /usr/libexec/ublue-motd
        ;;
    fastfetch)
        fastfetch --logo windows
        ;;
esac


