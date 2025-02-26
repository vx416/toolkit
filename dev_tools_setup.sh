#!/bin/bash

echo "Starting environment setup..."

# 檢查並安裝 Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Homebrew installation failed."; exit 1; }
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    source ~/.zprofile
fi

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

# 安裝 kubectl
echo "Installing kubectl..."
brew install kubectl || { echo "kubectl installation failed."; exit 1; }
kubectl version --client && echo "kubectl installed successfully!"

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

echo "Setup complete! Restart your terminal to ensure all changes take effect."