
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
sudo docker run -it -d --name=rc --gpus all --ipc=host \
--ulimit memlock=-1 --ulimit stack=67108864 \
--ip=192.168.20.100 --network mac1 \
-e PASSWORD="123456" \
-v /data:/data \
rc_dl:1
```