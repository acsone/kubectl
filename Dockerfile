FROM ubuntu:focal

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

# useful tools
# - bash
# - curl
# - rsync
# - gettext-base, which provides envsubst
# - git
RUN apt-get update && apt-get install -y \
    bash \
    gettext-base \
    gnupg \
    curl \
    rsync \
    openssh-client \
    git \
  && rm -fr /var/lib/apt/lists/*

# kubectl
COPY install/get-kubectl /tmp
RUN /tmp/get-kubectl

# helm 3
COPY install/get-helm-3 /tmp
RUN /tmp/get-helm-3

# salt-ssh
COPY install/get-salt /tmp
RUN /tmp/get-salt

COPY config/99-acsone.conf /etc/ssh/ssh_config.d/
