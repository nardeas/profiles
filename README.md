# Profiles

> Run `update.sh` to update all symlinks at once

**Bash:**
```
ln -s $PWD/bash_functions ~/.bash_functions
ln -s $PWD/bash_helpers ~/.bash_helpers
ln -s $PWD/bash_profile ~/.bash_profile
chmod a+x ~/.bash_*
```

**Vim:**

```
mkdir -p ~/.config/nvim
ln -s $PWD/init.vim ~/.config/nvim/init.vim
ln -s $PWD/colors/nvim ~/.config/nvim/colors
```

> Additionally install **vim-plug** using:
> ```
> sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
> ```
