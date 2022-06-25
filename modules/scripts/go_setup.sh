#!/bin/sh

# Golang packages
PACKAGES=$(
  cat <<EOF
golang.org/x/tools/cmd/goimports@latest
honnef.co/go/tools/cmd/staticcheck@latest
github.com/cweill/gotests/gotests@latest
mvdan.cc/gofumpt@latest
github.com/josharian/impl@latest
github.com/haya14busa/goplay/cmd/goplay@latest
golang.org/x/tools/gopls@latest
github.com/fatih/gomodifytags@latest
github.com/mvdan/sh/cmd/shfmt@latest
EOF
)

echo "install golang packages..."
echo "$PACKAGES" | xargs -L 1 -P 4 go install

if type "asdf" >/dev/null 2>&1; then
  echo "reshim asdf golang" #コマンドが存在する時の処理
  asdf reshim golang
fi
