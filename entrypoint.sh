#!/usr/bin/env bash
set -eEuo pipefail

current_time=$(date +"%Y%m%d%H%M%S" | tr -d ': ')
NAME="cloud-run-${NAME:-$current_time}"
AUTH_TOKEN=$(curl -s -X POST -H "authorization: token ${PAT_TOKEN}" "https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token" | jq -r .token)

cleanup() {
  ./config.sh remove --token "${AUTH_TOKEN}"
}

./config.sh \
  --url "https://github.com/${OWNER}/${REPO}" \
  --token "${AUTH_TOKEN}" \
  --name "${NAME}" \
  --unattended \
  --work _work

./run.sh
#./svc.sh install
#./svc.sh start
#./svc.sh status


cleanup
