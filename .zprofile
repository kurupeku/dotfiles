#!/bin/zsh

if [ "$(uname)" = 'Darwin' ] && [ "$(uname -m)" = 'x86_64' ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ "$(uname)" = 'Darwin' ] && [ "$(uname -m)" = 'arm64' ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
fi
