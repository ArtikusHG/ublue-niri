#!/usr/bin/env bash

#curl -LO $(curl -s https://api.github.com/repos/reubeno/brush/releases/latest | grep -o 'https://[^"]*x86_64-unknown-linux-gnu\.tar\.gz')
curl -L -o brush.zip https://github.com/reubeno/brush/actions/runs/23693124831/artifacts/6160850422 
#tar -xzf brush-x86_64-unknown-linux-gnu.tar.gz
unzip brush.zip
cp brush /usr/bin/
chmod +x /usr/bin/brush
ln -sf /usr/bin/brush /usr/bin/bash
