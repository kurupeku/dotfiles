#!/bin/sh

DOTPATH=~/dotfiles
VIM_CONF_PATH=$DOTPATH/.vim
NVIM_CONF_PATH=$DOTPATH/.config/nvim
PACKAGES=(
  bash
  zsh
  git
  curl
)

GUI_PACKAGES=(
  iterm2
)

# OSの判定
. $DOTPATH/modules/scripts/define_os.sh

# dotfilesの反映を行う
. $DOTPATH/setup.sh

# パッケージマネージャーのセットアップ
if [ $OS = "Mac" ]; then
  echo "installing homebrew..."
  which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "run brew doctor..."
  which brew >/dev/null 2>&1 && brew doctor

  echo "run brew update..."
  which brew >/dev/null 2>&1 && brew update

  echo "run brew upgrade..."
  brew upgrade
fi

# パッケージのインストールorアップグレード
echo "installing packages..."
for p in "${PACKAGES[@]}"; do
  if [ $OS = "Mac" ]; then
    brew install $p
  fi
done

for p in "${GUI_PACKAGES[@]}"; do
  if [ $OS = "Mac" ]; then
    brew install --cask $p
  fi
done

# パッケージの更新と後片付け
if [ $OS = "Mac" ]; then
  brew upgrade
  brew upgrade --cask --greedy
  brew cleanup
fi

# asdfのインストール
if [ ! -e ~/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
fi

# zinitのインストール
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -e $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

echo 'please restart zsh and execute "p10k configure", if your first installing'

echo "all processes are done."
exec $SHELL -l

