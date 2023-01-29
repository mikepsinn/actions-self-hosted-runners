# Use the official lightweight Node.js 18 image.
# https://hub.docker.com/_/node
FROM curedao/php-8.1-apache-buster-xdebug-opcache-composer-pgsql:latest

RUN useradd -m actions

RUN apt-get -yqq update

RUN apt-get install -yqq curl jq wget

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install dependencies.
# If you add a package-lock.json speed your build by switching to 'npm ci'.
# RUN npm ci --only=production
RUN npm install --production

RUN \
    RUNNER_VERSION=2.301.1 \
    && mkdir /usr/src/app/actions-runner && cd /usr/src/app/actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN /usr/src/app/actions-runner/bin/installdependencies.sh

# Copy local code to the container image.
COPY . ./
RUN chmod +x ./entrypoint.sh

# Run the web service on container startup.
#CMD ["node", "index.js"]
ENTRYPOINT ["./entrypoint.sh"]
