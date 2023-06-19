#!/bin/bash

echo "\e[36mMyBash ➡️\e[0m Installing..."

echo "\e[36mMyBash ➡️\e[0m Checking if zsh is installed..."
zshVersion=`zsh --version 2>&1 > /dev/null`

if [[ "$zshVersion" == *"not found"* ]]; then
  echo "\e[36mMyBash ➡️\e[0m Installing zsh..."
  sudo apt install zsh -y
  echo "\e[36mMyBash ➡️\e[0m Assign zsh by default shell..."
  chsh -s $(which zsh)
else 
  echo "\e[36mMyBash ➡️\e[0m Zsh is already installed!"
fi

echo "\e[36mMyBash ➡️\e[0m Adding mybash config to ~/.zshrc"
cat ~/.mybash/templates/.zshrc >> ~/.zshrc

echo "\e[36mMyBash ➡️\e[0m Adding or replacing gitconfig with mybash gitconfig"
cp ~/.mybash/templates/.gitconfig ~/.gitconfig

echo "\e[36mMyBash ➡️\e[0m Refreshing console with a new configuration"
.  ~/.mybash/scripts/refresh
refreshMyBash

echo "\e[36mMyBash ➡️\e[0m Installed!"