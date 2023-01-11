#!/bin/sh

DOTPATH=$HOME/dotfiles
PACKAGES="bash zsh git gpg"
GUI_APPS="warp raycast"

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

  cd "$HOME/dotfiles" || exit
  if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
  fi

  echo "fetched my dotfiles"
fi

# dotfilesの反映を行う
. "$DOTPATH/setup.sh"

# パッケージマネージャーのセットアップ
echo "installing homebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "run brew upgrade..."
brew upgrade

# パッケージのインストールorアップグレード
echo "installing packages..."
brew upgrade
echo "$PACKAGES" | xargs -L 1 -P 4 brew install

# OSの判定
. "$DOTPATH/modules/scripts/define_os.sh"

# OS固有の処理
if [ "$OS" = "Mac" ]; then
  brew upgrade --cask --greedy
  echo "$GUI_APPS" | xargs -L 1 -P 4 brew install --cask
fi

brew cleanup

# zinitのインストール
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -e "$ZINIT_HOME" ]; then
  echo "installing zinit..."
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# nerd-fontsの導入
if [ ! -e "$HOME/nerd-fonts" ]; then
  echo 'installing nerd-fonts...'
  cd "$HOME" || exit
  git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts || exit
  ./install.sh
  cd "${HOME}/dotfiles" || exit
fi

echo "all processes are done"
exec $SHELL -l
