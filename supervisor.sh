#!/usr/bin/env bash
sudo apt-get install supervisor
cp 	supervisord.conf /etc/supervisor/supervisord.conf
sudo service supervisor restart

cd /www/wwwroot/
git clone https://github.com/mlazarov/supervisord-monitor.git

