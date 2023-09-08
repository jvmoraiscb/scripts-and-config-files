#!/bin/bash

# saves current directory
current_directory=$PWD

# update default packages
sudo pacman --noconfirm -Syyuu

# install https://github.com/Jguer/yay
sudo pacman --noconfirm -S git base-devel
cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

# install https://github.com/LunarVim/LunarVim
yay --noconfirm -S git python-pip python npm nodejs cargo
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
echo 'export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH' >> ~/.zshrc

# install https://github.com/romkatv/powerlevel10k
yay --noconfirm -S zsh zsh-theme-powerlevel10k-git tft-meslo-nerd-font-powerlevel10k powerline-fonts awesone-terminal-fonts
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
chsh -s /usr/bin/zsh

# install https://github.com/zsh-users/zsh-autosuggestions
mkdir ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'HISTFILE=~/.zsh_history' >> ~/.zshrc
echo 'HISTSIZE=10000' >> ~/.zshrc
echo 'SAVEHIST=10000' >> ~/.zshrc
echo 'setopt appendhistory' >> ~/.zshrc

# install rust plugins
cargo install bat exa

# copy config files and alias
cp $current_directory/config.lua ~/.config/lvim/
cp $current_directory/.p10k.zsh ~/
cat $current_directory/alias.sh >> ~/.zshrc
