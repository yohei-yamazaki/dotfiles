#!/bin/bash

DOT_FILES=(.bashrc .bash_profile .zshrc)
VS_CODE_FILES=(settings.json keybindings.json)
NVIM_FILES=(init.vim dein.toml dein_lazy.toml)

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done

for file in ${VS_CODE_FILES[@]}
do
  ln -s $HOME/dotfiles/vscode/$file $HOME/Library/Application\ Support/Code/User/$file
done

for file in ${NVIM_FILES[@]}
do
  ln -s $HOME/dotfiles/nvim/$file $HOME/.config/nvim/$file
done
