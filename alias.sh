# git 
alias gb='git branch'
alias glog='git log --oneline | head -n 10'
alias gp='git push origin head'
alias gpr='git pull origin --rebase'
# k8s
alias kc='kubectl'
# docker
alias cprune='docker container prune --force'

function code {  
    cd $* && VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$PWD"
}