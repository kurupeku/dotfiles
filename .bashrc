#!/bin/bash

# asdf の設定
. "$HOME"/.asdf/asdf.sh
. "$HOME"/.asdf/completions/asdf.bash

# 環境変数の設定
. "$HOME"/dotfiles/modules/rc/env.sh

# Path の設定
. "$HOME"/dotfiles/modules/rc/path.sh

# Alias の設定
. "$HOME"/dotfiles/modules/rc/alias.sh

if [ -e "$HOME/.bashrc.local" ]; then
  . $HOME/.bashrc.local
fi

# direnv の設定
if hash direnv 2>/dev/null; then
  eval "$(direnv hook bash)"
fi
