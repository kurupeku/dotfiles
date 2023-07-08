#!/bin/bash

PACKAGES="git curl bash zsh gpg openssl build-essential libyaml-dev \
          libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev \
          liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev \
          zlib1g-dev uuid-dev tk-dev"

sudo apt-get update
sudo apt-get install $PACKAGES