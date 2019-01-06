#!/bin/sh

#vagrant expects ld to be placed in /lib64 otherwise it refuses to start
if [ ! -f /lib64/ld-linux-x86-64.so.2 ]
then
    mkdir -p /lib64
    ln -s /lib/ld-linux-x86-64.so.2 /lib64
fi
