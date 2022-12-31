#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging

mkdir /home/vagrant/actions-runners/
mkdir /home/vagrant/actions-runners/cd-api
cd /home/vagrant/actions-runners/cd-api
curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz
tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz

echo "current crontab"
crontab -l > mycron
echo "echo new cron into cron file"
echo "0 * * * * export RUNNER_ALLOW_RUNASROOT=1 && source /home/vagrant/actions-runners/cd-api/run.sh" >> mycron
echo "install new cron file"
crontab mycron
rm mycron
grep CRON /var/log/syslog

echo "get command from https://github.com/mikepsinn/curedao-api/settings/actions/runners/new?arch=x64&os=linux"