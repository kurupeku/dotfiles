#!/bin/bash

# Homebrew がなければインストール
if ! (type "brew" >/dev/null 2>&1); then
  BREW_URL=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  if type "curl" >/dev/null 2>&1; then
    curl -fsSL "$BREW_URL"
  else
    wget -q --trust-server-names "$BREW_URL"
  fi
fi

PACKAGES="bash zsh git gpg openssl curl"
GUI_APPS="warp raycast"

# パッケージマネージャーのセットアップ
echo "installing homebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "run brew upgrade..."
brew upgrade

# パッケージのインストールorアップグレード
echo "installing packages..."
brew upgrade
echo "$PACKAGES" | xargs -L 1 -P 4 brew install

brew upgrade --cask --greedy
echo "$GUI_APPS" | xargs -L 1 -P 4 brew install --cask

brew cleanup
