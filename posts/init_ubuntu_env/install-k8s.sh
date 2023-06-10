#!/bin/bash
# 安装 kubelet kubeadm kubectl 阿里云官方推荐源
sudo apt-get update && sudo apt-get install -y apt-transport-https
sudo bash -c 'curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF'
sudo apt-get update
sudo apt-get install -y kubelet=1.22.0-00 kubeadm=1.22.0-00 kubectl=1.22.0-00

#docker 设置 systemd 驱动,./daemon.json 已经配置好了
sudo mkdir -p /etc/docker
# copy ./daemon.json 到 /etc/docker/daemon.json 替换原文件
# 如果 /etc/docker/daemon.json 不存在，创建它,有将其备份,并且将其替换为新文件 ./daemon.json
#备份
sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
sudo cp ./daemon.json /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker
#查看 docker 驱动
docker info | grep -i cgroup
# 设置 swapoff
sudo swapoff -a
# 查看 swap
swapon -s
# 通过参数判断 是否 init k8s,如果是 将执行 kubeadm init,否则执行 kubeadm join

if [[ $1 == "init" ]]; then
    echo "Running kubeadm init..."
    # 执行 kubeadm init 命令
else
    echo "Running kubeadm join..."
    # 执行 kubeadm join 命令
fi
