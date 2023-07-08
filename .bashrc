#!/bin/bash

# ctrl+s で出力がロックされてしまうのを防ぐ
stty stop undef

# プロンプトの表示をカスタマイズ
export PS1='\[\033[01;32m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\] '

# これだけコマンド履歴を残す
export HISTSIZE=100000

# asdf の設定
. "$HOME"/.asdf/asdf.sh
. "$HOME"/.asdf/completions/asdf.bash

# 環境変数の設定
. "$HOME"/dotfiles/modules/rc/env.sh

# Pathの設定
. "$HOME"/dotfiles/modules/rc/path.sh

# Aliasの設定
. "$HOME"/dotfiles/modules/rc/alias.sh
