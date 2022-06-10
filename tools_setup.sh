#!/bin/sh

DOTPATH=$HOME/dotfiles

echo "setup languages via asdf..."
. "$DOTPATH/asdf_setup.sh"

# Node npm packages
NPM_PACKAGES=(
  eslint
  prettier
  typescript
  typescript-language-server
  bash-language-server
  remark-language-server
  emmet-ls
  vscode-langservers-extracted
  @tailwindcss/language-server
  yaml-language-server
  graphql-language-service-cli
  intelephense
  dockerfile-language-server-nodejs
  sql-language-server
)

echo "update versions what installed npm packages..."
npm update -g npm
npm update -g

echo "install global packages for development"
npm i -g "${NPM_PACKAGES[@]}"
npm audit fix --force

# Golang packages
GO_PACKAGES=(
  "honnef.co/go/tools/cmd/staticcheck@latest"
  github.com/mvdan/sh/cmd/shfmt@latest
)

echo "install golang packages..."
for p in "${GO_PACKAGES[@]}"; do
  go install "$p"
done
