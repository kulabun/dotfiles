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
sudo dnf install zsh vim docker docker-vim docker-zsh-completion docker-compose cmus awesome git mc htop tmux tmuxinator gcc gcc-c++ cmake make tlp tlp-rdw powertop uuid -y
npm install typings
npm install typings --global

# Fedy installer
bash -c 'su -c "curl http://folkswithhats.org/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer"'

# Install Java
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm" -O jdk8-linux-x64.rpm
rpm -i jdk8-linux-x64.rpm

# Install IntelliJ IDEA
wget "https://download.jetbrains.com/idea/ideaIU-2016.2.4.tar.gz" -O idea.tar.gz
tar xzvf idea.tar.gz
rm idea.tar.gz
sudo mv idea-IU* /opt/idea

# Fix keyboard layout (reverse Fn + swap <> and `~) and rebuild initramfs
sudo su -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'
echo 'options hid_apple fnmode=2' | sudo tee -a /etc/modprobe.d/hid_apple.conf
echo 'options hid_apple iso_layout=0' | sudo tee -a /etc/modprobe.d/hid_apple.conf
echo 'options usbcore autosuspend=1' | sudo tee -a /etc/modprobe.d/usbcore.conf
cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
dracut -f

# Override system configuration
sudo su -c 'cp -Rn etc /etc'

# Add noatime,discard for all ssd partitions in fstab

# Reverse scrolling

# Power save 
sudo systemctl enable powertop.service
sudo systemctl start powertop.service
