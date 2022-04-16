#!/bin/sh

DOTPATH=~/dotfiles
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

if [ $OS = "Mac" ]; then
  brew install vim 
  brew install nvim
elif [ $OS = "CentOS" ]; then
  yun install -y vim nvim
elif [ $OS = "Ubuntu" ]; then
  apt install -y vim nvim
fi
