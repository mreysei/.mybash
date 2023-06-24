#!/usr/bin/env bash

reset="\e[0m"
green="\e[32m"
blue="\e[36m"
mbprefix="\e[36mMyBash ➡️"

echo "$mbprefix$reset Installing..."

echo "$mbprefix$reset Checking if zsh is installed..."
zshVersion=`zsh --version 2>&1 > /dev/null`

if [[ "$zshVersion" == *"not found"* || "$zshVersion" == *"No se ha encontrado"* ]]; then
  echo "$mbprefix$reset Installing zsh..."
  sudo apt install zsh -y
  echo "$mbprefix$green Zsh installed!"
  echo "$mbprefix$reset Assign zsh by default shell..."
  chsh -s $(which zsh)
else 
  echo "$mbprefix$green Zsh is already installed!"
fi

echo "$mbprefix$reset Adding mybash config to ~/.zshrc"
echo "\n" >> ~/.zshrc
cat ~/.mybash/templates/.zshrc >> ~/.zshrc

echo "$mbprefix$reset Adding or replacing gitconfig with mybash gitconfig"
cp ~/.mybash/templates/.gitconfig ~/.gitconfig

echo "$mbprefix$reset Refreshing console with a new configuration"
.  ~/.mybash/.init
refreshMyBash

echo "$mbprefix$reset Activating nvm for node version management"
. ~/.mybash/node/nvm/nvm.sh

echo "$mbprefix$reset Checking if node is installed"
nodeVersion=`nvm use --lts 2>&1 > /dev/null`

if [[ "$nodeVersion" == *"is not yet installed"* ]]; then
  echo "$mbprefix$reset Installing the latest version of Node..."
  nvm install --lts
else 
  echo "$mbprefix$green The latest version of Node is already installed!"
fi

echo "$mbprefix$green Installed!"