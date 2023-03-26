FROM nvcr.io/nvidia/pytorch:23.02-py3
ENV TZ=Asia/Shanghai

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update
RUN apt install -y htop git iproute2 openssh-server tmux python3.8-venv

RUN pip3 config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/

RUN pip3 install 'lightning' transformers numba

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config 

ADD startup.sh /tmp
RUN chmod +x /tmp/startup.sh

WORKDIR /workspace

EXPOSE 6006
EXPOSE 8008
EXPOSE 22

ENV ROOT_PWD=123456
ENV ENV_PATH="/data/venv"
VOLUME [ "/data","/high_speed_data" ]

CMD /tmp/startup.sh