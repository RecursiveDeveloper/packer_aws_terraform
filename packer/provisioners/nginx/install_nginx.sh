#!/bin/bash

sudo apt -y update
sudo apt install -y nginx
sudo systemctl status nginx
