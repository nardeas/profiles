# NOTES:
#
# Helpful extensions: rg, jq, fzf, bat, trash
#
# To use Homebrew llvm clang instead of Apples own with global setting:
# export CC=/usr/local/opt/llvm/bin/clang
# Alternatively, check the output on 'brew info llvm'
#
source ~/.bash_functions
source ~/.bash_helpers

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

export VIMRC="~/.config/nvim/init.vim"
export VISUAL="/usr/bin/vim -u ~/.vimrc"

alias ipy="ipython"
alias vim="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

PROMPT_COMMAND=before_prompt
