#!/usr/bin/env bash

# Please note that this script is not foolproof at all and you
# should only be using it if you know what you're doing!
# You've been warned!

# Initialize variables as empty/0
disk=""
partition=0
label=""
rootpartition=""
options=""

# Get the user's input
printf "Which disk contains your bootloader? (as in /dev/sdX, enter X only)\n> "
read -r disk

printf "What partition? (as in /dev/sd%sY)\n> " "$disk"
read -r partition

printf "What label to use?\n> "
read -r label

printf "What's your root Linux partition? (e.g. /dev/sda2)\n> "
read -r rootpartition

printf "Any custom kernel options?\n> "
read -r options

# Get the root partition's UUID
rootpartuuid=$(blkid | grep "$rootpartition" | awk '{print $4}')

# The final command
cmd="sudo efibootmgr --disk /dev/sd$disk --part $partition --create --label \"$label\" --loader /vmlinuz-linux --unicode 'BOOT_IMAGE=/vmlinuz-linux root=$rootpartuuid rw initrd=/initramfs-linux.img $options' --verbose"

# Print it for now
printf "%s\n" "$cmd"

