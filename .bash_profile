#!/bin/bash

if [ -e "$HOME/.profile" ] ; then
    . $HOME/.profile
fi

if [ "$(uname -s)" = "Darwin" ]; then
  if [ "$(uname -m)" = 'x86_64' ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ "$(uname -m)" = 'arm64' ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  eval "$(/bin/brew shellenv)"
fi

if [ -e "$HOME/.bashrc" ] ; then
    . "$HOME"/.bashrc
fi
