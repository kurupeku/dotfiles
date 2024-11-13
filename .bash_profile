#!/bin/bash

if [ -e "$HOME/.profile" ]; then
  . $HOME/.profile
fi

if [ -e "$HOME/.bash_profile.local" ]; then
  . $HOME/.bash_profile.local
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
