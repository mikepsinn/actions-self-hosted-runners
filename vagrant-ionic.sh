#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging

vagrant up || true
vagrant ssh -c 'source /home/vagrant/actions-runners/cd-ionic/run.sh'