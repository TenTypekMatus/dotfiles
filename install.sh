#!/bin/bash
echo "Downloading git and base-devel group"
sudo pacman -Syyu --needed --noconfirm base-devel git

echo "MatuusOS installer
By TenTypekMatus"

echo "------------------"
echo "This script will install my config files for i3, polybar and HyprLand.
This script only works on Arch-based distros with SystemD."
echo "Do you want to continue? This will delete ALL of your existing configs.
[Y/n]"

read input
if [ $input = yes ]; then
    echo "Continuing in install"
else
    exit 1
fi

echo "------------------"
echo "Installing paru"
echo "------------------"

git clone https://aur.archlinux.org/paru-bin.git paru
cd paru
makepkg -si

echo "---------------------------"
echo "Installing core packages"
echo "---------------------------"

paru -Syu --needed - < ./pkgs.txt

echo "---------------------------"
echo "Installing betterlockscreen"
echo "---------------------------"

wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip main.zip

cd betterlockscreen-main/
chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/

sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
systemctl enable betterlockscreen@$USER

echo "---------------------------------------------"
echo "Copying dotfiles to their respective location"
echo "---------------------------------------------"
cp -r .config ~
cp -r .themes ~