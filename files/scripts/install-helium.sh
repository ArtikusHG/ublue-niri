#!/usr/bin/env bash
curl -L $(curl -s https://api.github.com/repos/imputnet/helium-linux/releases/latest | grep -o -m1 'https://[^"]*x86_64\.AppImage') -o /usr/bin/helium
chmod +x /usr/bin/helium
#/usr/bin/helium --appimage-extract
#cp squashfs-root/usr/share/icons/hicolor/256x256/apps/helium.png /usr/share/icons/hicolor/256x256/apps/
#rm -rf squashfs-root
