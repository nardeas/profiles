source ~/.bash_functions
source ~/.bash_tools

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(ssh-agent -s)" 1>/dev/null
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
if command -v pyenv virtualenv 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi

alias free="top -l 1 -s 0 | grep PhysMem"
export VIMRC="~/.config/nvim/init.vim"
export VISUAL="/usr/bin/vim -u ~/.vimrc"

# Tools
alias vim="nvim"

# Editing aliases
alias reloadprofile="source ~/.bash_profile"
alias editprofile="nvim ~/.bash_profile"
alias editvim="nvim ~/.config/nvim/init.vim"

# Common aliases
alias ls="ls -G"
alias rmff="/bin/rm -rf"
alias rmf="/bin/rm"
alias rm="trash -v"
alias rmq="trash"

# Directory navigation aliases
alias cdd="cd ~/Desktop"
alias cdp="cd ~/Private"

# Python aliases
alias ipy="ipython"

# Extra aliases
alias ccat="/usr/local/bin/bat --theme=GitHub"
alias z="ffind"
alias ze="ffedit"
alias zl="ffless"

# Clipboard copy without newline
alias xclip="tr -d '\n' | pbcopy"

# Recursively remove DS_Store files
alias dsremove="find . -name '.DS_Store' -type f -delete"
# NOTES:
# Installed extensions:
# - rg
# - jq
# - fzf
# - bat

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PROMPT_COMMAND=before_prompt
