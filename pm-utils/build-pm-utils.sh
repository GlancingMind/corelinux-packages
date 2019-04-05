#!/bin/sh

#cat /sys/power/state

tce-load -wi compiletc ca-certificates

wget https://pm-utils.freedesktop.org/releases/pm-utils-1.4.1.tar.gz

tar -xvf pm-utils-1.4.1

cd pm-utils-1.4.1
./configure --prefix=/usr \
	--sysconfdir=/etc \
	--docdir=/usr/share/doc/pm-utils-1.4.1

make
mkdir /tmp/pm-utils
make DESTDIR=/tmp/pm-utils install

cd -

#create extension
tce-load -wi coreutils
tce-load -wi squashfs-tools

sudo chmod -R 755 /tmp/pm-utils/
mksquashfs /tmp/pm-utils pm-utils.tcz
md5sum pm-utils.tcz > pm-utils.tcz.md5.txt
