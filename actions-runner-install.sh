#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging
set -x

mkdir /home/vagrant/actions-runners/ || true
mkdir "/home/vagrant/actions-runners/cd-api"
cd /home/vagrant/actions-runners/cd-api
curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz
tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz
cp -R /home/vagrant/actions-runners/cd-api /home/vagrant/actions-runners/cd-ionic

crontab -l > mycron
echo "0 * * * * export RUNNER_ALLOW_RUNASROOT=1 && source /home/vagrant/actions-runners/cd-ionic/run.sh" >> mycron
echo "0 * * * * export RUNNER_ALLOW_RUNASROOT=1 && source /home/vagrant/actions-runners/cd-api/run.sh" >> mycron
crontab mycron
rm mycron
grep CRON /var/log/syslog

echo "get command from https://github.com/mikepsinn/cd-ionic/settings/actions/runners/new?arch=x64&os=linux"
echo "get command from https://github.com/mikepsinn/curedao-api/settings/actions/runners/new?arch=x64&os=linux"

  sudo apt install ntpdate
  sudo ntpdate ntp.ubuntu.com
  sudo timedatectl set-ntp on
  sudo service ntp stop
  sudo ntpd -gq
  sudo service ntp start

  sudo ntpdate ntp.ubuntu.com

