#!/usr/bin/env bash
curl -L $(curl -s https://api.github.com/repos/imputnet/helium-linux/releases/latest | grep -o -m1 'https://[^"]*x86_64\.AppImage') -o /usr/bin/helium
