#!/bin/sh

RELEASE_FILE=/etc/os-release
DOTPATH=~/dotfiles
PACKAGES=(
  git
  curl
  vim
  neovim
  gtop
  sqlite
)

# dotfileのシンボリックリンクを作成
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" == ".DS_Store" ] && continue

    ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}"
done

ln -snfv "${DOTPATH}/.bashrc" "${HOME}/.zshrc"

# OSの判定
source ./etc/define_os.sh

# パッケージマネージャーのセットアップ
if [ $OS == "Mac" ]; then
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
for p in "${PACKAGES[@]}"; do
  if [ $OS == "Mac" ]; then
    brew install $p || brew upgrade $p
  fi
done

exec $SHELL -l
