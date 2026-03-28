#!/usr/bin/env bash

curl -LO $(curl -s https://api.github.com/repos/reubeno/brush/releases/latest | grep -o 'https://[^"]*x86_64-unknown-linux-gnu\.tar\.gz')
tar -xzf brush-*-x86_64-unknown-linux-gnu.tar.gz
cp brush-*-x86_64-unknown-linux-gnu/brush /usr/bin/
chmod +x /usr/bin/brush
ln -sf /usr/bin/brush /usr/bin/bash
