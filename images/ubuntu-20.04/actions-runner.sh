#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging

cd /home/vagrant/actions-runners/cd-api
export RUNNER_ALLOW_RUNASROOT="1"
./run.sh
nohup ./run.sh &
