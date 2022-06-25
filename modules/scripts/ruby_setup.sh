#!/bin/sh

PACKAGES=$(
  cat <<EOF
solargraph
rubocop
ruby-debug-ide
debase
EOF
)

echo "$PACKAGES" | xargs -L 1 -P 4 gem install
asdf reshim python
