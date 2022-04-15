#!/bin/sh

DOTPATH=~/dotfiles
VIM_CONF_PATH=$DOTPATH/.vim
NVIM_CONF_PATH=$DOTPATH/.config/nvim
PACKAGES=(
  bash
  zsh
  git
  curl
  vim
  neovim
)

# dotfileのシンボリックリンクを作成
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".DS_Store" ] && continue
  [ "$f" = ".config" ] && continue

  ln -snf $DOTPATH/"$f" $HOME/"$f"
  echo "Installed $f"
done

mkdir -p "${DOTPATH}/.config/nvim"
ln -snfv "${DOTPATH}/.vimrc" "${HOME}/.config/nvim/init.vim"

# OSの判定
. $DOTPATH/modules/scripts/define_os.sh

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
    brew install $p || brew upgrade $p
  fi
done

if [ $OS = "Mac" ]; then
  brew cleanup
fi

# zinitのインストール
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

echo "all processes are done."
exec $SHELL -l
