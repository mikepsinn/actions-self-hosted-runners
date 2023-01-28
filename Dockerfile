FROM ibmjava:jre

RUN useradd -m actions

RUN apt-get -yqq update

RUN apt-get install -yqq curl jq wget

RUN \
  LATEST_VERSION_LABEL="$(curl -s -X GET 'https://api.github.com/repos/actions/runner/releases/latest' | jq -r '.tag_name')" \
  RUNNER_VERSION="$(echo ${LATEST_VERSION_LABEL:1})" \
  cd /home/actions && mkdir actions-runner && cd actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

WORKDIR /home/actions/actions-runner
RUN chown -R actions ~actions && /home/actions/actions-runner/bin/installdependencies.sh

USER actions
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
