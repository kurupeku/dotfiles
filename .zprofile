#!/bin/zsh

if [ -e "$HOME/.profile" ]; then
  . $HOME/.profile
fi

if [ -e "$HOME/.zprofile.local" ]; then
  . $HOME/.zprofile.local
fi
