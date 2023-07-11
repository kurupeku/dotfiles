#!/bin/bash

PACKAGES=$(
  cat <<EOF
git
curl
bash
zsh
unzip
gpg
openssl
build-essential
libyaml-dev
libbz2-dev
libdb-dev
libreadline-dev
libffi-dev
libgdbm-dev
liblzma-dev
libncursesw5-dev
libsqlite3-dev
libssl-dev
zlib1g-dev
uuid-dev
tk-dev
ca-certificates
gnupg
EOF
)

sudo apt-get update && echo "$PACKAGES" | xargs -L 1 sudo apt-get install -y

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
