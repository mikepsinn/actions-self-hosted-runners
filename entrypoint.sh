#!/usr/bin/env bash
set -eEuo pipefail


node index.js &

cd /usr/src/app/actions-runner

current_time=$(date +"%I-%M-%p")
NAME="cloud-run-${NAME:-$current_time}"
AUTH_TOKEN=$(curl -s -X POST -H "authorization: token ${PAT_TOKEN}" "https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token" | jq -r .token)

cleanup() {
  echo "Cleaning up actions runner..."
  set -x
  ./config.sh remove --token "${AUTH_TOKEN}"
}

export RUNNER_ALLOW_RUNASROOT="1"
set -x

./config.sh \
  --url "https://github.com/${OWNER}/${REPO}" \
  --token "${AUTH_TOKEN}" \
  --name "${NAME}" \
  --unattended \
  --work _work \
  --ephemeral \
  --labels cypress

#echo "Installing actions runner service..."
#./svc.sh install
#echo "Starting actions runner service..."
#./svc.sh start
#echo "Checking actions runner service status..."
#./svc.sh status

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo "Starting actions runner..."
set -x
./run.sh & wait $!

