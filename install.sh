#!/bin/bash

DOTPATH=${HOME}/dotfiles

# ディレクトリが存在しなければ先にDL
if [ ! -e "$DOTPATH" ]; then
  echo "fetching dotfiles repository..."

  # git が使えるなら git
  if type "git" >/dev/null 2>&1; then
    git clone --recursive "https://github.com/kurupeku/dotfiles.git" "$DOTPATH"

  # 使えない場合は終了
  else
    die "'git' command required"
  fi

  echo "fetched my dotfiles"
fi

SCRIPTSPATH=$HOME/dotfiles/modules/scripts
KERNEL=$(uname)

# OS別にパッケージのインストール処理を行う
if [ "$KERNEL" = 'Darwin' ]; then
  . "$SCRIPTSPATH/mac_packages_install.sh"
else
  die "Supported MacOS only"
fi

echo "all processes are done"
exec $SHELL -l
