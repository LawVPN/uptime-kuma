#!/bin/bash

# update software repositories
sudo apt update
# install available software updates
sudo apt upgrade -y
# install prerequisites
sudo apt install git curl -y
# add nodejs software repository
curl -sL https://deb.nodesource.com/setup_current.x | sudo bash -
# install nodejs
sudo apt install nodejs -y
# clone from git
git clone https://github.com/louislam/uptime-kuma.git ./uptime-kuma
# change directory to ./uptime-kuma
cd uptime-kuma
# run setup
npm run setup
# run uptime kuma
node server/server.js

# create nodejs user
sudo useradd nodejs
# change directory out of uptime-kuma
cd ..
# move uptime kuma to /opt
sudo mv ~/uptime-kuma /opt
# create service bash file
echo -e "#!/usr/bin/bash
/usr/bin/node /opt/uptime-kuma/server/server.js" > /opt/uptime-kuma/uptime-kuma.sh


# make uptime-kuma.sh executable
sudo chmod +x /opt/uptime-kuma/uptime-kuma.sh
# create uptime-kuma service file
echo -e "[Unit]
Description=Uptime Kuma

[Service]
ExecStart=/opt/uptime-kuma/uptime-kuma.sh
Restart=always
User=nodejs
Group=nodejs
WorkingDirectory=/opt/uptime-kuma

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/uptime-kuma.service

# set owner of /opt/uptime-kuma
sudo chown nodejs:nodejs /opt/uptime-kuma -R
# reload systemd services
sudo systemctl daemon-reload
# start uptime-kuma service on boot and now
sudo systemctl enable uptime-kuma --now
