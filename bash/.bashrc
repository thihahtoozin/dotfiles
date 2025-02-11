export TERM=xterm-256color

#RED='\033[38;5;196m'
#WHITE='\033[38;5;255m'
#GREY='\033[38;5;253m'
#GREEN_SHADE='\033[38;5;110m'
#BROWN='\033[38;5;130m'
#RESET='\033[0m'

RED="\[\033[38;5;196m\]"
WHITE="\[\033[38;5;255m\]"
GREY="\[\033[38;5;253m\]"
GREEN_SHADE="\[\033[38;5;110m\]"
BROWN="\[\033[38;5;130m\]"
RESET="\[\033[0m\]"

export PS1="${GREY}[${RESET}${RED}\u${RESET}${GREY}@${RESET}${RED}\h${RESET}:${GREEN_SHADE}\W${RESET}${GREY}] $ "

# Function to get current Git branch
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Include Git branch in PS1 prompt
cd_func(){
    cd "${1:-$HOME}"; # && echo "Hello";

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the current Git branch and status
        local branch=$(parse_git_branch)
        local git_status=$(git status --porcelain 2>/dev/null)
        local branch_status=""
        if [[ -n "$git_status" ]]; then
            branch_status="*"
        fi
        export PS1="${GREY}[${RESET}${RED}\u${RESET}${GREY}@${RESET}${RED}\h${RESET}:${GREEN_SHADE}\W${RESET}${GREY}]-(${BROWN}${branch}${branch_status}${RESET})-$ "
    else
        export PS1="${GREY}[${RESET}${RED}\u${RESET}${GREY}@${RESET}${RED}\h${RESET}:${GREEN_SHADE}\W${RESET}${GREY}] $ "
    fi
}

alias cd='cd_func'


# Syntax Highlighting
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ping='grc ping'
alias ip='grc ip'

alias neofetch='neofetch --ascii_colors 7'

# Enable vi mode
set -o vi

# Set timeout for key sequences
export KEYTIMEOUT=1

# Ctrl+P and Ctrl+N for history search
bind '"\C-p": history-search-backward'
# bind '"\C-n": history-search-forward'
bind '"\C-n": history-search-forward'

# Bind Ctrl + o to clear the screen and move the prompt to the top
bind '"\C-o": clear-screen'

export EDITOR='vim'
export VISUAL='vim'
export MANPAGER="nvim +Man!"
