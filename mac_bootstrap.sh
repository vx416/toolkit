#!/bin/bash

echo "Starting environment setup..."

# Install Homebrew
# https://brew.sh/zh-tw/
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    source ~/.zprofile
else
    echo "Homebrew already installed."
fi

# Install Git
echo "Installing Git..."
brew install git || { echo "Git installation failed."; exit 1; }

# Install zsh
# # https://dev.to/khairunnaharnowrin/how-to-setup-zsh-on-mac-terminal-37dj
echo "Installing zsh..."
brew install zsh || { echo "zsh installation failed."; exit 1; }
# Set zsh as default cli
chsh -s /bin/zsh

# Install oh-my-zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Setting ZSH_THEME to powerlevel10k/powerlevel10k..."
if grep -q "^ZSH_THEME=" ~/.zshrc; then
    # 如果已經有 ZSH_THEME 這行，就用 sed 替換
    sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
else
    # 如果沒有 ZSH_THEME，直接追加
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
fi


echo "source ~/.zshrc" >> ~/.zprofile

echo "Appending custom 'code' function to ~/.zshrc..."
# 定義函數內容
CODE_FUNCTION=$(cat << 'EOF'
function code {  
    cd $* && VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$PWD"
}
EOF
)

# 追加到 ~/.zshrc
echo "$CODE_FUNCTION" >> ~/.zshrc

echo "Setup complete! Please restart your terminal."