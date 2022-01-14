#!bin/bash

sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "Swap file offset: "
sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
cp /etc/fstab ~/Documents/fstab_backup
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
echo "Edit /etc/default/grub to say resume=(root location{it's probably: /dev/mapper/vgubuntu-root}) and resume_offset=(result of filefrag).
Use this command:   sudo gedit /etc/default/grub
"
echo "Edit /etc/systemd/sleep.conf to change lid switch to suspend-then-hibernate.
Use this command:   sudo gedit /etc/systemd/sleep.conf
"
echo "Edit /etc/systemd/logind.conf to suspend timer to 30min.
Use this command:   sudo gedit /etc/systemd/logind.conf
Run: sudo systemctl kill -s HUP systemd-logind :to make changes
"
