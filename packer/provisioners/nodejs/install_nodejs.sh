#!/bin/bash

cd ~
sudo curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh
sudo apt install -y nodejs
sudo apt install -y build-essential
node -v
npm -v
