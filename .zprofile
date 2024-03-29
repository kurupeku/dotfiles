#!/bin/zsh

if [ -e "$HOME/.profile" ] ; then
    . $HOME/.profile
fi

if [ "$(uname)" = 'Darwin' ] && [ "$(uname -m)" = 'x86_64' ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ "$(uname)" = 'Darwin' ] && [ "$(uname -m)" = 'arm64' ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -e "$HOME/.zshrc" ] ; then
    . $HOME/.zshrc
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
