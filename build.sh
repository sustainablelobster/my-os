#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install repos

# Docker Community Edition
curl -L https://download.docker.com/linux/fedora/docker-ce.repo \
    -o /etc/yum.repos.d/docker-ce.repo

# Visual Studio Code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" \
    >  /etc/yum.repos.d/vscode.repo

# Proton VPM
# rpm-ostree install \
    # "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.1-2.noarch.rpm"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install \
    code \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    python3-libguestfs \
    qemu-kvm \
    solaar \
    virt-install \
    virt-manager \
    virt-top \
    virt-viewer \
    wireshark

rpm-ostree uninstall firefox firefox-langpacks

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File
systemctl enable docker
systemctl enable libvirtd
systemctl enable podman.socket
