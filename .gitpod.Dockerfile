FROM gitpod/workspace-postgres

RUN sudo apt-get update \
    && sudo apt-get install -y \
        libxmlsec1-dev \
    && sudo rm -rf /var/lib/apt/lists/*
