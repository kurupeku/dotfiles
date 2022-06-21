#!/bin/sh

# Node npm packages
NPM_PACKAGES=$(cat << EOF
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
EOF
)

echo "update versions what installed npm packages..."
npm update --location=global npm
npm update --location=global

echo "install global packages for development"
echo "$NPM_PACKAGES" | xargs -L 1 -P 4 npm i --location=global
npm audit fix --force
