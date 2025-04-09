# git 
alias gb='git branch'
alias glog='git log --oneline | head -n'
alias gcm='git add . && git commit -m'
alias gch='git checkout'
alias gcb='git checkout -b'

gm2() {
    git pull origin $(git branch --show-current) --rebase && git merge "$1" && git checkout "$1"
}

alias gp='git push origin $(git branch --show-current)'
alias gpr='git pull origin $(git branch --show-current) --rebase'
# k8s
alias kc='kubectl'
alias kctx='kubectl config current-context'
# docker
alias dcprune='docker container prune --force'

# Function to handle cursor cd command
cursor_cd() {
    # Store the original directory
    local orig_dir="$PWD"
    
    # Change to the specified directory
    cd "$@"
    
    # If cd was successful, update Cursor's workspace
    if [ $? -eq 0 ]; then
        # Get the new absolute path
        local new_dir="$PWD"
        
        # Send the new directory to Cursor
        # Using cursor's CLI command to update workspace
        cursor set-workspace "$new_dir"
        
        # Print confirmation
        echo "Changed Cursor workspace to: $new_dir"
    else
        # If cd failed, go back to original directory
        cd "$orig_dir"
        echo "Failed to change directory"
    fi
}

# Create an alias for the function
alias ccd='cursor_cd' 