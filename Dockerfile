FROM nvcr.io/nvidia/pytorch:23.11-py3

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update
ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y openssh-server
# RUN apt-get install -y tzdata && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt install -y htop git iproute2 tmux
# RUN apt install -y python3-opencv

RUN pip3 config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
ADD requirements.txt /tmp
RUN pip3 install -r /tmp/requirements.txt

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config 

ADD 71-setup-password.sh /opt/nvidia/entrypoint.d/
RUN chmod +x /opt/nvidia/entrypoint.d/71-setup-password.sh

ADD 2-setup-root.sh /opt/nvidia/entrypoint.d/
RUN chmod +x /opt/nvidia/entrypoint.d/2-setup-root.sh

ADD run-jupyterlab.sh /bin/
RUN chmod +x /bin/run-jupyterlab.sh


RUN mkdir -vp $(python -m site --user-site)
RUN pip config set global.target $(python -m site --user-site)

RUN mv /root /root_old
WORKDIR /workspace

EXPOSE 6006
EXPOSE 8008
EXPOSE 8888
EXPOSE 22

ENV PASSWORD=123456
# ENV ENV_PATH="/data/venv"

VOLUME ["/data"]