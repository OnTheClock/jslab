#!/bin/sh

sudo docker pull linuxserver/ombi:development
sudo docker pull linuxserver/jackett
sudo docker pull linuxserver/radarr
sudo docker pull linuxserver/sonarr
sudo docker pull plexinc/pms-docker


sudo docker run -d \
  --name=ombi \
  -e PUID=888 \
  -e PGID=321 \
  -e TZ=Pacific/Honolulu \
  -e BASE_URL=/ombi \
  -p 3579:3579 \
  -v ~/media/appdata/ombi:/config \
  --restart unless-stopped \
  linuxserver/ombi:development
  
sudo docker run -d \
  --name=jackett \
  -e PUID=666 \
  -e PGID=321 \
  -e UMASK=002 \
  -e TZ=Pacific/Honolulu \
  -e AUTO_UPDATE=true \
  -p 9117:9117 \
  -v ~/media/appdata/jackett:/config \
  -v ~/media/appdata/transmission/torrents:/config/torrents \
  --restart unless-stopped \
  linuxserver/jackett
  
sudo docker run -d \
  --name=radarr \
  -e PUID=555 \
  -e PGID=321 \
  -e UMASK=002 \
  -e TZ=Pacific/Honolulu \
  -p 7878:7878 \
  -v ~/media/data:/data \
  -v ~/media/appdata/radarr:/config \
  --restart unless-stopped \
  linuxserver/radarr
  
sudo docker run -d \
  --name=sonarr \
  -e PUID=777 \
  -e PGID=321 \
  -e UMASK=002 \
  -e TZ=Pacific/Honolulu \
  -p 8989:8989 \
  -v ~/media/data:/data \
  -v ~/media/appdata/sonarr:/config \
  --restart unless-stopped \
  linuxserver/sonarr
  
sudo docker run \
  -d \
  --name plex \
  --network=host \
  -e PUID=444 \
  -e GUID=321 \
  -e UMASK=002 \
  -e TZ="Pacific/Honolulu" \
  -v ~/media/appdata/plex/plexdb:/config \
  -v ~/media/appdata/plex/plextc:/transcode \
  -v ~/media/data/library:/library \
  --restart unless-stopped \
plexinc/pms-docker
