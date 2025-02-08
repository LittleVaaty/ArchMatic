#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING SOFTWARE"
echo

PKGS=(
  'base-devel'

  # TERMINAL UTILITIES --------------------------------------------------
  'lsd' # Better ls
  'fish'
  'starship' # Prompt
  'atuin'
  'bottom' # System monitoring
  'fzf'
  'fd'
  'neofetch' # Shows system info when you launch terminal
  'openssh'  # SSH connectivity tools
  'bat'      # Better cat
  'tmux'     # terminal multiplexer
  'yazi'     # Terminal file manager
  'dust'     # Disk usage tool

  # DEVELOPMENT ---------------------------------------------------------
  'git'        # Version control system
  'github-cli' # Cli client for github
  'neovim'     # Text editor
  'python'     # python

  # MEDIA ---------------------------------------------------------------
  'nscpot' # Terminal client for spotify

)

for PKG in "${PKGS[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo

echo
echo "INSTALLING YAY"
echo

cd /tmp/
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ~
rm /tmp/yay

echo
echo "Done!"
echo

echo "INSTALLING RUST"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo
echo "Done!"
echo

echo
echo "Setup"
echo

chsh -s /usr/bin/zsh
gh auth login

mkdir ~/repo
cd ~/repo
gh repo clone LittleVaaty/dotfiles -- --recurse-submodules
gh repo clone LittleVaaty/ArchMatic
ya pack -a Chromium-3-Oxide/everforest-medium
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cd ~
echo
echo "Done!"
echo
