#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging

mkdir /home/vagrant/actions-runners/
mkdir /home/vagrant/actions-runners/cd-api
cd /home/vagrant/actions-runners/cd-api
curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz
tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz
echo "get command from https://github.com/mikepsinn/curedao-api/settings/actions/runners/new?arch=x64&os=linux"