#!/usr/bin/env bash

reset="\e[0m"
green="\e[32m"
red="\e[31m"
blue="\e[36m"
mbprefix="\e[36mMyBash$reset ➡️ "

# Función para mostrar mensajes de error
error() {
  echo -e "$mbprefix $red$1$reset"
  if [[ -n "$2" ]]; then
    echo -e "$red$2$reset"
  fi
}

# Función para mostrar mensajes de éxito
success() {
  echo -e "$mbprefix $green$1$reset"
}

# Función para mostrar mensajes informativos
info() {
  echo -e "$mbprefix $1$reset"
}

info "Installing..."

info "Checking if zsh is installed..."
if ! command -v zsh &> /dev/null; then
  info "Zsh not found, installing..."
  sudo apt install zsh -y || error "Failed to install zsh."
  success "Zsh installed!"
  info "Assigning zsh as default shell..."
  chsh -s $(which zsh) || error "Failed to assign zsh as default shell."
else 
  success "Zsh is already installed!"
fi

info "Checking if mybash config is added"
if ! grep -q "mybash" ~/.zshrc; then
  info "Adding mybash config to ~/.zshrc"
  echo '\n' >> ~/.zshrc
  cat ~/.mybash/templates/.zshrc >> ~/.zshrc || error "Failed to add mybash config to ~/.zshrc."
else 
  success "Mybash config is already added!"
fi

info "Adding or replacing gitconfig with mybash gitconfig"
cp ~/.mybash/templates/.gitconfig ~/.gitconfig || error "Failed to copy gitconfig."

info "Refreshing console with a new configuration"
source ~/.mybash/.init &> /dev/null || error "Failed to refresh console."
refreshMyBash &> /dev/null || error "Failed to refresh MyBash."

info "Activating nvm for node version management"
source ~/.mybash/node/nvm/nvm.sh &> /dev/null || error "Failed to activate nvm."

info "Checking if node is installed"
if ! nvm use --lts &> /dev/null; then
  info "Node not installed, installing the latest version..."
  nvm install --lts || error "Failed to install Node."
else 
  success "The latest version of Node is already installed!"
fi

info "Checking if npm configuration is added"
if [[ "$(npm config get init-author-username)" == "undefined" ]]; then
  info "Adding npm configuration..."
  cp ~/.mybash/templates/.npmrc ~/.npmrc || error "Failed to copy npm configuration."
else 
  success "Npm configuration is already added!"
fi

# Instalación de python3-pip y requests
info "Checking if python3-pip is installed..."
if ! command -v pip3 &> /dev/null; then
  info "python3-pip not found, installing..."
  sudo apt install python3-pip -y || error "Failed to install python3-pip."
  success "python3-pip installed!"
else 
  success "python3-pip is already installed!"
fi

info "Checking if requests is installed..."
if ! pip3 show requests &> /dev/null; then
  info "requests not found, installing..."
  pip3 install requests || error "Failed to install requests."
  success "requests installed!"
else 
  success "requests is already installed!"
fi

success "Installed!"