#!/bin/bash
echo -e "$PASSWORD\n$PASSWORD" | passwd root
service ssh start
