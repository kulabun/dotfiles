#!/bin/bash
OS_DISK=/dev/nvme0n1
HOME_DISK=/dev/sda
USERNAME=klabun

read -p "Please enter your desired password:" PASSWORD

sudo parted $OS_DISK -- mklabel gpt
sudo parted $OS_DISK -- mkpart ESP fat32 1MiB 1GiB set 1 boot on
sudo parted $OS_DISK -- mkpart primary ext4 1GiB 100%

sudo mkfs.fat -F 32 -n BOOT  ${OS_DISK}p1

echo -n $PASSWORD | sudo cryptsetup -q --type luks1 luksFormat ${OS_DISK}p2 -
echo -n $PASSWORD | sudo cryptsetup luksOpen ${OS_DISK}p2 root -d -
sudo mkfs.ext4 -L root /dev/mapper/root

sudo parted $HOME_DISK -- mklabel gpt
sudo parted $HOME_DISK -- mkpart primary ext4 1MiB 100% 

echo -n $PASSWORD | sudo cryptsetup -q --type luks1 luksFormat ${HOME_DISK}1 -
echo -n $PASSWORD | sudo cryptsetup luksOpen ${HOME_DISK}1 home -d -
sudo mkfs.ext4 -L root /dev/mapper/home

sudo mount /dev/mapper/root /mnt
sudo mkdir /mnt/home && sudo mount /dev/mapper/home /mnt/home
sudo mkdir /mnt/boot && sudo mount ${OS_DISK}p1 /mnt/boot

sudo nixos-generate-config --root /mnt
cd /mnt/etc/nixos
sudo mv configuration.nix configuration.nix.old
sudo wget -q https://raw.githubusercontent.com/kulabun/dotfiles/nix/configuration.nix
sudo sed -i "s~##username##~${USERNAME}~g" configuration.nix
sudo sed -i "s~##rootpasswd##~${PASSWORD}~g" configuration.nix
