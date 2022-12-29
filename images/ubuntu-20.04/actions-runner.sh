#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging

cd /home/vagrant/actions-runners/cd-api
nohup ./run.sh &
