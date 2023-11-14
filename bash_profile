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

# This re-uses the same SSH auth sock for all sessions, meaning identities only
# need to be added once
#   export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
# Check identities
#   ssh-add -l 2>/dev/null >/dev/null
#   [ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null

# This spawns a new agent for every session
eval "$(ssh-agent -s)" 1>/dev/null
# Add identities
ssh-add --apple-use-keychain 2>/dev/null

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

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
alias edit="vim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

PROMPT_COMMAND=before_prompt
