# SHELL PROMPT
#prompt redhat
#export PS1="[ %n@%m:%1~ ] $ "
RED='%F{196}'
WHITE='%F{255}'
GREY='%F{253}'
GREEN_SHADE='%F{110}'
RESET='%f'

#export PS1="${GREY}[%B${RESET}${RED}%n%b${RESET}${GREY}@${RESET}%B${RED}%m%b${RESET}:${GREEN_SHADE}%1~${RESET}${GREY}] $ "
export PS1="${GREY}[${RESET}${RED}%n${RESET}${GREY}@${RESET}${RED}%m${RESET}:${GREEN_SHADE}%1~${RESET}${GREY}] $ "
unsetopt autocd beep


# COLOUR THEMES
# Define colors for different types of commands
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Enable colorized directory listings
alias ls='ls --color=auto'
# Enable colorized grep output
alias grep='grep --color=auto'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Enable command history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups  # Ignore duplicate entries in history
setopt share_history         # Share command history across sessions



# AUTO COMPLETION
autoload -Uz compinit
compinit
# Configure completion styles
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '%B%d%b'



# Key Binding (Vim)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char 

# Bind Ctrl+P to search backward in history
bindkey '^P' history-beginning-search-backward
# Bind Ctrl+N to search forward in history
bindkey '^N' history-beginning-search-forward

# Cursor Mode
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

## text objects for quotes and brackets (like da and ci vim keys)
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done


## Surrounding
## cs (change surrounding), ds (delete surrounding), ys (add surrounding)
## to mimic the famous Tim Pope’s surround plugin
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Bind Ctrl + O to clear the screen and bring the prompt to the top
bindkey '^O' clear-screen

