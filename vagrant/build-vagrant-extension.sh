#!/bin/sh

#Create a vagrant extension

tce-load -wil coreutils
tce-load -wil ca-certificates
tce-load -wil squashfs-tools

wget -O vagrant-source.zip https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_linux_amd64.zip
wget -O vagrant-sha256sums https://releases.hashicorp.com/vagrant/2.2.3/vagrant_2.2.3_SHA256SUMS

valid=$(sha256sum vagrant-source.zip)
checksum=$(grep "amd64" vagrant-sha256sums | awk '{print $1}')
if [ $checksum == $valid ]
then
    echo 'checksum failed'
    exit
fi

mkdir -p vagrant/usr/bin
unzip vagrant-source.zip -d vagrant/usr/bin
mkdir -p vagrant/usr/local/tce.installed
cp vagrant-startup.sh vagrant/usr/local/tce.installed/vagrant

find vagrant -not -type d > vagrant.tcz.list

#sudo chown -R root:root vagrant vagrant.tcz.deb
#sudo chmod -R 644 vagrant vagrant.tcz.deb
sudo chmod 755 vagrant/usr/bin/vagrant
sudo chown -R root:staff vagrant/usr/local/tce.installed
sudo chmod -R 775 vagrant/usr/local/tce.installed

mksquashfs vagrant vagrant.tcz
md5sum vagrant.tcz > vagrant.tcz.md5.txt
