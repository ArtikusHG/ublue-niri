#!/usr/bin/env bash

curl -LO $(curl -s https://api.github.com/repos/uutils/coreutils/releases/latest | grep -o 'https://[^"]*x86_64-unknown-linux-gnu\.tar\.gz')
tar -xzf coreutils-*-x86_64-unknown-linux-gnu.tar.gz
cp coreutils-*-x86_64-unknown-linux-gnu/coreutils /usr/bin/
chmod +x /usr/bin/coreutils

for cmd in $(coreutils --list); do
    ln -sf /usr/bin/coreutils "/usr/bin/$cmd"
done
