# MultiPytorch

自用的为多用户准备的pytorch运行环境镜像，将会为每一个用户创建venv并继承nvidia基础镜像的所有依赖，并自动配置好ssh服务器便于链接

# 添加网络

```
sudo docker network create -d macvlan --subnet=192.168.20.0/24 --gateway=192.168.20.1 -o parent=eno1 mac1
```

# 构建容器
```
sudo docker build . -t rc_dl:1
```

# 启动

```
sudo docker run --rm -it -d --name=rc --gpus all --ipc=host \
--ulimit memlock=-1 --ulimit stack=67108864 \
--ip=192.168.20.100 --network mac1 \  # 网络配置
-e ROOT_PWD="123456" \  # root密码
-e ENV_PATH="/data/rc" \   # venv创建的目录
-v /high_speed_data:/high_speed_data \
-v /data:/data \
rc_dl:1
```