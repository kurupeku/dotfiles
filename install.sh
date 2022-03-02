#!/bin/sh

DOTPATH=~/dotfiles
PACKAGES=(
  git
  curl
  vim
  neovim
  gtop
  sqlite
  asdf
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

ln -snfv "${DOTPATH}/.config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
ln -snfv "${DOTPATH}/.bashrc" "${HOME}/.zshrc"
ln -snfv "${DOTPATH}/.bash_profile" "${HOME}/.zsh_profile"

# OSの判定
. ./modules/scripts/define_os.sh

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

# asdfで言語を導入
echo "installing runtimes..."
. ./modules/scripts/environments.sh

echo "all processes are done."
exec $SHELL -l
