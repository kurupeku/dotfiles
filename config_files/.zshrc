#!/bin/zsh

# asdf に関する設定
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# 環境変数の設定
. $HOME/dotfiles/modules/rc/env.sh

# PATH 追加
. $HOME/dotfiles/modules/rc/path.sh

# Alias の設定
. $HOME/dotfiles/modules/rc/alias.sh

if [ -e "$HOME/.zshrc.local" ]; then
  . $HOME/.zshrc.local
fi

eval "$(sheldon source)"

# direnv の設定
if hash direnv 2>/dev/null; then
  eval "$(direnv hook zsh)"
fi
