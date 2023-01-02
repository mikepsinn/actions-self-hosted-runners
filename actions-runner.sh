#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging


export RUNNER_ALLOW_RUNASROOT="1"
nohup "/home/vagrant/actions-runners/${1}/run.sh" &
