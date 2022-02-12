#!/bin/sh

sudo echo downloader > /etc/hostname
echo "Changed hostname to downloader"

sudo apt -y install nfs-common
echo "Installed nfs-common"

mkdir /home/joel/media
sudo nano "192.168.1.3:/home/joel/media /home/joel/media  nfs      defaults    0       0" >> /etc/fstab
echo "Created media folder and added nfs share to fstab"

sudo mount -a
echo "Mounted nfs share"

sudo docker pull linuxserver/transmission
#sudo docker pull linuxserver/sabnzbd
sudo docker pull linuxserver/nzbget
echo "Pulled docker images"

sudo docker run -d \
  --name=transmission \
  -e PUID=222 \
  -e PGID=321 \
  -e UMASK=002 \
  -e TZ=Pacific/Honolulu \
  -e TRANSMISSION_WEB_HOME=/combustion-release/ \
  -e USER=joel \
  -e PASS=JtK662001 \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v ~/media/appdata/transmission:/config \
  -v ~/media/data/torrents:/data/torrents \
  --restart unless-stopped \
  linuxserver/transmission
  
echo "Started transmission"

sudo docker run -d \
  --name=nzbget \
  -e PUID=223 \
  -e PGID=321 \
  -e UMASK=002 \
  -e TZ=Pacific/Honolulu \
  -p 6789:6789 \
  -v ~/media/appdata/nzbget:/config \
  -v ~/media/data/usenet:/data/usenet \
  --restart unless-stopped \
  linuxserver/nzbget

echo "Started nzbget"
#sudo docker run -d \
#  --name=sabnzbd \
#  -e PUID=333 \
#  -e PGID=321 \
#  -e UMASK=002 \
#  -e TZ=Pacific/Honolulu \
#  -p 8080:8080 \
#  -v ~/media/appdata/sabnzbd:/config \
#  -v ~/media/data/usenet:/data/usenet  \
#  --restart unless-stopped \
#  linuxserver/sabnzbd

echo "Press any key then enter to reboot"

sudo reboot -h now
