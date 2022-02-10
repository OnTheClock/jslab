#!/bin/sh

sudo docker pull linuxserver/transmission
sudo docker pull linuxserver/sabnzbd

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
  
sudo docker run -d \
  --name=sabnzbd \
  -e PUID=333 \
  -e PGID=321 \
  -e UMASK=002 \
  -e TZ=Pacific/Honolulu \
  -p 8080:8080 \
  -v ~/media/appdata/sabnzbd:/config \
  -v ~/media/data/usenet:/data/usenet  \
  --restart unless-stopped \
  linuxserver/sabnzbd
