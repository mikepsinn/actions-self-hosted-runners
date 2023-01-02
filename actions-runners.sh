#!/usr/bin/env bash
# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging
set -x
export RUNNER_ALLOW_RUNASROOT="1"
nohup "/home/vagrant/actions-runners/cd-api/run.sh" &
nohup "/home/vagrant/actions-runners/cd-ionic/run.sh" &
