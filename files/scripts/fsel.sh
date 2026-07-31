#!/usr/bin/env bash

curl -LO $(curl -s https://api.github.com/repos/Mjoyufull/fsel/releases/latest | grep -o 'https://[^"]*x86_64-unknown-linux-gnu\.tar\.xz' | head -n1)
tar -xf fsel-x86_64-unknown-linux-gnu.tar.xz
cp fsel*/fsel /usr/bin/
chmod +x /usr/bin/fsel
