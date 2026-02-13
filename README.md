> [!NOTE]  
> **This project is NOT affiliated with Microsoft or Windows, We do not claim ownership any of the assets include**
# 🪟 Kinoite 7 (aka: Kin7)

A custom image that layers [AeroThemePlasma](https://gitgud.io/wackyideas/aerothemeplasma/) on top of KDE Plasma, ain't it purdy?

[SCREENSHOT PENDING]
## Features
- Steam + Tailscale preinstalled
- Almost* everything offered by ATP
- Wallpapers from Windows 7 (Thanks to the [Frutiger Aero Archive](https://frutigeraeroarchive.org/wallpapers/windows_7))
- More options for visual changes via 7just
- ~~Apps from Sevulet~~ (WIP)
- ~~Gadgets~~ (WIP)

\* see known issues 

## Install
Switch to us from another bootc image:
```
sudo bootc switch ghcr.io/skullbite/kinoite-7:latest
```

## Credits
- UBlue for both the image template, and the Kinoite image this is based off
- WackyIdeas for making ATP
- [WinBlues 7](https://github.com/winblues/winblues7), the inspiration for this image
- [Frutiger Aero Archive](https://frutigeraeroarchive.org/wallpapers/windows_7): where the Win7 wallpapers were sourced
- [CachyOS](https://cachyos.org/): two of their wallpapers looked fitting for this


## Known Issues
- SDDM shutdown screen is Vista
- PlymouthVista seemingly doesn't work (No windows-like boot screen)
- Window colors won't open in "Personalize" menu, can still be accessed with the Aero Glass Blur extension settings
- System default wallpaper is Plasmas rather than Windows

## How is this different from WinBlues 7?
[WinBlues 7](https://github.com/winblues/winblues7) is another image built by [ledif](https://github.com/ledif) that installs ATP on Bazzite KDE Plasma. At the time of writing, the included taskbar component (SevenTasks) is broken.

This image is built on top of UBlue's kinoite image, which only includes the apps that come by default in KDE Plasma under Fedora Atomic. (aside from Steam)

Despite being built using similar tools, these projects have different goals entirely.