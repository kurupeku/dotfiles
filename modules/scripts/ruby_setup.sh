#!/bin/sh

PACKAGES=$(
  cat <<EOF
solargraph
rubocop
reek
EOF
)

echo "$PACKAGES" | xargs -L 1 -P 4 gem install

if type "asdf" >/dev/null 2>&1; then
  echo "reshim asdf ruby" #コマンドが存在する時の処理
  asdf reshim ruby
fi
