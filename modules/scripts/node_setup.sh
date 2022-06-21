#!/bin/sh

# Node npm packages
NPM_PACKAGES=(
  eslint
  tslint
  prettier
  typescript
  typescript-language-server
  bash-language-server
  markdownlint-cli
  emmet-ls
  vscode-langservers-extracted
  @tailwindcss/language-server
  yaml-language-server
  graphql-language-service-cli
  intelephense
  dockerfile-language-server-nodejs
  sql-language-server
  @google/clasp
)

echo "update versions what installed npm packages..."
npm update --location=global npm
npm update --location=global

echo "install global packages for development"
npm i --location=global "${NPM_PACKAGES[@]}"
npm audit fix --force
