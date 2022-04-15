#!/bin/sh

# OSの判定
source ./modules/scripts/define_os.sh

# asdfのインストール
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

if [ $OS = "Mac" ]; then
  brew install iterm2 --cask
fi
