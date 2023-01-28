FROM ibmjava:jre

RUN useradd -m actions

RUN apt-get -yqq update

RUN apt-get install -yqq curl jq wget

ENV RUNNER_VERSION=2.263.0

RUN \
  cd /home/actions && mkdir actions-runner && cd actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

WORKDIR /home/actions/actions-runner
RUN chown -R actions ~actions && /home/actions/actions-runner/bin/installdependencies.sh

USER actions
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
