# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Antigen
source "$HOME/.antigen.zsh"

############################
#### Antigen
############################

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle docker
antigen bundle command-not-found
#antigen bundle Aloxaf/fzf-tab

# Load bundles from external repos
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
# antigen theme robbyrussell
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply






############################
#### CUSTOM STUFF
############################
# enable vi mode in terminal
set -o vi

chpwd() {
  echo " " && pwd && echo "--------------------" && exa --long --sort=Ext --all --header --git --icons && echo ""
}

# quick reload
alias reload="source ~/.bashrc && source ~/.zshrc && clear"

# some more ls aliases
alias ls='exa --git --icons --sort=Ext'
alias ll='exa --all --long --header --sort=Ext --git --icons'
alias tree='exa --git-ignore --all --sort=Ext --git --tree -I \.git --icons'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# git add, commit and push all in one
# example: lazygit "commit message"
function quickgit() {
    git add .
    git commit -a --allow-empty-message -m "$*"
    git push
}

############################
####     PATH
############################

# sensible detail for PATH
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# FOREMAN (for ROBLOX)
export PATH="$HOME/.foreman/bin/:$PATH"
export PATH="$HOME/.cargo/bin/:$PATH"

# add pip binaries to PATH so we can use them
export PATH="$HOME/.local/bin:$PATH"

# add vscode to path for wsl
export PATH="/mnt/c/Users/daren/AppData/Local/Programs/Microsoft VS Code/bin/:$PATH"

# add miniconda3 for lean
# docs: https://github.com/QuantConnect/Lean/tree/master/Algorithm.Python
export PATH="$HOME/miniconda3/bin:$PATH"

############################
####     Do not touch
############################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/nvm/init-nvm.sh

# launch tmux on start
if [ "$TMUX" = "" ]; then tmux; fi

