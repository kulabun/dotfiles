#/bin/bash

# Install pre-downloaded drivers, compile and load
sudo rpm -i *.rpm 
sudo akmods
sudo depmod -a

# Enable access to both the free and the nonfree RPM Fusion repositories
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y'

# Update system
sudo dnf update --refresh -y

# Install favorite software
sudo dnf install yakuake zsh vim docker docker-vim docker-zsh-completion docker-compose cmus awesome git mc htop tmux tmuxinator gcc gcc-c++ cmake make tlp tlp-rdw powertop uuid maven gradle -y

sudo mkdir /opt/node
wget 'https://nodejs.org/dist/v7.9.0/node-v7.9.0-linux-x64.tar.xz' -O nodejs.tar.xz
sudo tar xJvf nodejs.tar.xz
mv node-*/* /opt/node

sudo unlink /usr/bin/npm
sudo ln -sf /opt/node/bin/npm /usr/bin/npm

sudo unlink /usr/bin/node
sudo ln -sf /opt/node/bin/node /usr/bin/node

sudo npm install -g typings
sudo npm install -g typescript
sudo npm install -g gulp
sudo npm install -g angular-cli
sudo npm install -g nodemon

# Fedy installer
curl https://www.folkswithhats.org/installer | sudo bash

# Install Java
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm" -O jdk8-linux-x64.rpm
rpm -i jdk8-linux-x64.rpm

# Fix keyboard layout (reverse Fn + swap <> and `~) and rebuild initramfs
sudo su -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'
echo 'options hid_apple fnmode=2' | sudo tee -a /etc/modprobe.d/hid_apple.conf
echo 'options hid_apple iso_layout=0' | sudo tee -a /etc/modprobe.d/hid_apple.conf
echo 'options usbcore autosuspend=1' | sudo tee -a /etc/modprobe.d/usbcore.conf
sudo cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
sudo dracut -f

# Override system configuration
sudo su -c 'cp -Rn etc /etc'

# Add noatime for all ssd partitions in fstab (NO DISCARD!)

# TRIM FIX FOR MBP PRO SSD
systemctl enable fstrim.timer
systemctl start fstrim.service

# Reverse scrolling

# Power save 
sudo systemctl enable powertop.service
sudo systemctl start powertop.service

# Install yadm
sudo dnf copr enable thelocehiliosan/yadm
sudo dnf install yadm -y

sudo systemctl enable docker.service

sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
newgrp docker

# Install Spring-CLI for fast prototyping
wget http://repo.spring.io/release/org/springframework/boot/spring-boot-cli/1.5.3.RELEASE/spring-boot-cli-1.5.3.RELEASE-bin.tar.gz
tar xzvf spring-boot-cli-1.5.3.RELEASE-bin.tar.gz
sudo mv spring-1.5.3.RELEASE /opt/spring

# Create links to installed applications 
DIR=`pwd`
cd ~/.local/bin
ln -sf /opt/spring/bin/spring spring
ln -sf /opt/node/bin/node node
ln -sf /opt/node/bin/npm npm
ln -sf /opt/node/bin/ng ng
ln -sf /opt/node/bin/gulp gulp
cd $DIR
