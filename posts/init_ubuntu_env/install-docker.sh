#!/bin/bash
# 安装docker
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update
sudo apt-get install docker-ce
sudo apt-get install docker-compose

sudo groupadd docker
sudo usermod -aG docker $USER
#newgrp docker

sudo mkdir -p /etc/docker
# copy ./daemon.json 到 /etc/docker/daemon.json 替换原文件
# 如果 /etc/docker/daemon.json 不存在，创建它,有将其备份,并且将其替换为新文件 ./daemon.json
#备份
sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
sudo cp ./daemon.json /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker
