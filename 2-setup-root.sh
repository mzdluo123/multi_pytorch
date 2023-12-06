#!/bin/bash

if [ ! -f /data/.file_copied ]; then
    cp -ra /root_old/. /data/
    touch /data/.file_copied
fi

if [ ! -L /root ]; then
    ln -s /data /root
fi

if [ ! -L /workspace/data ]; then
    ln -s /data /workspace
fi  

