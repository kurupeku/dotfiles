#!/bin/sh

# Golang packages
GO_PACKAGES=(
  "honnef.co/go/tools/cmd/staticcheck@latest"
  github.com/mvdan/sh/cmd/shfmt@latest
)

echo "install golang packages..."
for p in "${GO_PACKAGES[@]}"; do
  go install "$p"
done
