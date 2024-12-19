#!/bin/bash

user=$(whoami)

cd /opt/

sudo npm install pm2@latest -g

pm2 start index.js
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u $user --hp /home/$user
pm2 save
