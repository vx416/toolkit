#!/bin/bash

echo "Setting up SSH key for GitHub..."

# 提示輸入 GitHub 註冊的 email
read -p "Enter your GitHub email: " github_email

# 生成 SSH key
echo "Generating a new SSH key..."
ssh-keygen -t ed25519 -C "$github_email" -f ~/.ssh/id_ed25519 -N "" || { echo "SSH key generation failed."; exit 1; }
# -N "" 表示不設密碼，若要設密碼可移除這部分

# 啟動 SSH agent
echo "Starting SSH agent..."
eval "$(ssh-agent -s)" || { echo "SSH agent failed to start."; exit 1; }

# 添加私鑰到 SSH agent
echo "Adding SSH key to agent..."
ssh-add ~/.ssh/id_ed25519 || { echo "Failed to add SSH key."; exit 1; }

# 複製公鑰到剪貼簿
echo "Copying public key to clipboard..."
pbcopy < ~/.ssh/id_ed25519.pub
echo "Public key copied! Please paste it into GitHub."

# 提示使用者手動上傳
echo "1. Go to GitHub: https://github.com/settings/keys"
echo "2. Click 'New SSH key', give it a name, and paste the key from your clipboard."
echo "3. Click 'Add SSH key'."

# 測試 GitHub 連線
echo "Testing SSH connection to GitHub (press Enter when ready)..."
read -p ""
ssh -T git@github.com && echo "SSH setup successful!" || echo "SSH connection failed. Check your key or network."

echo "Done! Use 'git remote set-url origin git@github.com:username/repo.git' for SSH repositories."