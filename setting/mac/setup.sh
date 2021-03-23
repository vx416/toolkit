#!/bin/bash

# install homebrew
# https://docs.brew.sh/Installation
xcode-select --install
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh

# https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# https://jackblackevo.github.io/2017/10/25/improve-macos-cli-zsh.html plugins list
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins

# install fish
# https://fishshell.com/


# install git

# generate ssh keys

# install docker
# https://docs.docker.com/docker-for-mac/apple-m1/ m1 preview docker

# install virtualbox

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | shasum -a 256 --check
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo chown root: /usr/local/bin/kubectl
kubectl version --client


# install vagrant

# install vscode

# install  gvm

