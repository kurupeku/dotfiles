#!/bin/bash

DOTPATH=${HOME}/dotfiles

# ディレクトリが存在しなければ先にDL
if [ ! -e "$DOTPATH" ]; then
  echo "fetching dotfiles repository..."

  # git が使えるなら git
  if type "git" >/dev/null 2>&1; then
    git clone --recursive "https://github.com/kurupeku/dotfiles.git" "$DOTPATH"

  # 使えない場合は curl か wget を使用する
  elif type "curl" >/dev/null 2>&1 || type "wget" >/dev/null 2>&1; then
    tarball="https://github.com/kurupeku/dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl" >/dev/null 2>&1; then
      curl -L $tarball
    elif type "wget" >/dev/null 2>&1; then
      wget -O - $tarball
    fi | tar zxv

    mv -f dotfiles-master "$DOTPATH"
  else
    die "curl or wget required"
  fi

  if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
  fi

  echo "fetched my dotfiles"
fi

SCRIPTSPATH=$HOME/dotfiles/modules/scripts
KERNEL=$(uname)

# OS別にパッケージのインストール処理を行う
if [ "$KERNEL" == 'Darwin' ]; then
  . "$SCRIPTSPATH/mac_packages_install.sh"
elif [ "$KERNEL" == 'Linux' ]; then
  . "$SCRIPTSPATH/apt_packages_install.sh"
fi

echo "all processes are done"
exec $SHELL -l
