#!/bin/bash

sudo yum groupinstall "Development Tools"
sudo yum install -y global
sudo yum install -y python3 python3-devel
sudo yum install -y cmake cppcheck

# intsall universal-ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
make install # may require extra privileges depending on where to install
cd ..
rm -rf ctags

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# add color scheme
mkdir -p ~/.vim/colors/
cp ./molokai.vim ~/.vim/colors

# cp vimrc
cp .vimrc ~/.vimrc
vim +PlugInstall +qall


# compile YCM
cd ~/.vim/plugged/YouCompleteMe/
./install.py --clang-completer
cd -

# mv YCM conf file
cp .ycm_extra_conf.py ~/.vim/

