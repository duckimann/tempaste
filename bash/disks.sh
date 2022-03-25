# List Drives
# Git Bash
cat /proc/partitions;
# Bash
sudo fdisk -l;
lsblk -f;

# dd Commands
dd if=<source> of=<output> bs=32M status=progress
# Compress w/ gzip
dd if=/dev/hdb | gzip -c  > /image.img.gz
# Restore w/ gzip
gunzip -c /image.img.gz | dd of=/dev/hdb