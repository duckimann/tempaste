#!/bin/bash
# How to use
# Create partition with name "persistence" (Case sensitive) and File System "ext4"
# chmod +x to this file
# ./mkPersis.sh
fdisk -l;
lsblk -f;
read -rep $'"persistence" Partition (/dev/sd##): ' PART;
echo "1/4: Making Folder /mnt/kali" & mkdir -p /mnt/kali;
echo "2/4: Mounting Partition to Folder" & sudo mount $PART /mnt/kali;
echo "3/4: Echo persistence.conf" & echo "/ union" > /mnt/kali/persistence.conf;
echo "4/4: Unmount & Reboot" & sudo umount $PART && sudo reboot now;

# If you burn the ISO file with Rufus, you can adjust the persistence partition size
# and it will make a perfect replica of what i did above
# * Not tested yet.