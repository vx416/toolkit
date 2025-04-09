#!/bin/bash

echo "Starting environment setup..."

# 檢查並安裝 Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Homebrew installation failed."; exit 1; }
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    source ~/.zprofile
fi

# 安裝 asfd
if ! command -v asdf &> /dev/null; then
    echo "Installing asdf..."
    brew install asdf || { echo "asdf installation failed."; exit 1; }
    echo ". $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.zshrc
    source ~/.zshrc
else
    echo "asdf is already installed. Checking for updates..."
    brew upgrade asdf
fi


asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf install golang 1.24.0
asdf set golang 1.24.0
# 安裝 GVM 和 Go 1.24.0
echo "Installing GVM and Go 1.24.0..."
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) || { echo "GVM installation failed."; exit 1; }
source "$HOME/.gvm/scripts/gvm"
gvm install go1.24.0 -B || { echo "Go 1.24.0 installation failed."; exit 1; }
gvm use go1.24.0 --default
go version && echo "Go installed successfully!"

# 安裝 rustup 和 Rust
echo "Installing rustup and Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || { echo "Rust installation failed."; exit 1; }
source "$HOME/.cargo/env"
rustc --version && echo "Rust installed successfully!"
echo '. "$HOME/.cargo/env"' >> ~/.zshrc  # 持久化 Rust 環境

# 安裝  Node.js 和 npm
echo "Installing Node.js and npm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install --lts
brew install pnpm

# 安裝 OrbStack
echo "Installing OrbStack as a Docker alternative..."
brew install --cask orbstack || { echo "OrbStack installation failed."; exit 1; }
if command -v orb &> /dev/null; then
    orb version
    echo "OrbStack installed successfully!"
else
    echo "OrbStack installation failed."
    exit 1
fi

# 安裝 k3d
echo "Installing k3d..."
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=v5.0.0 bash

# 安裝 kubectl
echo "Installing kubectl..."
brew install kubectl || { echo "kubectl installation failed."; exit 1; }
kubectl version --client && echo "kubectl installed successfully!"

# 安裝 k9s
brew install derailed/k9s/k9s


# 安裝資料庫工具
echo "Installing MySQL tools..."
brew install mysql || { echo "MySQL installation failed."; exit 1; }
mysql --version && mysqldump --version && echo "MySQL tools installed successfully!"

echo "Installing PostgreSQL tools..."
brew install postgresql || { echo "PostgreSQL installation failed."; exit 1; }
psql --version && pg_dump --version && echo "PostgreSQL tools installed successfully!"

echo "Installing Redis tools..."
brew install redis || { echo "Redis installation failed."; exit 1; }
redis-cli --version && echo "Redis tools installed successfully!"

# 安裝 vargant
if ! command -v vagrant &> /dev/null; then
    echo "正在安裝 Vagrant..."
    brew install vagrant
else
    echo "Vagrant 已安裝，檢查更新..."
    brew tap hashicorp/tap
    brew install hashicorp/tap/hashicorp-vagrant
    brew install qemu
    vagrant plugin install vagrant-qemu
fi



# 安裝 Helm
if ! command -v helm &> /dev/null; then
    echo "Installing Helm..."
    brew install helm || { echo "Helm installation failed."; exit 1; }
    helm version
else
    helm version
fi

# 安裝 protocol buffer 
if ! command -v protoc &> /dev/null; then
    echo "Installing Protocol Buffers..."
    mkdir -p ~/tools/protoc30.2

    curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v30.2/protoc-30.2-osx-aarch_64.zip
    unzip protoc-30.2-osx-aarch_64.zip -d ~/tools/protoc30.2
    echo 'export PATH="$HOME/tools/protoc30.2/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    protoc --version

    # https://grpc.io/docs/languages/go/quickstart/
    # install Go plugins for the protocol compiler, protoc-gen-go for generate message, protoc-gen-go-grpc for generate service
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.34.2
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1
else
    echo "Protocol Buffers is already installed."
fi

echo "Setup complete! Restart your terminal to ensure all changes take effect."
