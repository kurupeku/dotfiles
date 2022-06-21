#!/bin/sh

# Golang packages
PACKAGES="honnef.co/go/tools/cmd/staticcheck@latest github.com/mvdan/sh/cmd/shfmt@latest"

echo "install golang packages..."
echo "$PACKAGES" | xargs -L 1 -P 4 go install

asdf reshim golang
