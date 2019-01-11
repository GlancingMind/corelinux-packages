#!/bin/sh

tce-load -wil compiletc
tce-load -wil libvirt-dev
tce-load -wil gnutls

vagrant plugin install vagrant-libvirt
