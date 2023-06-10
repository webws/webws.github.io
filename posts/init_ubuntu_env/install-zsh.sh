#!/bin/bash
#  安装zsh
#  备份源列表
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
#  替换源列表
sudo bash -c 'cat > /etc/apt/sources.list <<EOT
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-backports main restricted universe multiverse

# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-security main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-security main restricted universe multiverse

deb http://ports.ubuntu.com/ubuntu-ports/ kinetic-security main restricted universe multiverse
# deb-src http://ports.ubuntu.com/ubuntu-ports/ kinetic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-proposed main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ kinetic-proposed main restricted universe multiverse
EOT'

#  更新源
sudo apt-get update && sudo apt-get upgrade -y
#  安装 zsh
sudo apt-get install zsh -y
sudo chsh -s /bin/zsh
# 安装 oh-my-zsh
wget https://ghproxy.com/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sudo rm -rf ~/.oh-my-zsh/
chmod +x ./install.sh
sh ./install.sh
# 安装 zsh 插件 syntax-highlighting
git clone https://ghproxy.com/https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# 安装 zsh 插件 autosuggestions
git clone https://ghproxy.com/https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# 安装 zsh 插件 autojump
sudo apt-get install autojump
# on my zsh 设置 主题为 ys,增加 plugins 为 zsh-syntax-highlighting zsh-autosuggestions autojump k8s git
sed -i 's/plugins=(git)/plugins=(zsh-syntax-highlighting zsh-autosuggestions autojump k8s git)/g' ~/.zshrc
# 设置 oh my zsh 的theme为 ys
omz theme set ys
