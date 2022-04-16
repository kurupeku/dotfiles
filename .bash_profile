#!/bin/sh

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# 自動でtmuxを起動
if [ $SHLVL = 1 ]; then
  tmux
fi

