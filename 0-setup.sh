#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

if ! source install.conf; then
	read -p "Please enter hostname:" hostname

	read -p "Please enter username:" username

	read -ps "Please enter password:" password

	read -sp "Please repeat password:" password2

	# Check both passwords match
	if [ "$password" != "$password2" ]; then
	    echo "Passwords do not match"
	    exit 1
	fi
  printf "hostname="$hostname"\n" >> "install.conf"
  printf "username="$username"\n" >> "install.conf"
  printf "password="$password"\n" >> "install.conf"
fi

echo "--------------------------------------"
echo "-- Bootloader Systemd Installation  --"
echo "--------------------------------------"
bootctl --path=/boot install
rm /boot/loader/loader.conf
cat <<EOF > /boot/loader/loader.conf
default arch
timeout 3
editor 0
EOF

cat <<EOF > /boot/loader/entries/arch.conf
title Arch Linux
linux /vmlinuz-linux
initrd  /initramfs-linux.img
options root=${DISK}2 rw
EOF

bootctl update
mkinitcpio -p linux

echo "--------------------------------------"
echo "--          Network Setup           --"
echo "--------------------------------------"
pacman -S network-manager dhclient --noconfirm --needed
systemctl enable --now NetworkManager

echo "--------------------------------------"
echo "--      Set Password for Root       --"
echo "--------------------------------------"
echo "Enter password for root user: "
passwd root

echo "-------------------------------------------------"
echo "Setting up mirrors for optimal download - FR/BE  "
echo "-------------------------------------------------"
pacman -Syy --noconfirm reflector
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c "BE" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
nc=$(grep -c ^processor /proc/cpuinfo)
echo "You have " $nc" cores."
echo "-------------------------------------------------"
echo "Changing the makeflags for "$nc" cores."
sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$nc"/g' /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g' /etc/makepkg.conf

echo "-------------------------------------------------"
echo "       Setup Language to EN and set locale       "
echo "-------------------------------------------------"
sed -i 's/^#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
timedatectl --no-ask-password set-timezone Europe/Brussels
timedatectl --no-ask-password set-ntp 1
localectl --no-ask-password set-locale LANG="en_GB.UTF-8" LC_COLLATE="" LC_TIME="en_GB.UTF-8"

# Set keymaps
localectl --no-ask-password set-keymap be-latin1

# Hostname
hostnamectl --no-ask-password set-hostname $hostname

# Add sudo no password rights
sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

