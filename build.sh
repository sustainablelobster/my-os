#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install repos

# Docker Community Edition
curl -L https://download.docker.com/linux/fedora/docker-ce.repo \
    -o /etc/yum.repos.d/docker-ce.repo

# Koi
curl -L https://copr.fedorainfracloud.org/coprs/birkch/Koi/repo/fedora-$RELEASE/birkch-Koi-fedora-$RELEASE.repo \
    -o /etc/yum.repos.d/birkch-Koi-fedora-$RELEASE.repo

# Visual Studio Code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
cat << EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Uninstall base packages
rpm-ostree uninstall \
    firefox \
    firefox-langpacks

# Installs packages
rpm-ostree install -y \
    code \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    gcc \
    gcc-c++ \
    Koi \
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

### Enable services

systemctl enable \
    docker \
    libvirtd \
    podman.socket
