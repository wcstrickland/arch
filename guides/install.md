# create usb
# boot 
# check internet
```
ping -c 3 google.com
```
# enable network time protocols
```
timedatectl set-ntp true
```
```
timedatectl status
```
# list all disks
```
fdisk -l
```
# partition the disk
```
cfdisk /dev/sda
```
# select dos as type
# /dev/sda1 should be primary, type 83 linux, and set to bootable
# /dev/sda2 should be logical, type swap and at least twice the available ram 
# create filesystem
```
mkfs.ext4 /dev/sda1
```
```
mkswap /dev/sda2
```
# mount the filesystem
```
mount /dev/sda1 /mnt
```
```
swapon /dev/sda2
```
# sync pacman
```
pacman -Syy
```
# install reflector
```
pacman -S reflector
```
# backup mirrorlist
```
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
```
# use reflector to sort mirrors by download speed
```
reflector --verbose --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
```
# install via pacstrap
```
pacstrap /mnt base linux linux-firmware texinfo man-db vim dhcpcd networkmanager sudo base-devel inetutils iputils net-tools netctl ethtool wpa_supplicant
```
# generate the fstab file
```
genfstab -U /mnt >> /mnt/etc/fstab
```
# use arch-chroot to enter the mounted disk as root
```
arch-chroot /mnt
```
# set timezone
```
timedatectl set-timezone America/Chicago
```
# set the locale
```
sudo vim /etc/locale.gen
```
## uncomment en_US.UTF-8 UTF-8
## add locale configuration
```
echo LANG=en_US.UTF-8 > /etc/locale.conf
```
# set hostname
```
echo [your_hostname] > /etc/hostname
```
```
touch /etc/hosts
```
### add to hosts file
127.0.0.1   localhost

::1         localhost

127.0.1.1   [your_hostname]
# enable dhcpcd
```
systemctl enable dhcpcd
```
# set root password
```
passwd
```
# create a user
```
sudo useradd -m bill
```
```
passwd bill
```
# update sudoers file
```
sudo EDITOR=vim visudo
```
### uncomment the wheel group
```
sudo usermod -a -G wheel bill
```
# install grub
```
pacman -S grub os-prober
```
```
grub-install /dev/sda
```
```
grub-mkconfig -o /boot/grub/grub.cfg
```
# exit arch-chroot
```
exit
```
```
sudo reboot
```
# fingers crossed

