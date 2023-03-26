#!/bin/bash

# 设置密码
echo -e "$ROOT_PWD\n$ROOT_PWD" | passwd root

# 启动ssh
service ssh start

python -m venv --system-site-packages $ENV_PATH/venv

echo "source $ENV_PATH/venv/bin/activate" >> /root/.bashrc
mkdir -p /root/.config
mkdir -p /root/.config/pip/
cp  /usr/pip.conf /root/.config/pip/

# 进入用户环境
cd /workspace && bash
