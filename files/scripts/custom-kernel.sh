#!/usr/bin/env bash

# Remove Fedora kernel & remove leftover files
#dnf -y remove kernel kernel-headers kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-tools kernel-tools-libs
rpm -e --nodeps kernel kernel-headers kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-tools kernel-tools-libs
rm -r -f /usr/lib/modules/*

# Install dnf-plugins-core just in case
dnf -y install --setopt=install_weak_deps=False \
    dnf-plugins-core \
    dnf5-plugins

# Enable repos
dnf -y copr enable bieszczaders/kernel-cachyos

# Install CachyOS LTO kernel & akmods
dnf -y install --setopt=install_weak_deps=False kernel-cachyos-rt-6.19.8-cachyos1.fc43.x86_64


# Manually build modules, run depmod & generate initramfs
VER=$(ls /lib/modules) && \
    depmod -a $VER && \
    dracut --kver $VER --force --add ostree --no-hostonly --reproducible /usr/lib/modules/$VER/initramfs.img
