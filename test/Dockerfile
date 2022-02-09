FROM ubuntu:18.04

# Install Node.js and other dependencies
RUN apt-get update \
  && apt-get install -y curl gnupg build-essential \
  && curl --silent --location https://deb.nodesource.com/setup_17.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && apt-get remove -y --purge cmdtest \
  && apt-get update \
  && apt-get install -y nodejs git python3-pip jq \
  # remove useless files from the current layer
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists.d/* \
  && apt-get autoremove \
  && apt-get clean \
  && apt-get autoclean

# Install AWS CLI
RUN pip3 install awscli

# Install kubectl, helm
RUN curl -L https://dl.k8s.io/release/v1.21.9/bin/linux/amd64/kubectl -o kubectl \
  && echo "195d5387f2a6ca7b8ab5c2134b4b6cc27f29372f54b771947ba7c18ee983fbe6  kubectl" | sha256sum --check \
  && mv kubectl /usr/bin/kubectl && chmod +x /usr/bin/kubectl \
  && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
  && echo "0850e3b71cb80875947f8a1d63fc8c65384f60243969a9d06d2d6c5a1d25ecc6  get_helm.sh" | sha256sum --check \
  && chmod 700 get_helm.sh && ./get_helm.sh && rm -f get_helm.sh \
  && helm repo add stable https://charts.helm.sh/stable

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

ENV CONTENT_DIR="/content"
ENV CLUSTER_NAME=""

ENTRYPOINT ["/bin/bash", "/usr/src/app/run.sh"]