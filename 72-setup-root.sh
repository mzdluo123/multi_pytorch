#!/bin/bash

if [ ! -f /data/.bashrc ]; then
    cp -ra /root/. /data/
fi

rm -rf /root/
ln -s /data /root
ln -s /data /workspace