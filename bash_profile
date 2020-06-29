source ~/.bash_functions

eval "$(ssh-agent -s)" 1>/dev/null

#export PS1='($(pyenv version-name)) '$PS1
export VIMRC="~/.config/nvim/init.vim"

alias free="top -l 1 -s 0 | grep PhysMem"
alias workon="pyenv activate $1"
alias workoff="pyenv deactivate"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv virtualenv 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi

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

# Python aliases
alias ipy="ipython"

# Extra aliases
alias ccat="/usr/local/bin/bat"
alias z="ffind"
alias ze="ffedit"

