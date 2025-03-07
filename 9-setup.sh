#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "FINAL SETUP AND CONFIGURATION"

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

echo
echo "Configuring LTS Kernel as a secondary boot option"

sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

# ------------------------------------------------------------------------

echo
echo "Configuring MAKEPKG to use all 8 cores"

sudo sed -i -e 's|[#]*MAKEFLAGS=.*|MAKEFLAGS="-j$(nproc)"|g' makepkg.conf
sudo sed -i -e 's|[#]*COMPRESSXZ=.*|COMPRESSXZ=(xz -c -T 8 -z -)|g' makepkg.conf

# ------------------------------------------------------------------------

echo
echo "INSTALLING RUST"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

echo
echo "Enabling Network Time Protocol so clock will be set via the network"

sudo ntpd -qg
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

echo "Done!"
echo
echo "Reboot now..."
echo
