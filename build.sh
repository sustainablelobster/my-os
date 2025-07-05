#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install repos

# Docker Community Edition
curl -Lo /etc/yum.repos.d/docker-ce.repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

# Koi
curl -Lo /etc/yum.repos.d/birkch-Koi-fedora-$RELEASE.repo \
    https://copr.fedorainfracloud.org/coprs/birkch/Koi/repo/fedora-$RELEASE/birkch-Koi-fedora-$RELEASE.repo 

# VSCodium
rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
cat > /etc/yum.repos.d/vscodium.repo << EOF
[gitlab.com_paulcarroty_vscodium_repo]
name=download.vscodium.com
baseurl=https://download.vscodium.com/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
metadata_expire=1h 
EOF

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Uninstall base packages
rpm-ostree uninstall toolbox

# Install packages
rpm-ostree install -y \
    automake \
    codium \
    containerd.io \
    diffstat \
    distrobox \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    doxygen \
    gcc \
    gcc-c++ \
    gettext \
    git \
    git-lfs \
    kernel-devel \
    Koi \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    make \
    patch \
    patchutils \
    python3-libguestfs \
    qemu-kvm \
    remmina \
    remmina-plugins-exec \
    remmina-plugins-kwallet \
    remmina-plugins-python \
    remmina-plugins-rdp \
    remmina-plugins-secret \
    remmina-plugins-spice \
    remmina-plugins-vnc \
    remmina-plugins-www \
    remmina-plugins-x2go \
    solaar \
    subversion \
    systemtap \
    vagrant \
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
