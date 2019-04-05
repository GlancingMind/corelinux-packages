#!/bin/sh

tce-load -wi compiletc lvm2-dev libnl-dev udev-lib-dev libssh2-dev avahi-dev \
             curl-dev dbus-dev fuse-dev libxml2-dev perl5 qemu cyrus-sasl-dev \
             libyajl-dev libtirpc-dev dnsmasq dmidecode bridge-utils acpid
tce-load -wi gnutls-dev libxslt libtool libtool-dev
tce-load -wi coreutils linux-util

wget https://libvirt.org/sources/libvirt-5.0.0.tar.xz
tar -xf libvirt-5.0.0.tar.xz

cd libvirt-5.0.0

#./autogen.sh
./configure \
    --prefix=/usr/local \
    --libexec=/usr/lib/libvirt \
    --sbindir=/usr/bin \
    --disable-static \
    --with-qemu \
    --with-qemu-user=tc \
    --with-qemu-group=staff \
    --with-init-script=none \
    --without-bash-completion \
    --without-hal \
    --without-lxc \
    --without-vbox \
    --without-openvz \
    --without-vmware \
    --without-libxl \
    --without-vz \
    --without-bhyve \
    --without-esx \
    --without-hyperv \
    --without-phyp \
    --with-interface

make
touch /tmp/mark
make DESTDIR=/tmp/libvirt install
cd -

#create extension
tce-load -wi coreutils
tce-load -wi squashfs-tools

mkdir -p /tmp/libvirt/usr/local/etc/init.d
cp libvirt-initd.sh /tmp/libvirt/usr/local/etc/init.d/libvirtd

sudo chmod -R 755 /tmp/libvirt/
mksquashfs /tmp/libvirt libvirt.tcz
md5sum libvirt.tcz > libvirt.tcz.md5.txt
