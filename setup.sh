#!/bin/bash

DOT_FILES=(.bashrc .bash_profile)
VS_CODE_FILES=(settings.json keybindings.json)

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in ${VS_CODE_FILES[@]}
do
  ln -s $HOME/dotfiles/vscode/$file $HOME/Library/Application\ Support/Code/User/$file
done
