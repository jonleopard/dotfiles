#!/bin/bash
# install.sh - main install script
# Jon Leopard (jontron2000@gmail.com)
################################################################################

# Prompt user before continuing
prompt_confirm() {
  while true; do
    read -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid option"
    esac
  done
}
echo  "WARNING! This script will backup existing dotfiles to ${HOME}/bak"
prompt_confirm "Do you wish to continue?" || exit 0

# Backup existing dotfiles
sleep .5
echo "Backing up existing dotfiles..."
cd || exit
shopt -s dotglob
for file in ./*rc ./*profile tmux.conf; do
    [[ -e $file ]] || continue
    mkdir -pv bak
    mv "$file" bak/
done
echo

# CD Into Dotfiles folder
sleep .5
echo "Current path is ${PWD}"
if [ "$(PWD)" != "$(PWD)"/dotfiles ]; then
  echo "Changing directory..." && cd ./dotfiles || return
fi
echo "Path is now ${PWD}"
echo

# Discover system type
sleep .5
kernel_type="$(uname -s)"
echo "Inspecting kernel..."
echo "kernel type: ${kernel_type}"

# Linux (Ubuntu)
sleep .5
if [ "$kernel_type" = 'Linux' ]; then
    echo "Installing prerequisites for Linux (ubuntu)..."
    [ -x "$(command -v stow)" ] &&
      apt-get install -y stow && apt-get install -y neovim
fi

# MacOS
sleep .5
if [ "$kernel_type" = 'Darwin' ]; then
  # Check if homebrew is installed
  echo "Looks like you're on a mac. Checking if Homebrew and GNU Stow are installed..."
  if [ ! -f "$(which brew)" ] || [ ! -f "$(which stow)" ]; then
      echo "Missing homebrew. Installing..." >&2
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &&
      brew install stow
      echo "Dependencies installed. Proceeding..."
  else
      echo "Dependencies are already installed. Proceeding..."
      echo
  fi
fi

# Dotfile selection
while true; do
echo "Alright, ${USER}, which dotfiles would you like to use?"
echo "1. zsh"
echo "2. vim"
echo "3. ssh"
echo "0. Proceed"
echo

echo -n "Select which dotfiles you want and then press 0 to proceed: "
read -r choice
echo

case $choice in
     1)
     echo "Symlinking zsh dotfiles..."
     echo
     stow zsh
     ;;
     2)
     echo "Symlinking vim dotfiles..."
     echo
     stow nvim
     ;;
     3)
     stow ssh
     echo "Symlinking ssh dotfiles..."
     echo
     ;;
     0)
     echo "Proceeding..."
     echo
     break
     ;;
     *) echo "Invalid option"
     ;;
esac
done

# Homebrew packages
prompt_homebrew() {
if [ "$kernel_type" = 'Darwin' ]; then
  while true; do
    read -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) brew bundle ; return 0 ;;
      [nN]) echo ; return 0 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid option"
    esac
  done
fi
}
prompt_homebrew "Would you like to install all the Homebrew packages?" || exit 0



# Shell Switch
prompt_shell() {
if [ "$SHELL" = '/bin/bash' ]; then
  while true; do
   read -p "${1:-Continue} [y/n]: " REPLY
   case $REPLY in
    [yY]) echo "Switching to brew zsh, please restart your shell after installation completes." && sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh && source ~/dotfiles/zsh/.zsh* ; return 0 ;;
    [nN]) echo ; return 0 ;;
    *) printf " \033[31m %s \n\033[0m" "invalid option"
    esac
  done
fi
}
prompt_shell "Would you like to swith to zsh?" || exit 0


# Color Scheme
echo "Setting up base16 colors"
stow colors && base16_snazzy


#Antibody (ZSH Plugin setup)
prompt_antibody() {
if [ "$SHELL" = '/usr/local/bin/zsh' ]; then
  while true; do
    read -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) cd zsh/.zsh/install.sh && ./install.sh ; return 0 ;;
      [nN]) echo ; return 0 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid option"
    esac
  done
fi
}
prompt_antibody "Would you like to install ZSH Plugins with Antigen?" || exit 0

# Neovim
prompt_vim() {
if [ "$kernel_type" = 'Darwin' ]; then
  while true; do
    read -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) chmod +x ./install-vim.sh && ./install-vim; return 0 ;;
      [nN]) echo ; return 0 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid option"
    esac
  done
fi
}
prompt_vim "Would you like to set up Neovim's dependencies (vim-plug/ruby/python)?" || exit 0


# MacOS System Variables (Todo)



echo "All done!" || exit 0
