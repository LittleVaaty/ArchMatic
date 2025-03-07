#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING XORG"
echo

PKGS=(
  'linux'
  'linux-headers'
  'linux-lts'
  'linux-lts-headers'
  'linux-firmware'
  'git'
  'base-devel'
  'mesa'
  'libva-mesa-driver'
  'lvm2'
  'plymouth'
  'sudo'
)

for PKG in "${PKGS[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo

