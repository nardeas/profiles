echo "Linking bash profiles..."
ln -s $PWD/bash_functions ~/.bash_functions
ln -s $PWD/bash_helpers ~/.bash_helpers
ln -s $PWD/bash_profile ~/.bash_profile
chmod a+x ~/.bash_*

echo "Linking nvim profiles..."
mkdir -p ~/.config/nvim
ln -s $PWD/init.vim ~/.config/nvim/init.vim
ln -s $PWD/colors/nvim ~/.config/nvim/colors

echo "All done."

