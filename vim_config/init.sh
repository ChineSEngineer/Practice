#!/bin/bash

sudo apt-get update
sudo apt-get -y install build-essential cmake
sudo apt-get -y install cppcheck
sudo apt-get -y install universal-ctags
sudo apt-get -y install global cmake python-dev python3-dev

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# add color scheme
mkdir -p ~/.vim/colors/
cp ./molokai.vim ~/.vim/colors

# cp vimrc
cp .vimrc ~/.vimrc
vim +PlugInstall +qall


# Add swapfile to compile YCM
sudo fallocate -l 1G ~/swapfile
sudo dd if=/dev/zero of=~/swapfile bs=1024 count=1048576
sudo chmod 600 ~/swapfile
sudo mkswap ~/swapfile
sudo swapon ~/swapfile

# verify swapfile
sudo swapon --show
sudo free -h

# compile YCM
cd ~/.vim/plugged/YouCompleteMe/
./install.py --clang-completer
cd -

# clean the swapfile
sudo swapoff ~/swapfile
sudo rm ~/swapfile

# mv YCM conf file
cp .ycm_extra_conf.py ~/.vim/

