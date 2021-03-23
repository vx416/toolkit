#!/bin/bash

function install_zsh() {
    # https://github.com/ohmyzsh/ohmyzsh
    # https://joechang0113.github.io/2020/03/23/ubuntu-install-oh-my-zsh.html
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    apt-get install zsh
    cat /etc/shells
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s /bin/zsh
}

# generate ssh keys
# https://linuxize.com/post/how-to-set-up-ssh-keys-on-ubuntu-1804/
# ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"

function install_docker () {
    # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
    apt update 
    apt install -y apt-transport-https ca-certificates curl software-properties-common
    # https://www.2daygeek.com/how-to-list-and-remove-repository-gpg-key-in-ubuntu/
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt update
    apt install docker-ce
    usermod -aG docker ${USER}
    su - ${USER}
    id -nG
    # usermod -aG docker username group
    docker run hello-world
}

# install virtualbox

function install_virtualbox (){
    # https://linuxize.com/post/how-to-install-virtualbox-on-ubuntu-20-04/
    apt update   
    apt install virtualbox virtualbox-ext-pack
}

function install_kubectl() {
    # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

    echo "$(<kubectl.sha256) kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    mkdir -p ~/.local/bin/kubectl
    mv ./kubectl ~/.local/bin/kubectl
    kubectl version --client
}


function insatll_vagrant() {
    # https://releases.hashicorp.com/vagrant/
    wget "https://releases.hashicorp.com/vagrant/$1/vagrant_$1_x86_64.deb"
    # dpkg command https://herb123456.pixnet.net/blog/post/1009880
    dpkg –i "vagrant_$1_x86_64.deb"
}

# install vscode
# https://code.visualstudio.com/download

function install_basic () {
    apt-get update && apt-get upgrade
    apt-get install -y curl git mercurial make binutils bison gcc build-essential \
            snapd snapcraft
} 

function install_gvm() {
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    source ${HOME}/.gvm/scripts/gvm
    gvm install go1.4 -B
    gvm use go1.4
    export GOROOT_BOOTSTRAP=$GOROOT
    gvm install go1.5
    gvm install $1
    gvm use --default $1
}

function install_k9s() {
    # https://github.com/derailed/k9s
    go get -u github.com/derailed/k9s
}
 
function install_java() {
    # https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04
    apt install -y default-jre default-jdk
    java -version
    javac -version
}

function install_dbear() {
    # https://dbeaver.io/download/
    wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
    dpkg –i "dbeaver-ce_latest_amd64.deb"
}

function install_redis_tools() {
    # https://docs.rdm.dev/en/latest/install/
    apt-get install -y redis-tools
    snap connect redis-desktop-manager:ssh-keys
    snap install redis-desktop-manager
}

function install_others() {
    apt install -y telegram-desktop telegram-cli telegram-purple
    snap install spotify
    # line https://medium.com/@paphop.staw/how-to-configure-a-desktop-launcher-for-line-app-on-ubuntu-20-04-lts-61872e98ab1f
}