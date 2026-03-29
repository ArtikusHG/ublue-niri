#!/usr/bin/env bash

curl -LO $(curl -s https://api.github.com/repos/vyavdoshenko/red/releases/latest | grep -o 'https://[^"]*linux-x86_64-gnu-selinux\.tar\.gz')
tar -xzf red*.tar.gz
cp red /usr/bin/
chmod +x /usr/bin/red
ln -sf /usr/bin/red /usr/bin/sed
