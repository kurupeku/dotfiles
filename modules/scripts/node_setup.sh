#!/bin/sh

# Node npm packages
NPM_PACKAGES=$(
  cat <<EOF
@google/clasp
EOF
)

echo "install global packages for development"
echo "$NPM_PACKAGES" | xargs -L 1 npm i --location=global

if type "asdf" >/dev/null 2>&1; then
  echo "reshim asdf nodejs" #コマンドが存在する時の処理
  asdf reshim nodejs
fi
