#!bin/bash

#My ubuntu setup script. Installs the themes and stuff that I want creates a swap file to hibernate if I'm on a laptop. Removes and installs programs. Also installs themes and tweaks that I want as well. 
#Including notes for myself to remember what to do in case i forget some steps or file locations
#Run the script inside the cloned directory

#Apt installs

sudo apt install git node-typescript make gnome-shell-extensions gnome-backgrounds gnome-tweaks fish
sudo chsh -s /usr/bin/fish davy
chsh -s /usr/bin/fish
sudo apt remove firefox thunderbird


#Pop-shell stuff
cd shell
make local-install
cd ..

#Themes and icons
sudo tar -xf Big\ Sur\ Dark\ \ -\ OE2\ Theme1.7v.tar.xz -C /usr/share/themes
sudo tar -xf Sweet-Purple-Filled.tar.xz -C /usr/share/icons
sudo tar -xf Sweet-Purple.tar.xz -C /usr/share/icons
sudo tar -xf Sweet-Rainbow.tar.xz -C /usr/share/icons
sudo tar -xf candy-icons.tar.xz -C /usr/share/icons
sudo tar -xf Sweet-Teal-Filled.tar.xz -C /usr/share/icons
sudo tar -xf Sweet-Teal.tar.xz -C /usr/share/icons
sudo tar -xf Sweet-Dark.tar.xz -C /usr/share/themes
sudo tar -xf Sweet.tar.xz -C /usr/share/themes

#Hibernate
sudo swapoff /dev/dm-2
sudo cryptsetup luksClose /dev/dm-2
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "Swap file offset: "
sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'

#instructions to finish setup
echo "Edit /etc/fstab to say /swapfile.
Use this command:   sudo gedit /etc/fstab
"
echo "Edit /etc/fstab to say resume=(root location{it's probably: /dev/mapper/vgubuntu-root}) and resume_offset=(result of filefrag).
Use this command:   sudo gedit /etc/default/grub
"
echo "Edit /etc/systemd/sleep.conf to change lid switch to suspend-then-hibernate.
Use this command:   sudo gedit /etc/systemd/sleep.conf
"
echo "Edit /etc/systemd/logind.conf to suspend timer to 30min.
Use this command:   sudo gedit /etc/systemd/logind.conf
"


