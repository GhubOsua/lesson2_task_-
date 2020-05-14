#!/bin/bash
sudo yum -y install mdadm
#
echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

sudo mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

sudo mdadm --create --verbose /dev/md0 -l 5 -n 5 /dev/sd{b,c,d,e,f}
echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

cat /proc/mdstat
sudo mkdir /etc/mdadm
sudo bash -c "echo \"DEVICE partitions\" > /etc/mdadm/mdadm.conf"
sudo bash -c "mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf"
echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

#sudo bash -c 'echo "DEVICE partitions" > /etc/mdadm/mdadm.conf && mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf'
echo '============================='
echo '1. Создание GPT раздедела на RAID'
sudo parted -s /dev/md0 mklabel gpt
echo '===________________________________==='

echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

echo '2. Создание 5  партиций'
sudo parted /dev/md0 mkpart primary ext4 0% 20%
sudo parted /dev/md0 mkpart primary ext4 20% 40%
sudo parted /dev/md0 mkpart primary ext4 40% 60%
sudo parted /dev/md0 mkpart primary ext4 60% 80%
sudo parted /dev/md0 mkpart primary ext4 80% 100%
echo '===________________________________==='

echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

echo '3. Создание ФС на партициях'
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done
echo '===________________________________==='
echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

echo '4. Создание т. для монитирования'
sudo  mkdir -p /raid/part{1,2,3,4,5}
echo '===________________________________==='

echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"

echo '5. Монтирование'
for i in $(seq 1 5); do sudo mount /dev/md0p$i /raid/part$i; done
echo '===________________________________==='
echo "Sleeping for 5 seconds…"
sleep 5
echo "Completed"
