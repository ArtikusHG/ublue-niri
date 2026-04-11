#!/usr/bin/env bash

curl -LO $(curl -s https://api.github.com/repos/uutils/findutils/releases/latest | grep -o 'https://[^"]*x86_64-unknown-linux-gnu\.tar\.xz' | head -n1)
tar -xf findutils-x86_64-unknown-linux-gnu.tar.xz
cp find /usr/bin/
cp xargs /usr/bin
chmod +x /usr/bin/find
chmod +x /usr/bin/xargs
