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
  'curl'     # Remote content retrieval
  'feh'      # Terminal-based image viewer/manipulator
  'gufw'     # Firewall manager
  'ntp'      # Network Time Protocol to set time via network.
  'rsync'    # Remote file sync utility
  'unrar'    # RAR compression program
  'unzip'    # Zip compression program
  'wget'     # Remote content retrieval
  'zip'      # Zip compression program
  'zsh'      # ZSH shell

  # DISK UTILITIES ------------------------------------------------------

  'autofs'  # Auto-mounter
  'gparted' # Disk utility

  # GENERAL UTILITIES ---------------------------------------------------

  'ghostty'
  'ttf-inconsolata-nerd'

  # DEVELOPMENT ---------------------------------------------------------

  'clang'  # C Lang compiler
  'cmake'  # Cross-platform open-source make system
  'git'    # Version control system
  'gcc'    # C/C++ compiler
  'meld'   # File/directory comparison
  'nodejs' # Javascript runtime environment
  'npm'    # Node package manager
  'python' # Scripting language
  'yarn'   # Dependency management (Hyper needs this)
  'git'
  'github-cli' # Cli client for github
  'neovim'     # Text editor
  'arduino-ide'
  'arduino-avr-core'

  # WEB TOOLS -----------------------------------------------------------

  'firefox' # Web browser

  # COMMUNICATIONS ------------------------------------------------------

  # MEDIA ---------------------------------------------------------------

  'nscpot' # Terminal client for spotify

  # GRAPHICS AND DESIGN -------------------------------------------------

  'gimp' # GNU Image Manipulation Program

  # PRODUCTIVITY --------------------------------------------------------

  # VIRTUALIZATION ------------------------------------------------------

)

for PKG in "${PKGS[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
