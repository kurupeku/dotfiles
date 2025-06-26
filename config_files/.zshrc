#!/bin/zsh

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

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

# Starship の有効化
eval "$(starship init zsh)"
