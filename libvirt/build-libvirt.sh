#!/bin/sh

tce-load -wi compiletc lvm2-dev libnl-dev udev-lib-dev libssh2-dev avahi-dev \
             curl-dev dbus-dev fuse-dev libxml2-dev perl5 qemu cyrus-sasl-dev \
             libyajl-dev libtirpc-dev dnsmasq dmidecode bridge-utils acpid
tce-load -wi gnutls-dev libxslt libtool
tce-load -wi coreutils linux-util

wget https://libvirt.org/sources/libvirt-5.0.0.tar.xz
tar -xf libvirt-5.0.0.tar.xz

cd libvirt-5.0.0

#fix compilition error by preventing definition of #defines
sed -i '20s/^/#define LIBVIRT_VIRXDRDEFS_H\n/' src/util/virxdrdefs.h

./configure \
    --silent \
    --prefix=$HOME/libvirt/usr/local \
    --with-qemu \
    --with-qemu-user=tc \
    --with-qemu-group=staff \
    --with-init-script=none \
    --without-bash-completion \
    --without-vmware \
    --without-vbox \
    --without-hal \
    --with-remote \
    --without-pm-utils \
    --with-dbus \
    --with-firewalld \
    --with-avahi \
    --with-interface \
    --with-udev \
    --with-readline

make
make install
ldconfig
cd -

#create extension
tce-load -wi coreutils
tce-load -wi squashfs-tools

mkdir -p libvirt/usr/local/etc/init.d
cp libvirt-initd.sh libvirt/usr/local/etc/init.d/libvirtd

sudo chmod -R 755 libvirt/
mksquashfs libvirt libvirt.tcz
md5sum libvirt.tcz > libvirt.tcz.md5.txt
