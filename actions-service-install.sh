#!/usr/bin/env bash

# fail on unset variables and command errors
set -eu -o pipefail # -x: is for debugging
set -x

sudo apt-get update
sudo apt-get install -y jq

sudo usermod -aG docker $USER
echo "You'll probably need to reboot for the docker group to take effect."

OWNER=${OWNER:-mikepsinn}
PAT_TOKEN=${PAT_TOKEN:-$1}
if [ -z "${PAT_TOKEN}" ]; then
  echo "Please set the PAT_TOKEN environment variable or pass it as the first argument to this script."
  exit 1
fi

install() {
  local repo=$1
  local folder=/home/$USER/actions-runners/$repo
  mkdir "/home/$USER/actions-runners/" || true
  mkdir "$folder" || true
  cd "$folder" || exit 1
  curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz || true
  tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz || true

  echo "Cleaning up actions runner..."
  sudo ./svc.sh uninstall || true
  rm -rf .runner || true
  ./config.sh remove || true

  local NAME="gcp-$(hostname)"
  local AUTH_TOKEN=$(curl -s -X POST -H "authorization: token ${PAT_TOKEN}" "https://api.github.com/repos/${OWNER}/${repo}/actions/runners/registration-token" | jq -r .token)

  echo "Configuring up actions runner $NAME for repo $repo..."
  ./config.sh \
    --url "https://github.com/${OWNER}/${repo}" \
    --token "${AUTH_TOKEN}" \
    --name "$NAME" \
    --unattended \
    --work _work \
    --ephemeral \
    --labels cypress,fast,medium

  echo "Installing actions runner service..."
  sudo ./svc.sh install
  echo "Starting actions runner service..."
  sudo ./svc.sh start
}
install curedao-api
install cd-ionic

