# ublue-niri &nbsp; [![bluebuild build badge](https://github.com/artikushg/ublue-niri/actions/workflows/build.yml/badge.svg)](https://github.com/artikushg/ublue-niri/actions/workflows/build.yml)

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

This is my personal image of Fedora Atomic with the Niri and a few other useful utilities in core. That's not the interesting part. The interesting part is that this uses kernel-cachyos, uutils and many other rust tools! You can see the scripts and the recipe to find out how I achieved this (quite simply actually) and maybe use it on your own system, but I do not guarantee stability! Everything is highly experimental at this point and things might break. Also, you probably shouldn't use this image directly if you happen to stumble accross it - if you want something similar, a good idea would be to fork it and make your own one.

Currently used rust alternatives:

- `GNU coreutils` -> [uutils coreutils](https://github.com/uutils/coreutils)
- `sudo` -> [sudo-rs](https://github.com/trifectatechfoundation/sudo-rs)
- `chrony` -> [ntpd-rs](https://github.com/pendulum-project/ntpd-rs)
- `bash` -> [brush](https://github.com/reubeno/brush)
- `sed` -> [red](https://github.com/vyavdoshenko/red)
- `vim/nano` -> [helix](https://github.com/helix-editor/helix)

I'm closely monitoring uutils progress on other projects, such as `diffutils`, `findutils`, `procps`, `hostname` and many others! Also actively looking for a GNU/POSIX compatible alternative to `grep` and `awk`, if you happen to know one - tell me! (not ripgrep, it's great but not GNU compatible and will probably break my system)

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/artikushg/ublue-niri:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/artikushg/ublue-niri:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/artikushg/ublue-niri
```
