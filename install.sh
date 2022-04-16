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


# ディレクトリが存在しなければ先にDL
if [ ! -e "$DOTPATH" ]; then
  echo "fetching dotfiles repository..."

  # git が使えるなら git
  if type "git" > /dev/null 2>&1; then
    git clone --recursive "https://github.com/kurupeku/dotfiles.git" "$DOTPATH"

  # 使えない場合は curl か wget を使用する
  elif type "curl" > /dev/null 2>&1 || type "wget" > /dev/null 2>&1; then
    tarball="https://github.com/kurupeku/dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl" > /dev/null 2>&1; then
      curl -L $tarball
    elif type "wget" > /dev/null 2>&1; then
      wget -O - $tarball
    fi | tar zxv

    mv -f dotfiles-master "$DOTPATH"
  else
    die "curl or wget required"
  fi

  cd ~/dotfiles
  if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
  fi

  echo "fetched my dotfiles"
fi


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

# OS固有の処理
if [ $OS = "Mac" ]; then
  brew install iterm2 --cask
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

echo 'installing nerd-fonts...'
# nerd-fontsの導入
if [ ! -e "~/nerd-fonts" ]; then
  cd
  git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts
  ./install.sh
fi

echo "all processes are done"
exec $SHELL -l

