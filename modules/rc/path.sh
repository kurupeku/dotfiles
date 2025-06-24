#!/bin/sh

export PATH="$HOME/dotfiles/cmd:$PATH"

# homebrew のパスを追加
if [ "$KERNEL" = 'Darwin' ]; then
  if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi
