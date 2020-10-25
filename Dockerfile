# set base os
# old os
# FROM phusion/baseimage:0.9.16
FROM phusion/baseimage:0.9.22
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root
ENV TERM xterm
# Configure user nobody to match unRAID's settings
RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home && \

#Install Asset-upnp 6.6
apt-get update && \
apt-get install -y wget && \
mkdir -p /usr/bin/asset && \
chmod -R 777 /usr/bin/asset && \
cd /usr/bin/asset && \
wget https://www.dbpoweramp.com/install/Asset-RaspberryPi.tar.gz && \
tar -zxvf *.gz && \
rm *.gz && \
apt-get purge --remove -y wget && \
apt-get autoremove -y && \
apt-get clean
VOLUME /root/.dBpoweramp
VOLUME /music
EXPOSE 45537/tcp 26125/tcp 1900/udp
ENTRYPOINT ["/usr/bin/AssetUPnP"]
